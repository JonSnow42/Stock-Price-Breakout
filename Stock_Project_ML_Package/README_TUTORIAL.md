# Stock Project ML Implementation Tutorial (RStudio on Fedora)

## What this package contains
- `01_train_12_models.R`: creates a next-trading-day target and trains 12 baseline classifiers.
- `02_compare_visualize.R`: compares validation metrics and saves charts.
- `03_tune_optimize.R`: tunes five candidate models, chooses a threshold on validation data, then evaluates the selected model on the untouched test period.

## Before starting
Your files should be here:
`/home/saurabh/Stock_Project/processed_dataset.csv`

The scripts create:
`/home/saurabh/Stock_Project/ml_output/`

Keep `master_dataset.csv` and `stocks.db` as they are. The scripts read the processed CSV and do not alter the source CSV or SQLite database.

## Step 1 — Open the project folder
1. Open RStudio.
2. In the Files pane, navigate to `/home/saurabh/Stock_Project`.
3. Copy the three `.R` files into that folder, or open them from wherever you extracted this package.
4. Confirm `processed_dataset.csv` exists in the project folder.

If you save the scripts elsewhere, change `PROJECT_DIR` at the top of each R file.

## Step 2 — Run the 12 baseline models
Open `01_train_12_models.R` and click **Source**. The first run may install packages. Allow it to finish.

It trains:
1. Logistic Regression
2. Decision Tree
3. Random Forest
4. Gradient Boosting (GBM)
5. XGBoost
6. SVM with radial kernel
7. K-Nearest Neighbours
8. Naive Bayes
9. Linear Discriminant Analysis
10. Neural Network
11. C5.0 Decision Tree
12. AdaBoost

The script creates a target named `Breakout_Next`: today's numeric predictors are used to predict the next available row's breakout for the same ticker. It sorts by ticker and date, so the target does not jump between companies. It uses a chronological 70% training / 15% validation / 15% test split based on dates. The baseline models are assessed on validation data; the test period is reserved for the tuning script's final evaluation.

**Important:** the original `Breakout` column must be coded as `0/1` or `TRUE/FALSE`. The script stops with a clear error if it cannot interpret it. Confirm the original definition of `Breakout` in your project report and make sure it matches your intended breakout rule.

## Step 3 — Compare models and create charts
Only after Step 2 completes, open `02_compare_visualize.R` and click **Source**.

It creates:
- `validation_metrics.csv`
- `plots/model_comparison_pr_auc.png`
- `plots/model_comparison_all_metrics.png`
- `plots/roc_curves.png`
- `plots/random_forest_feature_importance.png` (if the Random Forest fit succeeds)

Use PR-AUC, precision, recall and F1 along with ROC-AUC. Since breakout events are rare, accuracy by itself can be misleading. The initial threshold is 0.50 for the baseline comparison; the tuning script searches validation thresholds.

## Step 4 — Tune and optimize selected models
Open `03_tune_optimize.R` and click **Source**. This tunes Logistic Regression, Decision Tree, Random Forest, GBM and XGBoost. It uses cross-validation within the training period, chooses the model and probability threshold using validation F1, and evaluates that selection on the held-out test period.

Outputs include:
- `tuning_summary.csv`
- `tuned_validation_thresholds.csv`
- `final_test_metrics.csv`
- `final_test_confusion_matrix.csv`
- `best_tuned_model.rds`

The final test metrics are the most important final estimate. Do not keep changing features or thresholds based on test results; that would turn the test period into another validation set.

## Step 5 — If you get an error
- **File not found:** check `PROJECT_DIR` and the exact CSV filename.
- **Package installation fails:** run `install.packages("PACKAGE_NAME")` in the Console and retry.
- **Model fails or laptop gets slow:** let the script finish if possible; otherwise stop it, reduce `tuneLength` or the number of candidate models, and rerun. XGBoost, SVM, KNN and neural networks can take longer.
- **Target coding error:** inspect `table(read.csv("processed_dataset.csv")$Breakout, useNA = "ifany")` and adjust the target conversion only after confirming its meaning.
- **Not enough positive examples in an early fold:** the script may skip invalid date folds. If too few folds remain, inspect positive-event counts by date before proceeding.

## Statistical notes for the report
- Chronological splitting better reflects forecasting than randomly shuffling stock rows.
- `Breakout_Next` makes this a next-trading-day prediction task. If your intended task is instead to classify whether the current row is a breakout, change the target deliberately and document that choice.
- The scripts exclude `Date`, `Ticker`, and the current `Breakout` column from predictors. They use numeric features only. Check all 45 processed columns for leakage before reporting results.
- The baseline script imputes missing feature values using training-set medians. Down-sampling is applied during resampling, not to the validation/test rows.
- Hyperparameter tuning uses expanding-window chronological folds within the training period. This is more appropriate for time-series forecasting than randomly shuffled cross-validation.
- The model scores are experimental results, not investment advice or evidence of a profitable trading strategy.

## Run order
1. `01_train_12_models.R`
2. `02_compare_visualize.R`
3. `03_tune_optimize.R`
