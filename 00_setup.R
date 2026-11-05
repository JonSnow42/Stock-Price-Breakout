# ==============================================================
# 00_setup.R
# Shared settings, database helpers, data preparation
# (feature engineering + feature selection + scaling) and metrics.
#
# You do NOT run this file directly. Scripts 01, 02 and 03 call it
# with  source("00_setup.R").
# ==============================================================

# ---------- 0. Packages ----------
required_pkgs <- c("DBI", "RSQLite", "dplyr", "ggplot2", "pROC",
                   "ranger", "gbm", "e1071", "rpart", "class", "nnet", "MASS")
missing_pkgs <- setdiff(required_pkgs, rownames(installed.packages()))
if (length(missing_pkgs) > 0) {
  stop("Missing packages. Run this once in the R console, then try again:\n  install.packages(c(",
       paste0('"', missing_pkgs, '"', collapse = ", "), "))", call. = FALSE)
}
suppressPackageStartupMessages({
  library(DBI)
  library(RSQLite)
  library(dplyr)
})
HAS_XGB <- requireNamespace("xgboost", quietly = TRUE)
if (!HAS_XGB) message("Note: package 'xgboost' is not installed -> XGBoost will be skipped.")

# ---------- 1. Settings (edit here) ----------
DB_FILE          <- "stocks.db"       # your SQLite database
DATA_TABLE       <- "stock_data"      # table created in the database-connectivity step
TARGET           <- "Breakout_Next"   # what we predict: breakout on the NEXT trading day
VALID_START      <- "2023-01-01"      # train < VALID_START <= valid < TEST_START <= test
TEST_START       <- "2025-01-01"
CORR_CUTOFF      <- 0.90              # feature selection: drop one of two features correlated above this
DOWNSAMPLE_RATIO <- 4                 # slow models (SVM/KNN/NN) see 4 non-breakout days per breakout day
SEED             <- 42
QUICK_MODE       <- FALSE             # TRUE = fast dry run (fewer trees / fewer tuning trials)
N_CORES          <- max(1, parallel::detectCores() - 1)

if (QUICK_MODE) {
  RF_TREES <- 100; GBM_TREES <- 100; XGB_ROUNDS <- 100; NN_MAXIT <- 100; MAX_TRIALS <- 3
} else {
  RF_TREES <- 300; GBM_TREES <- 300; XGB_ROUNDS <- 300; NN_MAXIT <- 300; MAX_TRIALS <- 6
}

for (d in c("cache", "results", "results/plots")) dir.create(d, showWarnings = FALSE, recursive = TRUE)

# ---------- 2. Database helpers ----------
connect_db <- function() dbConnect(RSQLite::SQLite(), dbname = DB_FILE)

# Creates model_results if needed (same columns you created) and adds 3 extra columns
init_results_table <- function(con) {
  dbExecute(con, "
    CREATE TABLE IF NOT EXISTS model_results (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      model_name TEXT NOT NULL,
      target TEXT,
      roc_auc REAL,
      pr_auc REAL,
      precision REAL,
      recall REAL,
      f1_score REAL,
      experiment_date TEXT
    )")
  extra <- c(stage = "TEXT", threshold = "REAL", params = "TEXT")
  for (nm in setdiff(names(extra), dbListFields(con, "model_results"))) {
    dbExecute(con, sprintf("ALTER TABLE model_results ADD COLUMN %s %s", nm, extra[[nm]]))
  }
  invisible(TRUE)
}

# Saves one row of scores (replaces an older row of the same model + stage)
log_result <- function(con, model_name, stage, m, param_text = "") {
  dbExecute(con, "DELETE FROM model_results WHERE model_name = ? AND stage = ?",
            params = list(model_name, stage))
  dbExecute(con, "
    INSERT INTO model_results
      (model_name, target, roc_auc, pr_auc, precision, recall, f1_score, experiment_date, stage, threshold, params)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
    params = list(model_name, TARGET, m$roc_auc, m$pr_auc, m$precision, m$recall, m$f1,
                  format(Sys.time(), "%Y-%m-%d %H:%M:%S"), stage, m$threshold, param_text))
}

# ---------- 3. Small rolling-window helpers (base R, no extra packages) ----------
roll_mean <- function(x, k) {
  n <- length(x); out <- rep(NA_real_, n)
  if (n >= k) {
    cs <- cumsum(c(0, x))
    out[k:n] <- (cs[(k + 1):(n + 1)] - cs[1:(n - k + 1)]) / k
  }
  out
}
roll_max_prior <- function(x, k) {          # highest value of the previous k days (today excluded)
  n <- length(x); out <- rep(NA_real_, n)
  if (n > k) for (i in (k + 1):n) out[i] <- max(x[(i - k):(i - 1)])
  out
}
ema <- function(x, span) {                  # exponential moving average
  a <- 2 / (span + 1)
  as.numeric(stats::filter(a * x, 1 - a, method = "recursive", init = x[1]))
}

# ---------- 4. Feature engineering ----------
# Every feature at row t only uses information available up to day t.
NUM_FEATURES <- c("Daily_Return", "Return_lag1", "Return_5d", "Return_10d",
                  "Volatility_20", "RSI_14", "Log_Vol_Ratio", "Dist_High_20",
                  "Price_vs_SMA20", "Price_vs_SMA50", "SMA20_vs_SMA50",
                  "Range_Pct", "ATR_Pct", "MACD_Pct", "BB_Width",
                  "Breakout_Today", "Breakout_Count_20")

build_features <- function(con) {
  raw <- dbGetQuery(con, sprintf("SELECT * FROM %s", DATA_TABLE))
  names(raw) <- gsub("[^A-Za-z0-9_]", "_", names(raw))          # "Adj.Close" -> "Adj_Close"
  raw$Date <- as.Date(raw$Date)
  sec <- grep("^Sector_", names(raw), value = TRUE)
  raw[sec] <- lapply(raw[sec], function(x) as.integer(x %in% c("True", "TRUE", "1")))

  raw %>%
    arrange(Ticker, Date) %>%
    group_by(Ticker) %>%
    mutate(
      # Breakout label recomputed on ADJUSTED close (the DA1 definition):
      # today's adjusted close > highest adjusted close of the previous 20 days
      # AND today's volume > 1.5 x the 20-day average volume
      High_20_prior     = roll_max_prior(Adj_Close, 20),
      Breakout_Today    = as.integer(Adj_Close > High_20_prior & Volume > 1.5 * Avg_Volume_20),
      Breakout_Next     = lead(Breakout_Today),                 # TARGET: breakout on the next trading day
      bt0               = ifelse(is.na(Breakout_Today), 0L, Breakout_Today),
      # engineered features
      Log_Vol_Ratio     = log(pmax(Volume, 1) / pmax(Avg_Volume_20, 1)),
      Dist_High_20      = Adj_Close / High_20_prior - 1,
      Price_vs_SMA20    = Adj_Close / SMA_20 - 1,
      Price_vs_SMA50    = Adj_Close / SMA_50 - 1,
      SMA20_vs_SMA50    = SMA_20 / SMA_50 - 1,
      Return_lag1       = lag(Daily_Return, 1),
      Return_5d         = Adj_Close / lag(Adj_Close, 5) - 1,
      Return_10d        = Adj_Close / lag(Adj_Close, 10) - 1,
      Range_Pct         = (High - Low) / Close,
      ATR_Pct           = roll_mean(Range_Pct, 14),
      MACD_Pct          = (ema(Adj_Close, 12) - ema(Adj_Close, 26)) / Adj_Close,
      BB_Width          = 4 * sqrt(pmax(roll_mean(Adj_Close^2, 20) - roll_mean(Adj_Close, 20)^2, 0)) /
                          roll_mean(Adj_Close, 20),
      Breakout_Count_20 = roll_mean(bt0, 20) * 20,
      .rn               = row_number()
    ) %>%
    ungroup() %>%
    filter(.rn > 30, !is.na(Breakout_Next)) %>%                 # drop warm-up rows + last day of each stock
    as.data.frame()
}

# ---------- 5. Feature selection (uses TRAIN data only) ----------
drop_correlated <- function(X, cutoff) {
  cm <- abs(cor(X)); diag(cm) <- 0
  out <- data.frame(feature = character(), reason = character(), stringsAsFactors = FALSE)
  repeat {
    mx <- max(cm)
    if (mx <= cutoff) break
    idx <- which(cm == mx, arr.ind = TRUE)[1, ]
    a <- idx[1]; b <- idx[2]
    d <- if (mean(cm[a, ]) >= mean(cm[b, ])) a else b            # drop the more "redundant" one
    o <- if (d == a) b else a
    out[nrow(out) + 1, ] <- list(colnames(cm)[d],
                                 sprintf("correlated with %s (|r| = %.2f)", colnames(cm)[o], mx))
    cm[d, ] <- 0; cm[, d] <- 0
  }
  out
}

select_features <- function(train_df, candidates, cutoff = CORR_CUTOFF) {
  X <- train_df[, candidates]
  sds <- sapply(X, sd)
  const <- names(sds)[is.na(sds) | sds < 1e-8]
  log_const <- data.frame(feature = const, reason = rep("no variation", length(const)), stringsAsFactors = FALSE)
  keep <- setdiff(candidates, const)
  log_corr <- drop_correlated(X[, keep], cutoff)
  keep <- setdiff(keep, log_corr$feature)
  list(features = keep, dropped = rbind(log_const, log_corr))
}

# ---------- 6. Prepare everything once and cache it ----------
get_prepared_data <- function(force = FALSE) {
  cache_file <- file.path("cache", "prepared_data.rds")
  if (!force && file.exists(cache_file)) {
    message("Loading prepared data from cache/prepared_data.rds (delete it to rebuild)")
    return(readRDS(cache_file))
  }
  cat("Preparing data: feature engineering, split, feature selection, scaling ...\n")
  con <- connect_db(); on.exit(dbDisconnect(con))
  feat <- build_features(con)

  sector_feats <- setdiff(grep("^Sector_", names(feat), value = TRUE), "Sector_Utilities")  # 1 dummy dropped (reference)
  candidates   <- c(NUM_FEATURES, sector_feats)
  feat <- feat[complete.cases(feat[, c(candidates, "Breakout_Next")]), ]
  feat$y <- as.numeric(feat$Breakout_Next)
  feat$split <- ifelse(feat$Date < as.Date(VALID_START), "train",
                       ifelse(feat$Date < as.Date(TEST_START), "valid", "test"))

  # store the engineered table in SQLite
  out <- feat[, c("Date", "Ticker", "split", "y", candidates)]
  out$Date <- as.character(out$Date)
  dbWriteTable(con, "model_features", out, overwrite = TRUE)

  tr  <- feat[feat$split == "train", ]
  sel <- select_features(tr, candidates)
  mu  <- sapply(tr[, sel$features], mean)
  sdv <- sapply(tr[, sel$features], sd)

  scale_df <- function(df) {                       # z-score with TRAIN mean/sd, clipped to [-5, 5]
    X <- df[, sel$features]
    for (f in sel$features) X[[f]] <- pmin(pmax((X[[f]] - mu[[f]]) / sdv[[f]], -5), 5)
    cbind(df[, c("Date", "Ticker", "y")], X)
  }
  prep <- list(train = scale_df(feat[feat$split == "train", ]),
               valid = scale_df(feat[feat$split == "valid", ]),
               test  = scale_df(feat[feat$split == "test", ]),
               features = sel$features, dropped = sel$dropped, candidates = candidates)
  saveRDS(prep, cache_file)
  write.csv(sel$dropped, file.path("results", "feature_selection_dropped.csv"), row.names = FALSE)

  cat("\n=== Data preparation summary ===\n")
  print(data.frame(split = c("train", "valid", "test"),
                   rows = sapply(prep[c("train", "valid", "test")], nrow),
                   breakouts = sapply(prep[c("train", "valid", "test")], function(d) sum(d$y)),
                   breakout_pct = round(100 * sapply(prep[c("train", "valid", "test")], function(d) mean(d$y)), 2),
                   row.names = NULL))
  cat("\nCandidate features:", length(candidates), "| kept after selection:", length(sel$features), "\n")
  cat("Kept   :", paste(sel$features, collapse = ", "), "\n")
  cat("Dropped:\n"); print(sel$dropped, row.names = FALSE)
  prep
}

# ---------- 7. Sampling helpers ----------
class_weight <- function(y) sqrt(sum(y == 0) / sum(y == 1))    # moderate extra weight for breakout days

downsample <- function(df, ratio = DOWNSAMPLE_RATIO, seed = SEED) {
  set.seed(seed)
  pos <- which(df$y == 1); neg <- which(df$y == 0)
  keep_neg <- sample(neg, min(length(neg), ratio * length(pos)))
  df[sort(c(pos, keep_neg)), ]
}

# ---------- 8. Metrics ----------
# PR-AUC = average precision (area under the precision-recall curve)
pr_auc <- function(y, p) {
  ord <- order(p, decreasing = TRUE); ys <- y[ord]; ps <- p[ord]
  tp <- cumsum(ys); fp <- cumsum(1 - ys)
  last <- c(ps[-length(ps)] != ps[-1], TRUE)
  tp <- tp[last]; fp <- fp[last]
  sum(diff(c(0, tp / sum(y))) * (tp / (tp + fp)))
}

# score cut-off that gives the best F1 (choose it on VALIDATION data)
best_f1_threshold <- function(y, p) {
  ord <- order(p, decreasing = TRUE); ys <- y[ord]; ps <- p[ord]
  tp <- cumsum(ys); fp <- cumsum(1 - ys); fn <- sum(ys) - tp
  f1 <- 2 * tp / (2 * tp + fp + fn)
  last <- c(ps[-length(ps)] != ps[-1], TRUE)
  f1[!last] <- -1
  ps[which.max(f1)]
}

# thr = NULL -> pick the best-F1 threshold on this data; otherwise use the given one
evaluate_scores <- function(y, p, thr = NULL) {
  roc_auc <- tryCatch(as.numeric(pROC::auc(pROC::roc(y, p, levels = c(0, 1), direction = "<", quiet = TRUE))),
                      error = function(e) 0.5)
  if (is.null(thr)) thr <- best_f1_threshold(y, p)
  pred <- as.integer(p >= thr)
  tp <- sum(pred == 1 & y == 1); fp <- sum(pred == 1 & y == 0); fn <- sum(pred == 0 & y == 1); tn <- sum(pred == 0 & y == 0)
  precision <- if (tp + fp == 0) 0 else tp / (tp + fp)
  recall    <- if (tp + fn == 0) 0 else tp / (tp + fn)
  f1        <- if (precision + recall == 0) 0 else 2 * precision * recall / (precision + recall)
  data.frame(roc_auc = roc_auc, pr_auc = pr_auc(y, p), precision = precision, recall = recall,
             f1 = f1, threshold = thr, tp = tp, fp = fp, fn = fn, tn = tn)
}

param_string <- function(p) paste(names(p), unlist(p), sep = "=", collapse = ", ")

