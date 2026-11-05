# ==============================================================
# 01_ml_models.R
# 11 models that predict Breakout_Next (breakout on the next trading day).
#
# Part A: model definitions (one fit_* function per model).
# Part B: trains every model with default settings, scores it on the
#         VALIDATION set, and saves the scores to SQLite (model_results).
#
# Run this file with Source in RStudio.
# ==============================================================

source("00_setup.R")

prep     <- get_prepared_data()
train    <- prep$train
valid    <- prep$valid
test     <- prep$test
FEATURES <- prep$features

# Features that vary inside BOTH classes (LDA and Naive Bayes need this)
usable_features <- function(d) {
  ok <- sapply(FEATURES, function(f) all(tapply(d[[f]], d$y, sd) > 1e-8))
  FEATURES[ok]
}

# --------------------------------------------------------------
# PART A - model definitions
# Each fit_* function returns list(raw = fitted model, predict = function(newdata))
# predict() always returns the probability of a breakout tomorrow.
# --------------------------------------------------------------

# 1. Logistic Regression - straight-line boundary, gives a probability
fit_logistic <- function(d, p) {
  w <- ifelse(d$y == 1, round(class_weight(d$y)), 1)
  m <- suppressWarnings(glm(reformulate(FEATURES, "y"), data = d, family = binomial(), weights = w))
  list(raw = m, predict = function(nd) as.numeric(suppressWarnings(predict(m, nd, type = "response"))))
}

# 2. Decision Tree - yes/no questions on features, like a flowchart
fit_tree <- function(d, p) {
  w  <- ifelse(d$y == 1, class_weight(d$y), 1)
  d2 <- d[, c("y", FEATURES)]; d2$y <- factor(d2$y, levels = c(0, 1))
  m  <- rpart::rpart(y ~ ., data = d2, weights = w, method = "class",
                     control = rpart::rpart.control(cp = p$cp, maxdepth = p$maxdepth,
                                                    minsplit = p$minsplit, xval = 0))
  list(raw = m, predict = function(nd) as.numeric(predict(m, nd, type = "prob")[, "1"]))
}

# 3 & 4. Random Forest and Extra Trees - many trees vote together
fit_forest <- function(d, p, splitrule) {
  d2 <- d[, c("y", FEATURES)]; d2$y <- factor(d2$y, levels = c(0, 1))
  m  <- ranger::ranger(y ~ ., data = d2, num.trees = p$num.trees, mtry = min(p$mtry, length(FEATURES)),
                       min.node.size = p$min.node.size, class.weights = c(1, class_weight(d$y)),
                       probability = TRUE, splitrule = splitrule, importance = p$importance,
                       num.threads = N_CORES, seed = SEED)
  list(raw = m, predict = function(nd) {
    as.numeric(predict(m, nd[, FEATURES], num.threads = N_CORES)$predictions[, "1"])
  })
}
fit_rf <- function(d, p) fit_forest(d, p, "gini")
fit_et <- function(d, p) fit_forest(d, p, "extratrees")

# 5. Gradient Boosting (gbm) - trees built one after another, each fixing the last one's mistakes
fit_gbm <- function(d, p) {
  set.seed(SEED)                                   # same settings -> same result every time
  w  <- ifelse(d$y == 1, class_weight(d$y), 1)
  m  <- gbm::gbm(y ~ ., data = d[, c("y", FEATURES)], distribution = "bernoulli",
                 n.trees = p$n.trees, interaction.depth = p$interaction.depth,
                 shrinkage = p$shrinkage, n.minobsinnode = p$n.minobsinnode,
                 bag.fraction = 0.7, weights = w, verbose = FALSE, n.cores = 1)
  list(raw = m, predict = function(nd) {
    as.numeric(predict(m, nd[, FEATURES], n.trees = p$n.trees, type = "response"))
  })
}

# 6. XGBoost - faster, regularised version of gradient boosting
fit_xgb <- function(d, p) {
  if (!HAS_XGB) stop("package 'xgboost' is not installed")
  set.seed(SEED)
  dtrain <- xgboost::xgb.DMatrix(data = as.matrix(d[, FEATURES]), label = d$y)
  params <- list(objective = "binary:logistic", eval_metric = "aucpr",
                 max_depth = p$max_depth, eta = p$eta, subsample = p$subsample,
                 colsample_bytree = p$colsample_bytree, min_child_weight = p$min_child_weight,
                 scale_pos_weight = class_weight(d$y), nthread = N_CORES)
  m <- xgboost::xgb.train(params = params, data = dtrain, nrounds = p$nrounds, verbose = 0)
  list(raw = m, predict = function(nd) as.numeric(predict(m, as.matrix(nd[, FEATURES]))))
}

# 7. SVM (radial kernel) - finds the boundary with the widest gap between the classes
fit_svm <- function(d, p) {
  set.seed(SEED)
  m <- e1071::svm(x = as.matrix(d[, FEATURES]), y = factor(d$y, levels = c(0, 1)),
                  kernel = "radial", cost = p$cost, gamma = p$gamma, probability = TRUE)
  list(raw = m, predict = function(nd) {
    pr <- predict(m, as.matrix(nd[, FEATURES]), probability = TRUE)
    as.numeric(attr(pr, "probabilities")[, "1"])
  })
}

# 8. K-Nearest Neighbours - copies the outcome of the K most similar past days
fit_knn <- function(d, p) {
  Xtr <- as.matrix(d[, FEATURES]); cl <- factor(d$y, levels = c(0, 1))
  list(raw = NULL, predict = function(nd) {
    set.seed(SEED)                                 # ties between neighbours are broken at random
    pr <- class::knn(Xtr, as.matrix(nd[, FEATURES]), cl, k = p$k, prob = TRUE)
    pw <- attr(pr, "prob")
    as.numeric(ifelse(pr == "1", pw, 1 - pw))
  })
}

# 9. Naive Bayes - probabilities, assuming features are independent
fit_nb <- function(d, p) {
  f <- usable_features(d)
  m <- e1071::naiveBayes(x = d[, f], y = factor(d$y, levels = c(0, 1)), laplace = p$laplace)
  list(raw = m, predict = function(nd) {
    s <- predict(m, nd[, f], type = "raw")[, "1"]
    s[is.na(s)] <- 0
    as.numeric(s)
  })
}

# 10. Linear Discriminant Analysis - best linear combination that separates the classes
fit_lda <- function(d, p) {
  f  <- usable_features(d)
  d2 <- d[, c("y", f)]; d2$y <- factor(d2$y, levels = c(0, 1))
  m  <- MASS::lda(y ~ ., data = d2)
  list(raw = m, predict = function(nd) as.numeric(predict(m, nd[, f])$posterior[, "1"]))
}

# 11. Neural Network (MLP, one hidden layer) - layers of connected nodes learn non-linear patterns
fit_nn <- function(d, p) {
  set.seed(SEED)
  m <- nnet::nnet(reformulate(FEATURES, "y"), data = d, size = p$size, decay = p$decay,
                  maxit = p$maxit, entropy = TRUE, MaxNWts = 20000, trace = FALSE)
  list(raw = m, predict = function(nd) as.numeric(predict(m, nd[, FEATURES], type = "raw")))
}

# --------------------------------------------------------------
# Registry: label, fit function, which training data, default settings
#   data = "full" -> all training rows,  "down" -> downsampled (for slow models)
# --------------------------------------------------------------
MTRY_DEFAULT <- max(2, floor(sqrt(length(FEATURES))))

MODEL_REGISTRY <- list(
  logistic = list(label = "Logistic Regression", fit = fit_logistic, data = "full", defaults = list()),
  tree     = list(label = "Decision Tree",       fit = fit_tree,     data = "full",
                  defaults = list(cp = 0.001, maxdepth = 6, minsplit = 50)),
  rf       = list(label = "Random Forest",       fit = fit_rf,       data = "full",
                  defaults = list(num.trees = RF_TREES, mtry = MTRY_DEFAULT, min.node.size = 10, importance = "none")),
  et       = list(label = "Extra Trees",         fit = fit_et,       data = "full",
                  defaults = list(num.trees = RF_TREES, mtry = MTRY_DEFAULT, min.node.size = 10, importance = "none")),
  gbm      = list(label = "Gradient Boosting (GBM)", fit = fit_gbm,  data = "full",
                  defaults = list(n.trees = GBM_TREES, interaction.depth = 3, shrinkage = 0.05, n.minobsinnode = 20)),
  xgb      = list(label = "XGBoost",             fit = fit_xgb,      data = "full",
                  defaults = list(nrounds = XGB_ROUNDS, max_depth = 4, eta = 0.05, subsample = 0.8,
                                  colsample_bytree = 0.8, min_child_weight = 5)),
  svm      = list(label = "SVM (radial)",        fit = fit_svm,      data = "down",
                  defaults = list(cost = 1, gamma = 1 / length(FEATURES))),
  knn      = list(label = "K-Nearest Neighbours", fit = fit_knn,     data = "down",
                  defaults = list(k = 25)),
  nb       = list(label = "Naive Bayes",         fit = fit_nb,       data = "full",
                  defaults = list(laplace = 0)),
  lda      = list(label = "Linear Discriminant Analysis", fit = fit_lda, data = "full", defaults = list()),
  nn       = list(label = "Neural Network (MLP)", fit = fit_nn,      data = "down",
                  defaults = list(size = 8, decay = 0.01, maxit = NN_MAXIT))
)

fit_model <- function(key, d, params = list()) {
  spec <- MODEL_REGISTRY[[key]]
  spec$fit(d, modifyList(spec$defaults, params))
}
training_data_for <- function(key, train_df) {
  if (MODEL_REGISTRY[[key]]$data == "down") downsample(train_df) else train_df
}

# --------------------------------------------------------------
# PART B - train every model with default settings (baseline)
# Set  RUN_BASELINES <- FALSE  before sourcing to load only Part A
# (script 02 does this).
# --------------------------------------------------------------
if (!exists("RUN_BASELINES") || isTRUE(RUN_BASELINES)) {

  con <- connect_db(); init_results_table(con)
  valid_scores <- list()
  cat("\n=== BASELINE: all models with default settings (scored on the validation set) ===\n")

  for (key in names(MODEL_REGISTRY)) {
    spec <- MODEL_REGISTRY[[key]]
    cat(sprintf("\n[%s] %s ... ", key, spec$label)); flush.console()
    if (key == "xgb" && !HAS_XGB) { cat("SKIPPED (package 'xgboost' not installed)\n"); next }
    t0 <- Sys.time()
    s <- tryCatch({
      mdl <- fit_model(key, training_data_for(key, train))
      mdl$predict(valid)
    }, error = function(e) { cat("FAILED:", conditionMessage(e), "\n"); NULL })
    if (is.null(s)) next

    m <- evaluate_scores(valid$y, s)                 # threshold = best F1 on validation
    log_result(con, spec$label, "baseline", m, param_string(spec$defaults))
    valid_scores[[key]] <- s
    cat(sprintf("done in %.0fs | ROC-AUC %.3f | PR-AUC %.3f | F1 %.3f\n",
                as.numeric(difftime(Sys.time(), t0, units = "secs")), m$roc_auc, m$pr_auc, m$f1))
  }

  saveRDS(list(y = valid$y, scores = valid_scores), file.path("results", "preds_valid_baseline.rds"))

  cat("\n=== Baseline results (validation set) ===\n")
  res <- dbGetQuery(con, "SELECT model_name, roc_auc, pr_auc, precision, recall, f1_score
                          FROM model_results WHERE stage = 'baseline' ORDER BY pr_auc DESC")
  print(format(res, digits = 3), row.names = FALSE)
  cat("\nRandom guessing would give PR-AUC of about", round(mean(valid$y), 3), "(= share of breakout days).\n")
  
}

