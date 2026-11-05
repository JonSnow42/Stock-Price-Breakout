# Visualizations Directory

This directory contains all graphical visualizations generated in the project, categorized into dedicated subdirectories:

## Directory Structure

```
plots/
├── eda/                          # Exploratory Data Analysis Figures
│   ├── 01_sector_price_trend.png
│   ├── 02_return_distribution_by_sector.png
│   ├── 03_sector_correlation_heatmap.png
│   ├── 04_rsi_distribution.png
│   ├── 05_breakout_frequency_by_sector.png
│   ├── 06_sample_stock_breakout.png
│   └── README.md
│
└── ml/                           # Machine Learning Evaluation Figures
    ├── 01_roc_curves_test.png
    ├── 02_precision_recall_curves_test.png
    ├── 03_model_comparison_test.png
    ├── 04_tuning_improvement.png
    ├── 05_feature_importance.png
    ├── 06_confusion_matrix_best_model.png
    └── README.md
```

## Subdirectories

1. [**`plots/eda/`**](eda/README.md):
   - Contains 6 statistical and exploratory plots visualizing sector price trends (normalized to 100), daily return distributions by sector, sector correlation heatmap, 14-day RSI distributions across regimes, sector breakout frequency distributions, and a technical breakout case study on Apple Inc. (`AAPL`).
   - Detailed documentation and statistical interpretations are available in [`plots/eda/README.md`](eda/README.md).

2. [**`plots/ml/`**](ml/README.md):
   - Contains 6 model evaluation and diagnostic plots generated on the held-out test set (2025-01-02 to 2026-07-28; 19,600 observations).
   - Includes ROC curves across all 10 algorithms, Precision-Recall curves highlighting severe class imbalance ($2.15\%$ baseline), model comparison bar charts across metrics, hyperparameter tuning improvement across validation and test sets, LightGBM/GBM relative feature importance rankings, and the confusion matrix of the champion Gradient Boosting model at the optimal decision threshold ($\tau^* = 0.4717$).
   - Detailed documentation and metric audits are available in [`plots/ml/README.md`](ml/README.md).
