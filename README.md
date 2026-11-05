# Machine Learning-Based Stock Market Trend Analysis and Momentum Breakout Prediction

[![R](https://img.shields.io/badge/Language-R%204.x-blue.svg)](https://www.r-project.org/)
[![Database](https://img.shields.io/badge/Database-SQLite%203-lightgrey.svg)](https://www.sqlite.org/)
[![License](https://img.shields.io/badge/License-Academic-green.svg)]()

A comprehensive Data Science and Machine Learning project for predicting next-trading-day momentum breakout opportunities across 50 S&P 500 constituents spanning a 10-year historical window (2016–2026).

---

## 📌 Project Overview

Momentum breakouts occur when an equity price breaches an established multi-week resistance level accompanied by substantial trading volume expansion. While traditional traders rely on subjective, non-scalable manual chart patterns, this project builds a rigorous, automated machine learning pipeline to forecast next-day ($t+1$) breakout occurrences using quantitative features calculated strictly up to market close of day $t$.

### Key Highlights:
- **10-Year Historical Dataset:** 125,650 raw records covering 50 large-cap S&P 500 companies across 10 distinct GICS sectors (2016–2026).
- **Leakage-Free Feature Engineering:** 26 candidate technical and volume indicators pruned to 23 non-collinear features via correlation thresholding ($|r| \le 0.90$).
- **Strict Chronological Splitting:** 
  - **Training Set:** 2016-11-21 to 2022-12-30 (76,900 rows; 1,881 breakouts, 2.45%)
  - **Validation Set:** 2023-01-03 to 2024-12-31 (25,100 rows; 580 breakouts, 2.31%)
  - **Test Set:** 2025-01-02 to 2026-07-28 (19,600 rows; 422 breakouts, 2.15%)
- **Target Formulation:**
  $$\text{Breakout\_Today}_t = \mathbb{I}\left(\text{Adj\_Close}_t > \max_{1 \le i \le 20}(\text{Adj\_Close}_{t-i}) \land \text{Volume}_t > 1.5 \times \text{Avg\_Volume\_20}_t\right)$$
  $$\text{Target: } \mathbf{Breakout\_Next}_t = \text{Breakout\_Today}_{t+1}$$
- **10 Supervised ML Algorithms:** Logistic Regression, Decision Tree, Random Forest, Gradient Boosting (GBM), XGBoost, SVM (radial), KNN, Naive Bayes, Linear Discriminant Analysis (LDA), and Neural Network (MLP).
- **Evaluation for Rare Events:** Prioritizes PR-AUC and F1-score over misleading raw accuracy. Optimal decision thresholds ($\tau^*$) calibrated strictly on validation data.

---

## 🏆 Final Benchmark Results (Held-Out Test Set)

Evaluated on 19,600 untouched out-of-time test observations (2025–2026):

| Model | ROC-AUC | PR-AUC | Precision | Recall | F1-Score | Optimal Threshold ($\tau$) |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| **Gradient Boosting (GBM)** | **0.8536** | **0.1721** | 0.2015 | 0.3128 | **0.2451** | 0.4717 |
| **Neural Network (MLP)** | **0.8582** | **0.1645** | 0.1664 | **0.4265** | **0.2394** | 0.5345 |
| **XGBoost** | 0.8573 | 0.1630 | 0.2098 | 0.2844 | 0.2414 | 0.4752 |
| **Linear Discriminant Analysis** | 0.8523 | 0.1549 | 0.2106 | 0.2536 | 0.2301 | 0.1289 |
| **K-Nearest Neighbours (KNN)** | 0.8460 | 0.1518 | **0.2217** | 0.2464 | 0.2334 | 0.5185 |
| **Random Forest** | 0.8447 | 0.1490 | 0.2111 | 0.2156 | 0.2134 | 0.1529 |
| **Logistic Regression** | 0.8554 | 0.1482 | 0.1821 | 0.3223 | 0.2327 | 0.4071 |
| **Naive Bayes** | 0.8135 | 0.1409 | 0.2073 | 0.2299 | 0.2180 | 0.9747 |
| **Decision Tree** | 0.8189 | 0.1374 | 0.1925 | 0.2938 | 0.2326 | 0.5128 |
| **SVM (Radial Kernel)** | 0.8079 | 0.1329 | 0.1941 | 0.2654 | 0.2242 | 0.2659 |

*Note: Uninformed random guessing yields $\text{PR-AUC} \approx 0.0215$ and $\text{ROC-AUC} = 0.500$. Gradient Boosting delivers an **$8.0\times$ lift** over random guessing.*

---

## 📂 Repository Structure

```
├── 00_setup.R                           # Shared configuration, feature engineering & DB helpers
├── 01_ml_models.R                       # 10 algorithm definitions & baseline training
├── 02_hyperparameter_tuning.R           # Random grid search & validation threshold optimization
├── 03_model_comparison_visualization.R  # Generates test evaluation plots & comparison tables
├── database_connectivity.R              # SQLite database ingestion & verification
├── eda.R                                # Initial exploratory data analysis script
├── ed22.R                               # Comprehensive sector and volatility visualization script
├── master_dataset.csv                   # Raw S&P 500 OHLCV daily data (125,650 rows × 9 cols)
├── processed_dataset.csv                # Preprocessed intermediate data (123,150 rows × 45 cols)
├── stocks.db                            # SQLite database containing stock_data, model_features, results
├── plots/                               # EDA figures (sector trends, return distributions, RSI)
│   ├── 01_sector_price_trend.png
│   ├── 02_return_distribution_by_sector.png
│   ├── 03_sector_correlation_heatmap.png
│   ├── 04_rsi_distribution.png
│   ├── 05_breakout_frequency_by_sector.png
│   └── 06_sample_stock_breakout.png
├── results/                             # Model comparison outputs, logs, and artifacts
│   ├── final_comparison_table.csv
│   ├── feature_importance.csv
│   ├── feature_selection_dropped.csv
│   ├── plots/                           # Evaluation plots
│   │   ├── 01_roc_curves_test.png
│   │   ├── 02_precision_recall_curves_test.png
│   │   ├── 03_model_comparison_test.png
│   │   ├── 04_tuning_improvement.png
│   │   ├── 05_feature_importance.png
│   │   └── 06_confusion_matrix_best_model.png
│   └── *.rds                            # Serialized model predictions and parameter configurations
└── Final_Report/                        # Academic documentation (DOCX & PDF formats)
```

---

## 🚀 Execution Instructions

### Prerequisites
Make sure R (>= 4.0.0) and SQLite3 are installed. In RStudio, install the required packages:
```r
install.packages(c(
  "DBI", "RSQLite", "dplyr", "ggplot2", "pROC",
  "ranger", "gbm", "xgboost", "e1071", "rpart",
  "class", "nnet", "MASS", "corrplot", "tidyr", "readr"
))
```

### Execution Flow
1. **Initialize Database:**
   ```r
   source("database_connectivity.R")
   ```
2. **Run Exploratory Visualizations:**
   ```r
   source("ed22.R")
   ```
3. **Train Baseline Models:**
   ```r
   source("01_ml_models.R")
   ```
4. **Tune Hyperparameters & Score Test Set:**
   ```r
   source("02_hyperparameter_tuning.R")
   ```
5. **Generate Comparison Figures & Tables:**
   ```r
   source("03_model_comparison_visualization.R")
   ```

---

## 📊 Key Findings
- **Consolidation Proximity:** The proximity of the current price to the 20-day high (`Dist_High_20`) is the single most predictive indicator across tree ensembles ($43.1\%$ relative importance in GBM).
- **Volume Accumulation:** Log-volume expansion relative to the 20-day rolling baseline (`Log_Vol_Ratio`) contributes $40.6\%$ relative importance.
- Together, these two features account for over **83.7%** of the decision power in the winning Gradient Boosting model.
