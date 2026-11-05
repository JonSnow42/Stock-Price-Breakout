# Machine Learning Experimental Results & Artifacts

This directory houses the structured tabular results, feature audit logs, and serialized model prediction objects generated during baseline training ([`01_ml_models.R`](../01_ml_models.R)), hyperparameter optimization ([`02_hyperparameter_tuning.R`](../02_hyperparameter_tuning.R)), and model evaluation ([`03_model_comparison_visualization.R`](../03_model_comparison_visualization.R)).

---

## 📁 Artifact Inventory

### 1. Tabular Summary Files
- **`final_comparison_table.csv`:** Complete evaluation metrics across all ten algorithms on the held-out test partition (19,600 observations; 2025–2026).
  - Columns: `Model`, `ROC_AUC`, `PR_AUC`, `Precision`, `Recall`, `F1`.
  - Champion: **Gradient Boosting (GBM)** with PR-AUC = `0.1721` and F1 = `0.2451`.
- **`feature_importance.csv`:** Top 12 predictive features and their relative importance scores (%) for Gradient Boosting, Random Forest, and XGBoost.
  - Demonstrates that `Dist_High_20` and `Log_Vol_Ratio` account for over `83.7%` of total predictive power.
- **`feature_selection_dropped.csv`:** Audit log of features removed by the correlation pruning algorithm ($|r| > 0.90$):
  - `Price_vs_SMA50` (correlated with `MACD_Pct`, $|r| = 0.93$)
  - `ATR_Pct` (correlated with `Volatility_20`, $|r| = 0.92$)
  - `Price_vs_SMA20` (correlated with `Return_10d`, $|r| = 0.91$)

### 2. Serialized R Data Objects (`.rds`)
- **`best_params.rds`:** List of optimal hyperparameter configurations selected via validation PR-AUC across all models.
- **`preds_valid_baseline.rds`:** Validation-set prediction probabilities and ground truth labels for baseline models under default settings.
- **`preds_valid_tuned.rds`:** Validation-set prediction probabilities following random grid search hyperparameter tuning.
- **`preds_test.rds`:** Final prediction probabilities, true labels (`y`), and validation-calibrated decision thresholds (`thresholds`) for all models on the held-out test set.

### 3. Visualizations Subdirectory
- **`plots/`:** Directory containing the six high-resolution evaluation figures (ROC curves, PR curves, model comparison bars, tuning improvements, feature importance rankings, and the confusion matrix heatmap). Copies are also curated in [`plots/ml/`](../plots/ml/).
