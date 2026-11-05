# ==============================================================
# 03_model_comparison_visualization.R
# Compares all models and draws the report figures:
#   1. ROC curves (all models, test set)
#   2. Precision-Recall curves (all models, test set)
#   3. Metric comparison bars (test set)
#   4. Default vs tuned PR-AUC (validation set)
#   5. Feature importance (Random Forest, Gradient Boosting, XGBoost)
#   6. Confusion matrix of the best model
# Every plot is shown in the RStudio Plots pane AND saved in results/plots/.
#
# Run 01_ml_models.R and 02_hyperparameter_tuning.R first.
# ==============================================================

RUN_BASELINES <- FALSE
source("01_ml_models.R")
library(ggplot2)

stopifnot(file.exists("results/preds_valid_baseline.rds"))
preds  <- readRDS("results/preds_test.rds")
best   <- readRDS("results/best_params.rds")
y_test <- preds$y
keys   <- names(preds$scores)
labels <- sapply(MODEL_REGISTRY, function(s) s$label)

con <- connect_db()
res <- dbGetQuery(con, "SELECT model_name, stage, roc_auc, pr_auc, precision, recall, f1_score, threshold, params
                        FROM model_results")
dbDisconnect(con)
test_res <- res[res$stage == "test", ]
test_res <- test_res[order(-test_res$pr_auc), ]

save_plot <- function(p, file, w = 9, h = 6) {
  print(p)
  ggsave(file.path("results", "plots", file), p, width = w, height = h, dpi = 150, bg = "white")
}
theme_rep <- theme_minimal(base_size = 12) +
  theme(plot.title = element_text(face = "bold"), plot.subtitle = element_text(color = "grey40"))

model_levels <- test_res$model_name                       # best PR-AUC first
pal <- setNames(hcl.colors(length(model_levels), "Dark 3"), model_levels)

# ---------- 0. Final table ----------
final_tbl <- test_res[, c("model_name", "roc_auc", "pr_auc", "precision", "recall", "f1_score")]
names(final_tbl) <- c("Model", "ROC_AUC", "PR_AUC", "Precision", "Recall", "F1")
write.csv(final_tbl, file.path("results", "final_comparison_table.csv"), row.names = FALSE)
cat("\n=== FINAL COMPARISON (test set, 2025-2026) ===\n")
print(format(final_tbl, digits = 3), row.names = FALSE)
cat("Random guessing: PR-AUC about", round(mean(y_test), 3), " | ROC-AUC 0.5\n")

# ---------- 1. ROC curves ----------
roc_df <- do.call(rbind, lapply(keys, function(k) {
  r <- pROC::roc(y_test, preds$scores[[k]], levels = c(0, 1), direction = "<", quiet = TRUE)
  data.frame(model = labels[[k]], fpr = 1 - r$specificities, tpr = r$sensitivities)
}))
roc_df$legend <- sprintf("%s (AUC %.3f)", roc_df$model, test_res$roc_auc[match(roc_df$model, test_res$model_name)])
leg_levels <- sprintf("%s (AUC %.3f)", test_res$model_name, test_res$roc_auc)
roc_df$legend <- factor(roc_df$legend, levels = leg_levels)
p1 <- ggplot(roc_df, aes(fpr, tpr, color = legend)) +
  geom_line(linewidth = 0.8) +
  geom_abline(linetype = "dashed", color = "grey50") +
  scale_color_manual(values = setNames(unname(pal), leg_levels), name = NULL) +
  labs(title = "ROC Curves - All Models (Test Set)",
       subtitle = "Higher and further left is better; dashed line = random guessing",
       x = "False Positive Rate", y = "True Positive Rate") +
  coord_equal() + theme_rep
save_plot(p1, "01_roc_curves_test.png", 9.5, 7)

# ---------- 2. Precision-Recall curves ----------
pr_curve <- function(y, p) {
  ord <- order(p, decreasing = TRUE); ys <- y[ord]; ps <- p[ord]
  tp <- cumsum(ys); fp <- cumsum(1 - ys)
  last <- c(ps[-length(ps)] != ps[-1], TRUE)
  data.frame(recall = (tp / sum(y))[last], precision = (tp / (tp + fp))[last])
}
pr_df <- do.call(rbind, lapply(keys, function(k) {
  d <- pr_curve(y_test, preds$scores[[k]]); d$model <- labels[[k]]; d
}))
pr_df$legend <- sprintf("%s (PR-AUC %.3f)", pr_df$model, test_res$pr_auc[match(pr_df$model, test_res$model_name)])
pr_levels <- sprintf("%s (PR-AUC %.3f)", test_res$model_name, test_res$pr_auc)
pr_df$legend <- factor(pr_df$legend, levels = pr_levels)
p2 <- ggplot(pr_df, aes(recall, precision, color = legend)) +
  geom_line(linewidth = 0.8) +
  geom_hline(yintercept = mean(y_test), linetype = "dashed", color = "grey50") +
  scale_color_manual(values = setNames(unname(pal), pr_levels), name = NULL) +
  labs(title = "Precision-Recall Curves - All Models (Test Set)",
       subtitle = "Better than ROC when breakouts are rare; dashed line = random guessing",
       x = "Recall (share of real breakouts caught)", y = "Precision (share of alerts that were right)") +
  coord_cartesian(ylim = c(0, max(0.5, max(pr_df$precision[pr_df$recall > 0.05])))) + theme_rep
save_plot(p2, "02_precision_recall_curves_test.png", 9.5, 6.5)

# ---------- 3. Metric comparison bars ----------
long <- data.frame(model  = rep(test_res$model_name, 3),
                   metric = rep(c("ROC-AUC", "PR-AUC", "F1"), each = nrow(test_res)),
                   value  = c(test_res$roc_auc, test_res$pr_auc, test_res$f1_score))
long$model  <- factor(long$model, levels = rev(model_levels))
long$metric <- factor(long$metric, levels = c("ROC-AUC", "PR-AUC", "F1"))
p3 <- ggplot(long, aes(value, model, fill = metric)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = sprintf("%.3f", value)), hjust = -0.1, size = 3) +
  facet_wrap(~metric, scales = "free_x") +
  scale_fill_manual(values = c("ROC-AUC" = "#2166AC", "PR-AUC" = "#B2182B", "F1" = "#1A9850")) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.25))) +
  labs(title = "Model Comparison on the Test Set (sorted by PR-AUC)", x = NULL, y = NULL) + theme_rep +
  theme(panel.spacing.x = unit(1.5, "lines"))
save_plot(p3, "03_model_comparison_test.png", 11, 6)

# ---------- 4. Default vs tuned ----------
ba <- res[res$stage %in% c("baseline", "tuned"), c("model_name", "stage", "pr_auc")]
ba$stage <- factor(ifelse(ba$stage == "baseline", "Default settings", "Tuned"), levels = c("Default settings", "Tuned"))
ba$model_name <- factor(ba$model_name, levels = rev(model_levels))
p4 <- ggplot(ba, aes(pr_auc, model_name, fill = stage)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  scale_fill_manual(values = c("Default settings" = "grey65", "Tuned" = "#2166AC"), name = NULL) +
  labs(title = "Effect of Hyperparameter Tuning (Validation Set)",
       subtitle = "PR-AUC before and after tuning; models without tunable settings stay the same",
       x = "PR-AUC", y = NULL) + theme_rep + theme(legend.position = "bottom")
save_plot(p4, "04_tuning_improvement.png", 9, 6)

# ---------- 5. Feature importance ----------
imp <- list()
m_rf <- fit_model("rf", train, modifyList(best$rf, list(importance = "impurity")))
v <- ranger::importance(m_rf$raw)
imp[["Random Forest"]] <- data.frame(feature = names(v), importance = 100 * v / sum(v))

m_gbm <- fit_model("gbm", train, best$gbm)
s <- summary(m_gbm$raw, n.trees = best$gbm$n.trees, plotit = FALSE)
imp[["Gradient Boosting"]] <- data.frame(feature = as.character(s$var), importance = s$rel.inf)

if (HAS_XGB && !is.null(best$xgb)) {
  tryCatch({
    m_x <- fit_model("xgb", train, best$xgb)
    xi  <- xgboost::xgb.importance(model = m_x$raw)
    imp[["XGBoost"]] <- data.frame(feature = xi$Feature, importance = 100 * xi$Gain / sum(xi$Gain))
  }, error = function(e) message("XGBoost importance skipped: ", conditionMessage(e)))
}

imp_df <- do.call(rbind, lapply(names(imp), function(n) cbind(model = n, imp[[n]])))
imp_df <- imp_df %>% group_by(model) %>% slice_max(importance, n = 12, with_ties = FALSE) %>% ungroup() %>% as.data.frame()
imp_df$key <- factor(paste(imp_df$model, imp_df$feature, sep = "___"),
                     levels = unique(paste(imp_df$model, imp_df$feature, sep = "___")[order(imp_df$model, imp_df$importance)]))
p5 <- ggplot(imp_df, aes(importance, key)) +
  geom_col(fill = "#2166AC") +
  facet_wrap(~model, scales = "free_y") +
  scale_y_discrete(labels = function(x) sub("^.*___", "", x)) +
  labs(title = "Feature Importance (top 12 features per model)",
       subtitle = "Which inputs the models rely on most to predict tomorrow's breakout",
       x = "Importance (%)", y = NULL) + theme_rep
save_plot(p5, "05_feature_importance.png", 4 * length(imp) + 2, 5.5)
write.csv(imp_df[, c("model", "feature", "importance")], file.path("results", "feature_importance.csv"), row.names = FALSE)

# ---------- 6. Confusion matrix of the best model ----------
best_name <- test_res$model_name[1]
best_key  <- names(labels)[match(best_name, labels)]
thr       <- preds$thresholds[[best_key]]
pred      <- as.integer(preds$scores[[best_key]] >= thr)
cm <- as.data.frame(table(Actual = factor(y_test, levels = c(0, 1)), Predicted = factor(pred, levels = c(0, 1))))
cm$Actual    <- factor(ifelse(cm$Actual == 1, "Breakout", "No breakout"), levels = c("No breakout", "Breakout"))
cm$Predicted <- factor(ifelse(cm$Predicted == 1, "Breakout", "No breakout"), levels = c("No breakout", "Breakout"))
p6 <- ggplot(cm, aes(Predicted, Actual, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(aes(label = format(Freq, big.mark = ",")), size = 6) +
  scale_fill_gradient(low = "#EAF0F6", high = "#6FA8DC", guide = "none") +
  labs(title = paste("Confusion Matrix -", best_name, "(Test Set)"),
       subtitle = sprintf("Alert threshold %.3f (chosen on the validation set)", thr)) + theme_rep
save_plot(p6, "06_confusion_matrix_best_model.png", 6.5, 5)

cat("\nPlots saved in results/plots/ ; tables saved in results/\n")
cat("Best model on the test set (by PR-AUC):", best_name, "\n")
