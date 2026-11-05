# ==============================================================
# 02_hyperparameter_tuning.R
# Hyperparameter tuning + model optimization.
#
# For each model:
#   1. Try several settings (random search over a grid), train on the
#      TRAIN set (2016-2022) and score on the VALIDATION set (2023-2024).
#   2. Pick the setting with the best PR-AUC (best for rare events).
#   3. Train the model again with that setting and score it on the
#      TEST set (2025-2026) - used only here, once, for the final result.
#      The F1 threshold comes from the validation set, not the test set.
#
# Everything is saved in SQLite:
#   tuning_log    - every setting tried and its score
#   model_results - stage 'baseline' | 'tuned' (validation) | 'test'
#
# Run 01_ml_models.R first, then Source this file.
# ==============================================================

RUN_BASELINES <- FALSE          # load model definitions only (do not retrain baselines)
source("01_ml_models.R")

con <- connect_db(); init_results_table(con)
invisible(dbExecute(con, "
  CREATE TABLE IF NOT EXISTS tuning_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    model_name TEXT, params TEXT, roc_auc REAL, pr_auc REAL, f1 REAL, run_time TEXT
  )"))

# --------------------------------------------------------------
# Search grids (models not listed have no important settings to tune)
# --------------------------------------------------------------
GRIDS <- list(
  tree = expand.grid(cp = c(0.0005, 0.001, 0.005), maxdepth = c(4, 6, 8), minsplit = c(30, 100),
                     KEEP.OUT.ATTRS = FALSE),
  rf   = expand.grid(num.trees = RF_TREES, mtry = c(3, 5, 8), min.node.size = c(5, 20, 50),
                     KEEP.OUT.ATTRS = FALSE),
  et   = expand.grid(num.trees = RF_TREES, mtry = c(3, 5, 8), min.node.size = c(5, 20, 50),
                     KEEP.OUT.ATTRS = FALSE),
  gbm  = expand.grid(n.trees = c(GBM_TREES / 2, GBM_TREES), interaction.depth = c(2, 3, 5),
                     shrinkage = c(0.03, 0.1), n.minobsinnode = 20, KEEP.OUT.ATTRS = FALSE),
  xgb  = expand.grid(nrounds = c(XGB_ROUNDS / 2, XGB_ROUNDS), max_depth = c(3, 4, 6), eta = c(0.03, 0.1),
                     subsample = c(0.7, 1), colsample_bytree = 0.8, min_child_weight = 5,
                     KEEP.OUT.ATTRS = FALSE),
  svm  = expand.grid(cost = c(0.5, 2, 8, 32), gamma = c(0.01, 0.03, 0.1), KEEP.OUT.ATTRS = FALSE),
  knn  = expand.grid(k = c(5, 11, 21, 41, 81)),
  nn   = expand.grid(size = c(4, 8, 16), decay = c(0.001, 0.01, 0.1), maxit = NN_MAXIT,
                     KEEP.OUT.ATTRS = FALSE)
)

# random search: if the grid is bigger than MAX_TRIALS, try a random subset
pick_trials <- function(grid) {
  set.seed(SEED)
  if (nrow(grid) > MAX_TRIALS) grid[sample(nrow(grid), MAX_TRIALS), , drop = FALSE] else grid
}

# --------------------------------------------------------------
# Tune -> final fit -> save
# --------------------------------------------------------------
best_params  <- list()
valid_scores <- list()
test_scores  <- list()
thresholds   <- list()

cat("\n=== HYPERPARAMETER TUNING (selection metric: validation PR-AUC) ===\n")

for (key in names(MODEL_REGISTRY)) {
  spec <- MODEL_REGISTRY[[key]]
  if (key == "xgb" && !HAS_XGB) { cat(sprintf("\n[%s] %s: SKIPPED (package 'xgboost' not installed)\n", key, spec$label)); next }
  cat(sprintf("\n[%s] %s\n", key, spec$label)); flush.console()
  t0 <- Sys.time()
  d  <- training_data_for(key, train)

  chosen <- list()
  if (!is.null(GRIDS[[key]])) {
    grid <- pick_trials(GRIDS[[key]])
    cat(sprintf("  trying %d setting(s)\n", nrow(grid)))
    invisible(dbExecute(con, "DELETE FROM tuning_log WHERE model_name = ?", params = list(spec$label)))
    trials <- list()
    for (i in seq_len(nrow(grid))) {
      p <- as.list(grid[i, , drop = FALSE])
      r <- tryCatch({
        s <- fit_model(key, d, p)$predict(valid)
        evaluate_scores(valid$y, s)
      }, error = function(e) { cat("   trial failed:", conditionMessage(e), "\n"); NULL })
      if (is.null(r)) next
      trials[[length(trials) + 1]] <- list(params = p, pr_auc = r$pr_auc)
      invisible(dbExecute(con, "
        INSERT INTO tuning_log (model_name, params, roc_auc, pr_auc, f1, run_time) VALUES (?, ?, ?, ?, ?, ?)",
        params = list(spec$label, param_string(p), r$roc_auc, r$pr_auc, r$f1,
                      format(Sys.time(), "%Y-%m-%d %H:%M:%S"))))
      cat(sprintf("   %-60s PR-AUC %.4f | ROC-AUC %.3f\n", param_string(p), r$pr_auc, r$roc_auc)); flush.console()
    }
    if (length(trials) > 0) chosen <- trials[[which.max(sapply(trials, function(t) t$pr_auc))]]$params
  } else {
    cat("  nothing important to tune -> default settings\n")
  }

  # final model with the chosen settings
  final  <- fit_model(key, d, chosen)
  sv     <- final$predict(valid); mv <- evaluate_scores(valid$y, sv)
  st     <- final$predict(test);  mt <- evaluate_scores(test$y, st, thr = mv$threshold)
  pstr   <- param_string(modifyList(spec$defaults, chosen))
  if (nchar(pstr) == 0) pstr <- "(no settings)"
  log_result(con, spec$label, "tuned", mv, pstr)
  log_result(con, spec$label, "test",  mt, pstr)

  best_params[[key]]  <- modifyList(spec$defaults, chosen)
  valid_scores[[key]] <- sv
  test_scores[[key]]  <- st
  thresholds[[key]]   <- mv$threshold
  cat(sprintf("  BEST: %s\n  valid PR-AUC %.4f | TEST ROC-AUC %.3f | TEST PR-AUC %.4f | TEST F1 %.3f  (%.0fs)\n",
              pstr, mv$pr_auc, mt$roc_auc, mt$pr_auc, mt$f1,
              as.numeric(difftime(Sys.time(), t0, units = "secs"))))
}

saveRDS(best_params, file.path("results", "best_params.rds"))
saveRDS(list(y = valid$y, scores = valid_scores), file.path("results", "preds_valid_tuned.rds"))
saveRDS(list(y = test$y, scores = test_scores, thresholds = thresholds), file.path("results", "preds_test.rds"))

# --------------------------------------------------------------
# Summary: before vs after tuning, and final test scores
# --------------------------------------------------------------
res <- dbGetQuery(con, "SELECT model_name, stage, roc_auc, pr_auc, f1_score FROM model_results")
base  <- res[res$stage == "baseline", c("model_name", "pr_auc")];  names(base)  <- c("model", "valid_PR_AUC_default")
tuned <- res[res$stage == "tuned",    c("model_name", "pr_auc")];  names(tuned) <- c("model", "valid_PR_AUC_tuned")
tst   <- res[res$stage == "test",     c("model_name", "roc_auc", "pr_auc", "f1_score")]
names(tst) <- c("model", "test_ROC_AUC", "test_PR_AUC", "test_F1")
summary_tbl <- Reduce(function(a, b) merge(a, b, by = "model", all = TRUE), list(base, tuned, tst))
summary_tbl <- summary_tbl[order(-summary_tbl$test_PR_AUC), ]

cat("\n=== SUMMARY: default vs tuned (validation) and final scores (test set) ===\n")
print(format(summary_tbl, digits = 3), row.names = FALSE)
cat("\nRandom guessing on the test set would give PR-AUC of about", round(mean(test$y), 3), "\n")
cat("Saved: results/best_params.rds, results/preds_test.rds, tables model_results + tuning_log in", DB_FILE, "\n")

dbDisconnect(con)
