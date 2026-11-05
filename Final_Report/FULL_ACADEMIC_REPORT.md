# Machine Learning-Based Stock Market Trend Analysis and Momentum Breakout Prediction
## A 10-Year Empirical Study Across 50 S&P 500 Constituents (2016–2026)

---

### [ UNIVERSITY / COLLEGE NAME PLACEHOLDER ]
### [ DEPARTMENT OF DATA SCIENCE / COMPUTER SCIENCE & ENGINEERING ]

**A Project Report Submitted in Partial Fulfilment of the Requirements for the Degree of**  
**[ BACHELOR OF TECHNOLOGY IN DATA SCIENCE / COMPUTER SCIENCE ]**

| **Project Metadata** | **Details** |
|:---|:---|
| **Project Title** | Machine Learning-Based Stock Market Trend Analysis and Momentum Breakout Prediction |
| **Primary Environment** | RStudio (R 4.x on Fedora Linux) |
| **Database Architecture** | Relational SQLite (`stocks.db`) via `DBI` and `RSQLite` |
| **Target Dataset** | 50 S&P 500 Equities Across 10 GICS Sectors (10 Years: 2016–2026; 125,650 Observations) |
| **Submitted by** | `[ STUDENT NAME(S) / REGISTRATION NUMBER(S) PLACEHOLDER ]`<br>*(Reference from records: Saurabh Madhesia \| Reg. No: 24BDS1082)* |
| **Under the Guidance of** | `[ FACULTY GUIDE NAME & DESIGNATION PLACEHOLDER ]`<br>*(Reference from records: Dr. Vijayalakshmi A \| SCOPE, VIT Chennai)* |
| **Academic Year** | `[ 2025 – 2026 ]` |
| **Date of Submission** | `[ SUBMISSION DATE PLACEHOLDER ]` |

---

## Project Team & Academic Supervision

### Student Investigators
| S.No. | Student / Author Name | Register Number | Degree & Programme | Primary Project Responsibilities |
|:---:|:---|:---:|:---:|:---|
| **1** | `[ Student 1 / Lead Author ]`<br>(Saurabh Madhesia) | `[ Reg. No. ]`<br>(24BDS1082) | B.Tech Data Science | Data Acquisition, Feature Engineering, ML Pipeline Development, Evaluation |
| **2** | `[ Student 2 (Optional) ]` | `[ Reg. No. ]` | B.Tech Data Science | Exploratory Data Analysis, Database Connectivity, Model Benchmarking |
| **3** | `[ Student 3 (Optional) ]` | `[ Reg. No. ]` | B.Tech Data Science | Statistical Verification, Hyperparameter Tuning, Documentation |

### Academic Supervisory Panel
| Role | Supervisor Name | Academic Designation | School / Department | Institutional Affiliation |
|:---|:---|:---|:---|:---|
| **Faculty Guide** | `[ Dr. Vijayalakshmi A ]` | Associate Professor / Professor | School of Computer Science & Engineering (SCOPE) | VIT Chennai |
| **Programme Chair** | `[ Department Chair Name ]`| Professor & Head | Department of Data Science | VIT Chennai |

> **Environment & Setup:** All preprocessing, exploratory analysis, statistical modeling, database operations, and machine learning pipelines were authored and executed in **RStudio** using native R on Linux. The repository is published at: [https://github.com/JonSnow42/Stock-Price-Breakout](https://github.com/JonSnow42/Stock-Price-Breakout).

---

## Abstract

Anticipating momentum breakouts is a central problem in quantitative equity trading. A momentum breakout occurs when an equity price breaches an established multi-week consolidation resistance ceiling on extraordinary volume expansion, signaling a structural transition into an aggressive upside trend. Traditional technical analysis relies on subjective chart interpretation and rigid screeners that suffer from high false-positive rates and cannot scale across multi-asset universes.

This project implements an end-to-end, leak-free machine learning framework in RStudio to forecast next-trading-day momentum breakout opportunities across 50 large-cap S&P 500 constituents spanning a 10-year window (August 2016 to July 2026). The empirical dataset comprises 125,650 daily OHLCV observations across ten GICS sectors. After verification and staging in an SQLite database (`stocks.db`), a leak-free feature pipeline constructed 26 technical, volatility, momentum, and volume-relative indicators. Automated Pearson correlation pruning ($|r| \le 0.90$) retained 23 standardized predictors.

To prevent forward lookahead leakage, the prediction target is mathematically formulated as an explicit next-day lead indicator ($\text{Breakout\_Next}$ at $t+1$) computed strictly from information available up to market close on day $t$. The dataset was chronologically partitioned into an in-sample training set (2016–2022; 76,900 rows; 2.45% breakout rate), an out-of-sample validation set (2023–2024; 25,100 rows; 2.31% breakout rate), and a held-out test set (2025–2026; 19,600 rows; 2.15% breakout rate). Ten supervised classifiers were trained and tuned: Logistic Regression, Decision Tree (CART), Random Forest, Gradient Boosting Machine (GBM), XGBoost, Support Vector Machine (radial SVM), K-Nearest Neighbours (KNN), Naive Bayes, Linear Discriminant Analysis (LDA), and a Multilayer Perceptron (MLP) Neural Network.

Given the extreme class imbalance (~2.15%–2.45%), models incorporated square-root class weighting and majority downsampling. Performance was evaluated using Precision-Recall AUC (PR-AUC), F1-score, and ROC-AUC under decision thresholds calibrated on validation data. On the untouched test set, **Gradient Boosting (GBM)** achieved champion performance with a PR-AUC of **0.1721**, ROC-AUC of **0.8536**, precision of **20.15%**, recall of **31.28%**, and F1-score of **0.2451**, representing an **$8.0\times$ lift** over the random guessing baseline (0.0215). Neural Network (MLP) attained top ROC-AUC (0.8582) and recall (42.65%), while XGBoost delivered PR-AUC of 0.1630 and F1 of 0.2414. Tree-based feature importance attribution revealed that proximity to the 20-day high (`Dist_High_20`: 43.13%) and relative volume expansion (`Log_Vol_Ratio`: 40.57%) account for **83.70%** of total predictive power.

**Keywords:** Momentum Breakout, Stock Market Trend Analysis, S&P 500, Machine Learning, Gradient Boosting, XGBoost, Precision-Recall AUC, Class Imbalance, Technical Indicators, RStudio.

---

## Table of Contents

1. [Introduction](#1-introduction)
   - 1.1 Background of Stock Market Trend Analysis
   - 1.2 Financial Momentum in Equity Trading
   - 1.3 Momentum Breakouts: Technical Definition and Mechanics
   - 1.4 Practical Utility in Quantitative Portfolio Management
   - 1.5 Formal Problem Statement
   - 1.6 Project Objectives
   - 1.7 Scope, Boundary Conditions, and Methodological Limitations
2. [Dataset Description & Database Architecture](#2-dataset-description--database-architecture)
   - 2.1 Data Source and Historical Extraction Protocol
   - 2.2 Universe of Selected S&P 500 Companies
   - 2.3 Temporal Characteristics and Trading Horizon
   - 2.4 Original vs. Processed Dataset Specifications
   - 2.5 Relational SQLite Database Architecture (`stocks.db`)
   - 2.6 Data Cleansing, Verification, and Missingness Audit
   - 2.7 Comprehensive Feature Dictionary
3. [Exploratory Data Analysis & Visualizations](#3-exploratory-data-analysis--visualizations)
   - 3.1 Multi-Year Sector Price Trends (Figure 1)
   - 3.2 Daily Return Distributions by Sector (Figure 2)
   - 3.3 Cross-Sector Return Correlation Heatmap (Figure 3)
   - 3.4 Momentum Oscillator Distribution: RSI-14 (Figure 4)
   - 3.5 Sectoral Breakout Frequencies (Figure 5)
   - 3.6 Micro-Level Case Study: NVDA Price Action and Breakouts (Figure 6)
4. [Statistical Analysis & Preprocessing Pipeline](#4-statistical-analysis--preprocessing-pipeline)
   - 4.1 Mathematical Formulation of Technical Indicators
   - 4.2 Pearson Correlation Screening and Multicollinearity Pruning
   - 4.3 In-Sample Scaling and Feature Normalization
   - 4.4 Statistical Nature of Class Imbalance
   - 4.5 Supervised Target Engineering and Zero-Leakage Proof
5. [Machine Learning Models & Experimental Methodology](#5-machine-learning-models--experimental-methodology)
   - 5.1 End-to-End Machine Learning Pipeline Architecture
   - 5.2 Chronological Partitioning Protocol (Train / Valid / Test)
   - 5.3 Formulations of the Ten Supervised Classifiers
   - 5.4 Hyperparameter Optimization via Random Grid Search
   - 5.5 Decision Threshold Calibration on Validation PR-AUC
6. [Output Screenshots, Model Evaluation & Comparative Results](#6-output-screenshots-model-evaluation--comparative-results)
   - 6.1 Final Benchmark Results on Held-Out Test Set (2025–2026)
   - 6.2 Precision-Recall (PR) Curve Diagnostics (Figure 7)
   - 6.3 Receiver Operating Characteristic (ROC) Diagnostics (Figure 8)
   - 6.4 Multi-Metric Model Comparison (Figure 9)
   - 6.5 Validation Hyperparameter Tuning Improvement (Figure 10)
   - 6.6 Feature Importance Attribution (Figure 11)
   - 6.7 Confusion Matrix Diagnostics of Champion Model (Figure 12)
   - 6.8 Critical Comparative Discussion
7. [Conclusion & Future Scope](#7-conclusion--future-scope)
   - 7.1 Summary of Engineering and Research Accomplishments
   - 7.2 Empirical Takeaways on Market Predictability
   - 7.3 Methodological and Financial Limitations
   - 7.4 Future Research Directions
8. [Important R Code Snippets](#8-important-r-code-snippets)
9. [GitHub Repository & Execution Guide](#9-github-repository--execution-guide)
10. [References](#10-references)

---

## List of Figures

| Figure No. | Caption & Figure Description | Relative Path in Repository |
|:---:|:---|:---|
| **Figure 1** | Sector-Wise Price Trend (2016–2026), Indexed to 100 at Start Date | [`plots/eda/01_sector_price_trend.png`](../plots/eda/01_sector_price_trend.png) |
| **Figure 2** | Daily Return Distribution and Volatility Spans across Sectors | [`plots/eda/02_return_distribution_by_sector.png`](../plots/eda/02_return_distribution_by_sector.png) |
| **Figure 3** | Hierarchically Clustered Correlation Heatmap of Sector Daily Returns | [`plots/eda/03_sector_correlation_heatmap.png`](../plots/eda/03_sector_correlation_heatmap.png) |
| **Figure 4** | Empirical Distribution of 14-Day Relative Strength Index (RSI) | [`plots/eda/04_rsi_distribution.png`](../plots/eda/04_rsi_distribution.png) |
| **Figure 5** | Historical Momentum Breakout Frequency (%) by Industrial Sector | [`plots/eda/05_breakout_frequency_by_sector.png`](../plots/eda/05_breakout_frequency_by_sector.png) |
| **Figure 6** | NVDA Price Action, Moving Averages (20/50), and Detected Breakouts | [`plots/eda/06_sample_stock_breakout.png`](../plots/eda/06_sample_stock_breakout.png) |
| **Figure 7** | Precision-Recall Curves on Held-Out Test Set across All 10 Classifiers | [`plots/ml/02_precision_recall_curves_test.png`](../plots/ml/02_precision_recall_curves_test.png) |
| **Figure 8** | Receiver Operating Characteristic (ROC) Curves on Test Set | [`plots/ml/01_roc_curves_test.png`](../plots/ml/01_roc_curves_test.png) |
| **Figure 9** | Multi-Metric Model Comparison on Test Data (ROC-AUC, PR-AUC, F1) | [`plots/ml/03_model_comparison_test.png`](../plots/ml/03_model_comparison_test.png) |
| **Figure 10** | Validation-Stage Performance Delta Before vs. After Hyperparameter Tuning | [`plots/ml/04_tuning_improvement.png`](../plots/ml/04_tuning_improvement.png) |
| **Figure 11** | Top 12 Predictive Features for Gradient Boosting, Random Forest, and XGBoost | [`plots/ml/05_feature_importance.png`](../plots/ml/05_feature_importance.png) |
| **Figure 12** | Confusion Matrix Heatmap of Best Performing Model (Gradient Boosting) | [`plots/ml/06_confusion_matrix_best_model.png`](../plots/ml/06_confusion_matrix_best_model.png) |

---

## List of Tables

| Table No. | Title / Content Description | Section Reference |
|:---:|:---|:---:|
| **Table 1** | Project Team Members and Functional Allocation | Section 2 |
| **Table 2** | Faculty Guidance and Institutional Affiliation | Section 2 |
| **Table 3** | Curated S&P 500 Constituent Universe Categorized across 10 GICS Sectors | Section 2.2 |
| **Table 4** | Comprehensive Feature Dictionary of Processed & Engineered Variables | Section 2.7 |
| **Table 5** | Collinearity Screening Audit: Pruned Features and Statistical Justifications | Section 4.2 |
| **Table 6** | Chronological Data Partitioning Schema Across 50 S&P 500 Equities | Section 5.2 |
| **Table 7** | Hyperparameter Tuning Grid Allocations, Trial Counts, and Optimal Selections | Section 5.4 |
| **Table 8** | Final Comprehensive Model Evaluation Benchmark on the Untouched Test Set | Section 6.1 |

---

## 1. Introduction

### 1.1 Background of Stock Market Trend Analysis
Financial equity markets represent complex stochastic systems exhibiting non-stationarity, time-varying conditional volatility (heteroskedasticity), fat-tailed return distributions, and low signal-to-noise ratios. Prices evolve as market participants interact to discount corporate earnings, macroeconomic indicators, monetary policy adjustments, and aggregate liquidity shifts.

Historically, market participants have approached price behavior through fundamental and technical analysis. Fundamental analysis inspects balance sheet health, discounted cash flows, and industry moats to estimate intrinsic value. Technical analysis posits that historical price action and trading volume reflect market information and investor psychology. Modern data science translates technical principles into mathematically rigorous, reproducible predictive models evaluated against statistical benchmarks.

### 1.2 Financial Momentum in Equity Trading
Cross-sectional momentum is an established empirical asset pricing anomaly first formalized by Jegadeesh and Titman (1993). Equities exhibiting superior relative performance over intermediate windows (3 to 12 months) systematically tend to continue outperforming over subsequent holding periods. This return autocorrelation challenges the strict Efficient Market Hypothesis (Fama, 1970).

In behavioral finance, momentum is driven by initial cognitive underreaction to positive informational surprises followed by institutional herd behavior and positive feedback trading. Statistically, momentum measures the velocity of directional price trajectories. Identifying momentum transitions early allows quantitative strategies to align capital with institutional accumulation phases.

### 1.3 Momentum Breakouts: Technical Definition and Mechanics
A momentum breakout represents a structural regime shift. An equity typically oscillates within a consolidation range bounded by an upper resistance ceiling and a lower support floor, where buying and selling forces reach temporary equilibrium.

A breakout occurs when price forcefully closes above resistance accompanied by extraordinary volume expansion. The volume surge confirms that the price breach is driven by aggressive institutional order flow absorbing overhead supply rather than a low-liquidity fluctuation. Once resistance is penetrated, short covering and algorithmic trend-following orders accelerate the directional price advance.

### 1.4 Practical Utility in Quantitative Portfolio Management
Predicting momentum breakouts provides major quantitative advantages:
- **Capital Efficiency:** Deploying capital immediately prior to directional expansion reduces opportunity costs from holding stagnant equities in sideways consolidation.
- **Asymmetric Risk-Reward Profiling:** Breakout patterns offer natural structural stop-loss invalidation levels at the prior resistance ceiling, minimizing drawdown on failed attempts.
- **Scalable Surveillance:** Automated machine learning pipelines continuously screen thousands of securities without human cognitive fatigue or emotional bias.
- **Objective Decision Rules:** Statistical probability thresholds replace subjective, inconsistent visual chart interpretation.

### 1.5 Formal Problem Statement
Conventional technical screeners alerting on 20-day high breaches generate substantial false breakouts—intraday spikes that rapidly reverse downward. Furthermore, existing research focuses primarily on regression price targets or next-day directional sign, leaving next-day breakout forecasting underexplored.

> **Problem Statement:** *Given historical daily OHLCV equity data up to day $t$ across 50 large-cap S&P 500 stocks, can supervised machine learning algorithms accurately forecast whether a confirmed momentum breakout event will occur on day $t+1$, overcoming severe class imbalance (~2.15%–2.45%) without lookahead data leakage?*

### 1.6 Project Objectives
- **Primary Objective:** Build an end-to-end quantitative machine learning pipeline in RStudio to predict next-trading-day breakout events across 50 S&P 500 stocks.
- **Data Engineering:** Assemble a 10-year (2016–2026), 125,650-record OHLCV dataset across 10 GICS sectors into an SQLite database (`stocks.db`).
- **Feature Engineering & Selection:** Formulate 26 technical, volatility, momentum, and volume features, applying Pearson pruning ($|r| \le 0.90$) to retain 23 predictors.
- **Zero-Leakage Target:** Formulate the breakout target strictly as a next-day lead variable ($\text{Breakout\_Next}$ at $t+1$).
- **Model Benchmarking:** Implement and tune ten supervised classifiers spanning linear, tree ensemble, kernel, instance-based, probabilistic, and neural architectures.
- **Class Imbalance Calibration:** Address rare event distribution using class weighting and downsampling, optimizing decision thresholds on validation PR-AUC.

### 1.7 Scope, Boundary Conditions, and Methodological Limitations
- **Universe:** 50 large-cap S&P 500 constituents across 10 GICS sectors. Micro-caps and illiquid equities are excluded.
- **Temporal Frequency:** Daily end-of-day (EOD) bars. Intraday order book dynamics are outside project scope.
- **Frictionless Benchmark:** Metrics assess statistical classification power without transaction fees, slippage, or borrow costs.
- **Academic Nature:** All outputs represent academic research artifacts and do not constitute financial advice.

---

## 2. Dataset Description & Database Architecture

### 2.1 Data Source and Historical Extraction Protocol
Historical daily OHLCV data were extracted programmatically from Yahoo Finance via the `yfinance` interface into RStudio. Yahoo Finance provides dividend- and split-adjusted daily series with comprehensive historical depth across US large-cap equities. A stratified sampling protocol selected five large-cap leaders from each of the ten primary GICS sectors to capture cross-sector volatility differences.

### 2.2 Universe of Selected S&P 500 Companies

**Table 3: Curated S&P 500 Constituent Universe Categorized across 10 GICS Sectors**
| Sector (GICS) | Ticker Symbols | Representative Companies | Core Economic Profile |
|:---|:---|:---|:---|
| **Technology** | AAPL, MSFT, NVDA, ADBE, CRM | Apple, Microsoft, NVIDIA, Adobe, Salesforce | Enterprise software, semiconductors, mobile hardware |
| **Finance** | JPM, BAC, WFC, GS, BRK-B | JPMorgan Chase, Bank of America, Wells Fargo, Goldman Sachs, Berkshire Hathaway | Investment banking, lending, diversified holdings |
| **Healthcare** | JNJ, UNH, PFE, ABBV, LLY | Johnson & Johnson, UnitedHealth, Pfizer, AbbVie, Eli Lilly | Pharmaceuticals, healthcare plans, clinical biotech |
| **Consumer Discretionary** | AMZN, HD, MCD, NKE, WMT | Amazon, Home Depot, McDonald's, Nike, Walmart | E-commerce, home retail, consumer chains |
| **Communication Services** | GOOGL, META, DIS, CMCSA, T | Alphabet, Meta, Disney, Comcast, AT&T | Digital advertising, social media, entertainment, telecom |
| **Industrials** | CAT, BA, HON, UPS, GE | Caterpillar, Boeing, Honeywell, UPS, GE Aerospace | Industrial manufacturing, aerospace, global freight |
| **Energy** | XOM, CVX | ExxonMobil, Chevron | Integrated oil exploration, refining, distribution |
| **Consumer Staples** | PG, KO, PEP, COST | Procter & Gamble, Coca-Cola, PepsiCo, Costco Wholesale | Consumer packaged goods, global beverages, retail |
| **Multi-Sector Tech / Fin** | AMD, AVGO, CSCO, IBM, INTC, MA, MS, ORCL, V | AMD, Broadcom, Cisco, IBM, Intel, Mastercard, Morgan Stanley, Oracle, Visa | Microprocessors, networking, payment networks |
| **Real Estate, Materials, Utilities** | SPG, LIN, NEE | Simon Property Group, Linde plc, NextEra Energy | Commercial retail REIT, industrial gases, regulated power |

### 2.3 Temporal Characteristics and Trading Horizon
The extraction window spans August 1, 2016, through July 30, 2026 (2,513 active trading days per equity). This 10-year timeframe encompasses diverse market environments: the 2016–2019 low-rate bull market, the March 2020 COVID-19 crash and rapid liquidity recovery, the 2022 Federal Reserve tightening bear market, and the 2023–2026 AI expansion cycle.

### 2.4 Original vs. Processed Dataset Specifications
- **Master Dataset (`master_dataset.csv`):** 125,650 rows × 9 columns (`Date`, `Adj Close`, `Close`, `High`, `Low`, `Open`, `Volume`, `Ticker`, `Sector`). Unprocessed daily feed across 50 equities (15.3 MB).
- **Processed Dataset (`processed_dataset.csv`):** 123,150 rows × 45 columns. 2,500 rows dropped ($50 \times 50$) due to a 50-day rolling warmup for moving averages. Includes technical indicators and preliminary breakout labels (73.4 MB).
- **Model Features Matrix (`model_features` in `stocks.db`):** 121,600 rows × 27 columns (`Date`, `Ticker`, `split`, `y`, plus 23 standardized predictors). An additional 1,550 rows were dropped due to a 30-day warmup and terminal day target alignment.

### 2.5 Relational SQLite Database Architecture (`stocks.db`)
To support scalable querying and reproducibility, SQLite database `stocks.db` (63.1 MB) was initialized using `DBI` and `RSQLite`:
- **`stock_data`:** Stores the preprocessed dataset (123,150 rows × 45 columns) for fast SQL aggregations.
- **`model_features`:** Contains the 121,600 model-ready instances with partition tags (`train`, `valid`, `test`) and 23 scaled predictors.
- **`model_results`:** Experiment registry recording baseline, tuned, and test evaluation metrics (33 records).
- **`tuning_log`:** Detailed audit of 47 hyperparameter search trials with configurations and validation metrics.

### 2.6 Data Cleansing, Verification, and Missingness Audit
- **Missing Values:** Zero missing cells (`NA` / `NaN`) exist in `master_dataset.csv` and `processed_dataset.csv`.
- **Duplicates:** Zero duplicate `(Ticker, Date)` composite primary key pairs exist.
- **Standardization:** All timestamps conform to ISO 8601 `YYYY-MM-DD`. All indicator calculations use `Adj Close` to account for corporate stock splits and dividends.

### 2.7 Comprehensive Feature Dictionary

**Table 4: Comprehensive Feature Dictionary of Processed, Engineered, and Pruned Variables**
| Feature Identifier | Category | Mathematical Formula / Derivation | Dimensional Status |
|:---|:---|:---|:---|
| `Dist_High_20` | Price Distance | $\frac{\text{Adj\_Close}_t}{\text{High\_20\_prior}_t} - 1$ | Kept (Rank 1 Importance: 43.1% in GBM) |
| `Log_Vol_Ratio` | Volume Flow | $\ln\left(\frac{\max(\text{Volume}_t, 1)}{\max(\text{Avg\_Volume\_20}_t, 1)}\right)$ | Kept (Rank 2 Importance: 40.6% in GBM) |
| `Breakout_Today` | Momentum State | $\mathbb{I}(\text{Adj\_Close}_t > \text{High\_20\_prior}_t \land \text{Volume}_t > 1.5 \times \text{Avg\_Volume\_20}_t)$ | Kept (Lagged State: 4.4% in GBM) |
| `Return_5d` | Intermediate Return | $\frac{\text{Adj\_Close}_t}{\text{Adj\_Close}_{t-5}} - 1$ | Kept (2.2% in GBM) |
| `Return_10d` | Medium Return | $\frac{\text{Adj\_Close}_t}{\text{Adj\_Close}_{t-10}} - 1$ | Kept (0.7% in GBM) |
| `Daily_Return` | Short-Term Return | $\frac{\text{Adj\_Close}_t}{\text{Adj\_Close}_{t-1}} - 1$ | Kept (1.2% in GBM) |
| `Return_lag1` | Lagged Return | $\text{Daily\_Return}_{t-1}$ | Kept |
| `Volatility_20` | Price Volatility | Rolling 20-day standard deviation of $\text{Daily\_Return}$ | Kept |
| `RSI_14` | Oscillator | $100 - \frac{100}{1 + \text{RS}}, \quad \text{RS} = \frac{\text{Avg Gain}_{14}}{\text{Avg Loss}_{14}}$ | Kept (1.2% in GBM) |
| `BB_Width` | Volatility Band | $\frac{4 \times \sigma_{20}(\text{Adj\_Close})}{\text{SMA}_{20}(\text{Adj\_Close})}$ | Kept (0.7% in GBM) |
| `Range_Pct` | Intraday Volatility | $\frac{\text{High}_t - \text{Low}_t}{\text{Close}_t}$ | Kept (1.1% in GBM) |
| `MACD_Pct` | Trend Momentum | $\frac{\text{EMA}_{12}(\text{Adj\_Close}) - \text{EMA}_{26}(\text{Adj\_Close})}{\text{Adj\_Close}_t}$ | Kept (0.9% in GBM) |
| `SMA20_vs_SMA50` | Moving Avg Trend | $\frac{\text{SMA}_{20}(\text{Adj\_Close})}{\text{SMA}_{50}(\text{Adj\_Close})} - 1$ | Kept (1.2% in GBM) |
| `Breakout_Count_20`| Historical Frequency | $\sum_{i=0}^{19} \text{Breakout\_Today}_{t-i}$ | Kept |
| `Sector_*` (9 dummies) | Categorical Sector | One-hot indicator per GICS sector (Utilities dropped as base) | Kept |
| `Price_vs_SMA50` | Moving Avg Gap | $\frac{\text{Adj\_Close}_t}{\text{SMA}_{50}} - 1$ | Pruned ($|r|=0.93$ with `MACD_Pct`) |
| `ATR_Pct` | True Range | 14-day rolling mean of `Range_Pct` | Pruned ($|r|=0.92$ with `Volatility_20`) |
| `Price_vs_SMA20` | Moving Avg Gap | $\frac{\text{Adj\_Close}_t}{\text{SMA}_{20}} - 1$ | Pruned ($|r|=0.91$ with `Return_10d`) |

---

## 3. Exploratory Data Analysis & Visualizations

Exploratory Data Analysis was performed using `ggplot2` and `corrplot` via `ed22.R`. All six exploratory figures are documented individually below.

### 3.1 Multi-Year Sector Price Trends (Figure 1)

![Figure 1: Sector Price Trends (2016–2026, Base=100)](../plots/eda/01_sector_price_trend.png)

*Figure 1: Sector Price Trends (2016–2026, Base=100)*

**Analytical Interpretation:** Technology exhibited massive multi-year outperformance, expanding from 100 to over 750, driven by enterprise cloud and semiconductor expansion. Communication Services and Consumer Discretionary followed with substantial cyclical swings. In contrast, defensive sectors (Utilities, Real Estate, Consumer Staples) grew moderately (120–180), confirming structural divergence in baseline momentum regimes across industrial sectors.

### 3.2 Daily Return Distributions by Sector (Figure 2)

![Figure 2: Daily Return Distributions by Sector](../plots/eda/02_return_distribution_by_sector.png)

*Figure 2: Daily Return Distributions by Sector*

**Analytical Interpretation:** Sector return distributions exhibit substantial leptokurtosis with extreme tail outliers beyond $\pm 6\%$. Technology, Energy, and Financials display wide interquartile spreads and elevated standard deviations, whereas Utilities and Consumer Staples show narrow return corridors. This variance confirms the necessity of sector dummy encodings to normalize volatility baselines.

### 3.3 Cross-Sector Return Correlation Heatmap (Figure 3)

![Figure 3: Correlation Heatmap Across Sector Returns](../plots/eda/03_sector_correlation_heatmap.png)

*Figure 3: Correlation Heatmap Across Sector Returns*

**Analytical Interpretation:** Hierarchical clustering reveals two principal macroeconomic regimes: cyclical/growth assets (Technology, Consumer Discretionary, Financials, Industrials; $r = 0.65$ to $0.82$) and defensive income assets (Utilities, Staples, Real Estate; $r = 0.40$ to $0.55$). Energy exhibits the lowest correlation to the broad market ($r \approx 0.35$–$0.45$), confirming significant sectoral diversification.

### 3.4 Momentum Oscillator Distribution: RSI-14 (Figure 4)

![Figure 4: 14-Day RSI Distribution (30/70 Bounds)](../plots/eda/04_rsi_distribution.png)

*Figure 4: 14-Day RSI Distribution (30/70 Bounds)*

**Analytical Interpretation:** The 14-day RSI approximates a Gaussian bell centered at 53.2 ($\sigma = 11.4$). Approximately 84% of instances lie within the neutral 30–70 corridor. Breakout events predominantly initiate within the 60–72 range, capturing bullish accumulation without entering extreme overbought exhaustion (>80).

### 3.5 Sectoral Breakout Frequencies (Figure 5)

![Figure 5: Breakout Frequency (%) by Industrial Sector](../plots/eda/05_breakout_frequency_by_sector.png)

*Figure 5: Breakout Frequency (%) by Industrial Sector*

**Analytical Interpretation:** Empirical breakout incidence is heavily skewed toward high-beta cyclical industries. Technology leads with a 3.42% breakout rate, followed by Industrials (2.85%) and Consumer Discretionary (2.61%). Defensive sectors generate substantially fewer breakouts (Utilities: 1.12%, Real Estate: 1.34%), reflecting lower frequency of violent accumulation events.

### 3.6 Micro-Level Case Study: NVDA Price Action and Breakouts (Figure 6)

![Figure 6: NVDA Price, Moving Averages & Breakouts](../plots/eda/06_sample_stock_breakout.png)

*Figure 6: NVDA Price, Moving Averages & Breakouts*

**Analytical Interpretation:** A granular case study on NVIDIA Corporation (NVDA) from January 2023 onward confirms detection logic integrity. Breakout alerts trigger exclusively at structural inflection points supported by volume surges (e.g., the May 2023 earnings gap). During prolonged sideways consolidation, zero false alerts fired, proving the dual price-volume rule captures valid accumulation breakouts.

---

## 4. Statistical Analysis & Preprocessing Pipeline

### 4.1 Mathematical Formulation of Technical Indicators
Technical indicators in `00_setup.R` are computed from formal definitions:
1. **Simple Moving Average (SMA):**
   $$\text{SMA}_k(t) = \frac{1}{k} \sum_{i=0}^{k-1} \text{Adj\_Close}_{t-i}, \quad k \in \{20, 50\}$$
2. **Prior 20-Day High Ceiling (`High_20_prior`):**
   $$\text{High\_20\_prior}(t) = \max_{1 \le i \le 20} (\text{Adj\_Close}_{t-i})$$
3. **Distance to Resistance (`Dist_High_20`):**
   $$\text{Dist\_High\_20}(t) = \frac{\text{Adj\_Close}_t}{\text{High\_20\_prior}(t)} - 1$$
4. **Log Volume Ratio (`Log_Vol_Ratio`):**
   $$\text{Log\_Vol\_Ratio}(t) = \ln\left(\frac{\max(\text{Volume}_t, 1)}{\max(\text{Avg\_Volume\_20}(t), 1)}\right)$$
5. **Bollinger Band Width (`BB_Width`):**
   $$\text{BB\_Width}(t) = \frac{4 \cdot \sigma_{20}(\text{Adj\_Close})}{\text{SMA}_{20}(\text{Adj\_Close})}$$

### 4.2 Pearson Correlation Screening and Multicollinearity Pruning
High collinearity inflates coefficient variance in linear models and distorts tree feature importance. An automated pruning algorithm (`drop_correlated` in `00_setup.R`) evaluated the absolute correlation matrix $\mathbf{C} = |\text{cor}(\mathbf{X}_{\text{train}})|$ strictly on the Training partition. Whenever $\max(\mathbf{C}_{ij}) > 0.90$, the feature with higher average correlation across all predictors was eliminated.

**Table 5: Collinearity Screening Audit: Pruned Features and Statistical Justifications**
| Pruned Feature Name | Highly Correlated Counterpart Feature | Pearson Correlation ($|r|$) | Statistical Pruning Rationale |
|:---|:---|:---:|:---|
| `Price_vs_SMA50` | `MACD_Pct` | **0.93** | Exceeds 0.90 threshold; `MACD_Pct` retained for dual exponential smoothing |
| `ATR_Pct` | `Volatility_20` | **0.92** | Exceeds 0.90 threshold; `Volatility_20` retained for superior distributional stability |
| `Price_vs_SMA20` | `Return_10d` | **0.91** | Exceeds 0.90 threshold; `Return_10d` directly measures momentum without moving average lag |

### 4.3 In-Sample Scaling and Feature Normalization
Distance-based and gradient models (SVM, KNN, MLP, Logistic Regression, LDA) require feature standardization. Parameters were computed strictly on the Training set to avoid data snooping:
$$\mu_j = \frac{1}{N_{\text{train}}} \sum_{i \in \text{Train}} X_{i,j}, \quad \sigma_j = \sqrt{\frac{1}{N_{\text{train}} - 1} \sum_{i \in \text{Train}} (X_{i,j} - \mu_j)^2}$$
$$Z_{i,j} = \min\left( \max\left( \frac{X_{i,j} - \mu_j}{\sigma_j}, -5.0 \right), +5.0 \right)$$
These exact parameters $(\mu_j, \sigma_j)$ standardized the Validation and Test sets, with z-scores clipped to $[-5.0, +5.0]$ to prevent numerical instability.

### 4.4 Statistical Nature of Class Imbalance
Across 121,600 observations, only 2,883 positive breakout instances exist (2.371% base rate). A naive null classifier predicting class 0 achieves 97.63% accuracy while offering zero predictive value. Two balancing techniques were used:
- **Square-Root Class Weighting:** Applied to linear models and tree ensembles. Positive instances receive weight $w_1 = \sqrt{N_0 / N_1} \approx \sqrt{75,019 / 1,881} \approx 6.31$ (negatives receive 1.0), penalizing false negatives without destabilizing gradient updates.
- **Negative Downsampling:** Applied to computationally intensive models (SVM, KNN, MLP) by downsampling training negatives to a 4:1 ratio (`DOWNSAMPLE_RATIO = 4`). Validation and Test sets remained at their natural distributions.

### 4.5 Supervised Target Engineering and Zero-Leakage Proof
Same-day breakout prediction introduces tautological leakage if features at day $t$ predict day $t$'s breakout. In this pipeline, the target is formulated as an explicit lead indicator:
$$\text{Breakout\_Today}_t = \mathbb{I}(\text{Adj\_Close}_t > \text{High\_20\_prior}_t \land \text{Volume}_t > 1.5 \times \text{Avg\_Volume\_20}_t)$$
$$\text{Target: } \mathbf{Breakout\_Next}_t = \text{Breakout\_Today}_{t+1} = \text{lead}(\text{Breakout\_Today}_t)$$

**Zero-Leakage Guarantee:** At market close on day $t$, all 23 features in $\mathbf{X}_t$ utilize data available up to day $t$. The target $y_t$ evaluates conditions strictly on day $t+1$, ensuring zero lookahead bias.

---

## 5. Machine Learning Models & Experimental Methodology

### 5.1 End-to-End Machine Learning Pipeline Architecture

```
[SQLite stocks.db: Table 'stock_data'] (123,150 rows)
               │
               ▼
[Feature Pipeline: 00_setup.R]
  - Calculates Breakout_Today & Target Breakout_Next = lead(Breakout_Today)
  - Computes 26 technical & volume indicators
  - Drops warmup rows (.rn > 30) & terminal day per ticker
               │
               ▼
[Chronological Data Splitting]
  - Train: 2016-11-21 to 2022-12-30 (76,900 rows; 2.45% pos)
  - Valid: 2023-01-03 to 2024-12-31 (25,100 rows; 2.31% pos)
  - Test:  2025-01-02 to 2026-07-28 (19,600 rows; 2.15% pos)
               │
               ▼
[In-Sample Feature Selection & Normalization]
  - Pearson correlation pruning (|r| <= 0.90) on Train -> 23 features kept
  - Z-score normalization (mean/sd from Train, clipped to [-5, 5])
               │
               ▼
[Baseline Training: 01_ml_models.R]
  - Fits 10 algorithms with default configurations
  - Generates baseline validation predictions
               │
               ▼
[Hyperparameter Tuning: 02_hyperparameter_tuning.R]
  - Random Grid Search (up to 6 trials per model) maximizing Validation PR-AUC
  - Selects optimal decision threshold (tau*) maximizing Validation F1-score
  - Scores untouched Test set ONCE -> preds_test.rds
               │
               ▼
[Visualization & Comparative Reporting: 03_model_comparison_visualization.R]
  - Exports final_comparison_table.csv, feature_importance.csv
  - Renders ROC, PR, tuning, and confusion matrix plots
```

### 5.2 Chronological Partitioning Protocol (Train / Valid / Test)
Random cross-validation produces lookahead leakage in financial time series. A strict 3-way chronological split was enforced:

**Table 6: Chronological Data Partitioning Schema Across 50 S&P 500 Equities**
| Partition Role | Calendar Date Range | Total Rows | Non-Breakouts (0) | Breakouts (1) | Breakout Rate (%) |
|:---|:---|:---:|:---:|:---:|:---:|
| **Training Set** | 2016-11-21 to 2022-12-30 | 76,900 | 75,019 | 1,881 | **2.446%** |
| **Validation Set** | 2023-01-03 to 2024-12-31 | 25,100 | 24,520 | 580 | **2.311%** |
| **Test Set (Held-Out)** | 2025-01-02 to 2026-07-28 | 19,600 | 19,178 | 422 | **2.153%** |
| **Complete Matrix** | **2016-11-21 to 2026-07-28** | **121,600** | **118,717** | **2,883** | **2.371%** |

### 5.3 Formulations of the Ten Supervised Classifiers
1. **Logistic Regression (`stats::glm`):** Linear model estimating log-odds via logit link: $\ln(p / (1 - p)) = \beta_0 + \sum_{j=1}^{23} \beta_j X_j$. Fitted with weighted maximum likelihood ($w_1 \approx 6.31$).
2. **Decision Tree (`rpart::rpart`):** CART algorithm recursively splitting on Gini impurity reduction with observation weights $w_1$ and complexity pruning `cp`.
3. **Random Forest (`ranger::ranger`):** Ensembles 300 bootstrap trees with random feature subsampling ($m_{\text{try}} = 4$). Fast C++ implementation generating probability outputs.
4. **Gradient Boosting Machine (`gbm::gbm`):** Sequential boosting optimizing Bernoulli deviance loss with shrinkage $\eta = 0.03$ and subsampling `bag.fraction = 0.7`.
5. **XGBoost (`xgboost::xgb.train`):** Optimized gradient boosting with second-order Taylor loss expansion, L1/L2 leaf penalties, and column subsampling (`colsample_bytree = 0.8`).
6. **Support Vector Machine (`e1071::svm`):** Radial Basis Function (RBF) kernel margin classifier $K(x, x') = \exp(-\gamma ||x - x'||^2)$ with Platt scaling on downsampled data.
7. **K-Nearest Neighbours (`class::knn`):** Non-parametric classifier assigning probability from positive instance density in 23-dimensional Euclidean neighborhood ($K = 81$).
8. **Naive Bayes (`e1071::naiveBayes`):** Computes class posteriors via Bayes' rule under feature conditional independence using Gaussian distributions with Laplace smoothing.
9. **Linear Discriminant Analysis (`MASS::lda`):** Projects features along Fisher's discriminant axis maximizing between-to-within class variance ratio under pooled covariance.
10. **Neural Network / MLP (`nnet::nnet`):** Single-hidden-layer perceptron (sigmoid activation) trained via BFGS quasi-Newton backpropagation with weight decay penalty $\lambda = 0.10$.

### 5.4 Hyperparameter Optimization via Random Grid Search
Hyperparameter tuning sampled configurations via random grid search, selecting optimal parameters on Validation PR-AUC.

**Table 7: Hyperparameter Tuning Grid Allocations, Trial Counts, and Optimal Selections**
| Model | Hyperparameter Search Space | Trials | Optimal Selected Parameters | Validation PR-AUC |
|:---|:---|:---:|:---|:---:|
| **Decision Tree** | `cp` $\in \{5e-4, 1e-3, 5e-3\}$, `maxdepth` $\in \{4, 6, 8\}$, `minsplit` $\in \{30, 100\}$ | 6 | `cp = 0.001, maxdepth = 8, minsplit = 100` | 0.1059 |
| **Random Forest** | `num.trees = 300`, `mtry` $\in \{3, 5, 8\}$, `min.node.size` $\in \{5, 20, 50\}$ | 6 | `num.trees = 300, mtry = 3, min.node.size = 50` | 0.1312 |
| **Gradient Boosting**| `n.trees` $\in \{150, 300\}$, `depth` $\in \{2, 3, 5\}$, `shrinkage` $\in \{0.03, 0.1\}$ | 6 | `n.trees = 150, depth = 5, shrinkage = 0.03, minobs = 20` | **0.1403** |
| **XGBoost** | `nrounds` $\in \{150, 300\}$, `depth` $\in \{3, 4, 6\}$, `eta` $\in \{0.03, 0.1\}$, `subsample` $\in \{0.7, 1.0\}$ | 6 | `nrounds = 300, depth = 4, eta = 0.03, subsample = 0.7` | **0.1437** |
| **SVM (Radial)** | `cost` $\in \{0.5, 2, 8, 32\}$, `gamma` $\in \{0.01, 0.03, 0.1\}$ | 6 | `cost = 0.5, gamma = 0.03` | 0.1211 |
| **KNN** | $k \in \{5, 11, 21, 41, 81\}$ | 5 | `k = 81` | 0.1277 |
| **Naive Bayes** | `laplace` $\in \{0, 1\}$ | 2 | `laplace = 0` | 0.1199 |
| **Neural Network** | `size` $\in \{4, 8, 16\}$, `decay` $\in \{0.001, 0.01, 0.1\}$, `maxit = 300` | 6 | `size = 4, decay = 0.1, maxit = 300` | 0.1319 |
| **Logistic Regression**| Deterministic analytic solution (weighted GLM) | 1 | Default analytic solution ($w_1 \approx 6.31$) | 0.1272 |
| **LDA** | Deterministic analytic solution (Fisher projection) | 1 | Default analytic solution | 0.1337 |

### 5.5 Decision Threshold Calibration on Validation PR-AUC
Under severe class imbalance, predicted probabilities cluster near zero, rendering the default $\tau = 0.50$ threshold ineffective. Thresholds were optimized strictly on the Validation set to maximize F1-score:
$$\tau^* = \arg\max_{\tau} \left[ \frac{2 \cdot \text{Precision}(\tau) \cdot \text{Recall}(\tau)}{\text{Precision}(\tau) + \text{Recall}(\tau)} \right]$$
The calibrated thresholds $\tau^*$ were locked and transferred directly to the Test set without data snooping.

---

## 6. Output Screenshots, Model Evaluation & Comparative Results

### 6.1 Final Benchmark Results on Held-Out Test Set (2025–2026)

**Table 8: Final Comprehensive Model Evaluation Benchmark on the Untouched Test Set (2025–2026)**
| Rank & Model Name | ROC-AUC | PR-AUC | Precision | Recall | F1-Score | Optimal Threshold ($\tau^*$) |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| **1. Gradient Boosting (GBM)** | **0.8536** | **0.1721** | 0.2015 | 0.3128 | **0.2451** | 0.4717 |
| **2. Neural Network (MLP)** | **0.8582** | **0.1645** | 0.1664 | **0.4265** | **0.2394** | 0.5345 |
| **3. XGBoost** | 0.8573 | 0.1630 | 0.2098 | 0.2844 | 0.2414 | 0.4752 |
| **4. Linear Discriminant Analysis** | 0.8523 | 0.1549 | 0.2106 | 0.2536 | 0.2301 | 0.1289 |
| **5. K-Nearest Neighbours (KNN)** | 0.8460 | 0.1518 | **0.2217** | 0.2464 | 0.2334 | 0.5185 |
| **6. Random Forest** | 0.8447 | 0.1490 | 0.2111 | 0.2156 | 0.2134 | 0.1529 |
| **7. Logistic Regression** | 0.8554 | 0.1482 | 0.1821 | 0.3223 | 0.2327 | 0.4071 |
| **8. Naive Bayes** | 0.8135 | 0.1409 | 0.2073 | 0.2299 | 0.2180 | 0.9747 |
| **9. Decision Tree (CART)** | 0.8189 | 0.1374 | 0.1925 | 0.2938 | 0.2326 | 0.5128 |
| **10. SVM (Radial Kernel)** | 0.8079 | 0.1329 | 0.1941 | 0.2654 | 0.2242 | 0.2659 |
| *Baseline: Uninformed Random Guess* | *0.5000* | *0.0215* | *0.0215* | *1.0000* | *0.0421* | *N/A* |

### 6.2 Precision-Recall (PR) Curve Diagnostics (Figure 7)

![Figure 7: Precision-Recall Curves on Test Set](../plots/ml/02_precision_recall_curves_test.png)

*Figure 7: Precision-Recall Curves on Test Set across All 10 Classifiers*

**Analytical Interpretation:** PR curves isolate performance under extreme class imbalance. Gradient Boosting maintains top precision across the 10%–40% recall corridor, reaching PR-AUC of 0.1721—an **$8.0\times$ lift** over the random guessing baseline (0.0215). Neural Network (MLP) achieves competitive precision at higher recall (>40%), while Decision Tree (0.1374) and SVM (0.1329) trail due to coarse step functions and probability miscalibration.

### 6.3 Receiver Operating Characteristic (ROC) Diagnostics (Figure 8)

![Figure 8: ROC Curves on Test Set](../plots/ml/01_roc_curves_test.png)

*Figure 8: Receiver Operating Characteristic (ROC) Curves on Test Set*

**Analytical Interpretation:** All ten models demonstrate robust general discrimination, with ROC-AUC exceeding 0.80. Neural Network (0.8582), XGBoost (0.8573), Logistic Regression (0.8554), and Gradient Boosting (0.8536) form a tightly clustered top tier. Because ROC curves are insensitive to class imbalance by evaluating False Positive Rate against True Positive Rate, PR-AUC serves as the decisive evaluation benchmark.

### 6.4 Multi-Metric Model Comparison (Figure 9)

![Figure 9: Multi-Metric Model Comparison](../plots/ml/03_model_comparison_test.png)

*Figure 9: Multi-Metric Model Comparison on Test Data (ROC-AUC, PR-AUC, F1)*

**Analytical Interpretation:** While ROC-AUC varies within a narrow 0.808–0.858 band, PR-AUC spans a wide 0.1329–0.1721 range, establishing that PR-AUC provides greater discriminatory separation. F1-scores align with PR-AUC rankings, confirming that models maximizing PR-AUC also deliver superior harmonic balance between precision and recall at calibrated operational thresholds.

### 6.5 Validation Hyperparameter Tuning Improvement (Figure 10)

![Figure 10: Validation PR-AUC Tuning Impact](../plots/ml/04_tuning_improvement.png)

*Figure 10: Validation-Stage Performance Delta Before vs. After Hyperparameter Tuning*

**Analytical Interpretation:** Hyperparameter tuning generated measurable improvements across all flexible architectures. Decision Tree gained +8.3% PR-AUC by tuning minimum leaf splits. KNN advanced +12.3% as increasing $k$ from 5 to 81 smoothed local noise. Neural Network gained +17.5% through weight decay regularization ($\lambda = 0.10$), which prevented over-fitting on sparse positive training instances.

### 6.6 Feature Importance Attribution (Figure 11)

![Figure 11: Feature Importance (GBM, RF, XGBoost)](../plots/ml/05_feature_importance.png)

*Figure 11: Top 12 Predictive Features for Gradient Boosting, Random Forest, and XGBoost*

**Analytical Interpretation:** In the winning Gradient Boosting model, proximity to the 20-day high (`Dist_High_20`: 43.13%) and relative volume expansion (`Log_Vol_Ratio`: 40.57%) account for **83.70%** of total predictive importance. Same-day breakout persistence (`Breakout_Today`: 4.41%), 5-day return (2.19%), moving average trend (1.23%), and RSI-14 (1.22%) contribute minor incremental signal. This confirms that consolidation compression followed by volume accumulation is the primary statistical pre-condition for breakout continuation.

### 6.7 Confusion Matrix Diagnostics of Champion Model (Figure 12)

![Figure 12: Confusion Matrix Heatmap (GBM)](../plots/ml/06_confusion_matrix_best_model.png)

*Figure 12: Confusion Matrix Heatmap of Best Performing Model (Gradient Boosting)*

**Analytical Interpretation:** Evaluated at optimal validation threshold $\tau^* = 0.4717$ on 19,600 test instances:
- **True Negatives (TN):** $18,655$ ($97.27\%$ specificity on non-breakout sessions).
- **False Positives (FP):** $523$ (spurious breakout alerts).
- **False Negatives (FN):** $290$ (missed breakouts).
- **True Positives (TP):** $132$ (confirmed breakouts predicted 24 hours in advance).
- **Operational Metrics:** Precision = $132 / 655 = 20.15\%$ (1 confirmed breakout in every 5 alerts); Recall = $132 / 422 = 31.28\%$ (captures nearly one-third of all breakout events across 50 equities); F1-Score = $0.2451$.

### 6.8 Critical Comparative Discussion
Gradient Boosting surpassed competing algorithms by building sequential trees that incrementally minimize Bernoulli loss gradients, creating refined non-linear decision boundaries. Decision trees (CART) suffered from high variance and rigid axis-aligned cuts (PR-AUC 0.1374). Random Forest achieved solid discrimination (PR-AUC 0.1490) but tended to over-smooth probability distributions due to unweighted bagging.

Neural Network (MLP) attained the highest recall (42.65%) and ROC-AUC (0.8582), but lower precision (16.64%) due to probability dispersion in noisy regimes. K-Nearest Neighbours attained the highest precision (22.17%) when $k$ was tuned to 81, proving large-neighborhood averaging effectively suppresses idiosyncratic noise. Linear models (Logistic Regression, LDA) achieved respectable PR-AUC (~0.148–0.155), confirming linear separability among engineered features, but lacked the interaction capacity of boosted trees.

---

## 7. Conclusion & Future Scope

### 7.1 Summary of Engineering and Research Accomplishments
This study implemented and validated an end-to-end quantitative machine learning pipeline in RStudio to predict next-trading-day momentum breakouts across 50 S&P 500 constituents over a 10-year period (2016–2026). Key accomplishments include:
- **Relational Data Architecture:** Populated an SQLite database (`stocks.db`) with 125,650 OHLCV records across ten GICS sectors with zero missing values or duplicate timestamps.
- **Leak-Free Feature Pipeline:** Formulated 26 candidate features, pruning collinear indicators ($|r| \le 0.90$) to retain 23 normalized predictors.
- **Methodological Discipline:** Enforced a zero-leakage next-day target ($\text{Breakout\_Next}$ at $t+1$) and a strict 3-way chronological split (Train 2016–2022, Valid 2023–2024, Test 2025–2026).
- **Comprehensive Benchmarking:** Evaluated ten supervised models under square-root class weighting and downsampling, optimizing decision thresholds on validation PR-AUC.
- **Top Algorithm:** Gradient Boosting (GBM) emerged as champion with a test PR-AUC of 0.1721 ($8.0\times$ lift over random guessing) and an F1-score of 0.2451.

### 7.2 Empirical Takeaways on Market Predictability
- **Non-Random Pre-Breakout Regimes:** Momentum breakouts exhibit quantifiable statistical signatures in volume surge and resistance proximity ahead of price expansion.
- **Signal Dominance:** Volume expansion (`Log_Vol_Ratio`) and resistance distance (`Dist_High_20`) account for 83.70% of boosted tree predictive power.
- **Metric Selection:** Under class imbalance, PR-AUC and F1 under calibrated thresholds are essential; raw accuracy is fundamentally uninformative.

### 7.3 Methodological and Financial Limitations
- **Execution Slippage:** The model evaluates daily closing prices; live market orders during fast breakout moves incur execution slippage.
- **Macroeconomic Regimes:** Historical patterns can degrade during abrupt macroeconomic or geopolitical crises.
- **Survivorship Bias:** The universe contains current 2026 constituents, excluding historical delistings.

### 7.4 Future Research Directions
- **Alternative Data Sources:** Integrating news sentiment, social media momentum, and options implied volatility surfaces.
- **Sequence Deep Learning:** Implementing LSTM networks and Temporal Fusion Transformers to capture multi-day temporal trajectories.
- **Vectorized Backtesting:** Developing an execution simulation incorporating transaction costs, slippage, and dynamic position sizing.

---

## 8. Important R Code Snippets

### 8.1 SQLite Database Ingestion (`database_connectivity.R`)
```r
library(DBI); library(RSQLite)
con <- dbConnect(RSQLite::SQLite(), dbname = "stocks.db")
stock_data <- read.csv("processed_dataset.csv")
stock_data$Date <- as.character(as.Date(stock_data$Date))
dbWriteTable(con, "stock_data", stock_data, overwrite = TRUE, row.names = FALSE)
dbGetQuery(con, "SELECT COUNT(*) AS total_rows FROM stock_data")
dbDisconnect(con)
```

### 8.2 Leakage-Free Target Formulation (`00_setup.R`)
```r
raw %>%
  arrange(Ticker, Date) %>% group_by(Ticker) %>%
  mutate(
    High_20_prior  = roll_max_prior(Adj_Close, 20),
    Breakout_Today = as.integer(Adj_Close > High_20_prior & Volume > 1.5 * Avg_Volume_20),
    Breakout_Next  = lead(Breakout_Today),  # TARGET at t+1
    Log_Vol_Ratio  = log(pmax(Volume, 1) / pmax(Avg_Volume_20, 1)),
    Dist_High_20   = Adj_Close / High_20_prior - 1
  ) %>% ungroup() %>% filter(.rn > 30, !is.na(Breakout_Next))
```

### 8.3 Automated Pearson Correlation Pruning (`00_setup.R`)
```r
drop_correlated <- function(X, cutoff = 0.90) {
  cm <- abs(cor(X)); diag(cm) <- 0
  out <- data.frame(feature = character(), reason = character(), stringsAsFactors = FALSE)
  repeat {
    mx <- max(cm)
    if (mx <= cutoff) break
    idx <- which(cm == mx, arr.ind = TRUE)[1, ]
    a <- idx[1]; b <- idx[2]
    d <- if (mean(cm[a, ]) >= mean(cm[b, ])) a else b
    o <- if (d == a) b else a
    out[nrow(out) + 1, ] <- list(colnames(cm)[d], sprintf("correlated with %s (|r| = %.2f)", colnames(cm)[o], mx))
    cm[d, ] <- 0; cm[, d] <- 0
  }
  out
}
```

### 8.4 Gradient Boosting (GBM) Model Definition (`01_ml_models.R`)
```r
fit_gbm <- function(d, p) {
  set.seed(SEED)
  w <- ifelse(d$y == 1, class_weight(d$y), 1)
  m <- gbm::gbm(y ~ ., data = d[, c("y", FEATURES)], distribution = "bernoulli",
                n.trees = p$n.trees, interaction.depth = p$interaction.depth,
                shrinkage = p$shrinkage, n.minobsinnode = p$n.minobsinnode,
                bag.fraction = 0.7, weights = w, verbose = FALSE, n.cores = 1)
  list(raw = m, predict = function(nd) {
    as.numeric(predict(m, nd[, FEATURES], n.trees = p$n.trees, type = "response"))
  })
}
```

### 8.5 Precision-Recall Area Under Curve (`00_setup.R`)
```r
pr_auc <- function(y, p) {
  ord <- order(p, decreasing = TRUE); ys <- y[ord]; ps <- p[ord]
  tp <- cumsum(ys); fp <- cumsum(1 - ys)
  last <- c(ps[-length(ps)] != ps[-1], TRUE)
  tp <- tp[last]; fp <- fp[last]
  sum(diff(c(0, tp / sum(y))) * (tp / (tp + fp)))
}
```

### 8.6 Optimal F1 Threshold Calibration (`00_setup.R`)
```r
best_f1_threshold <- function(y, p) {
  ord <- order(p, decreasing = TRUE); ys <- y[ord]; ps <- p[ord]
  tp <- cumsum(ys); fp <- cumsum(1 - ys); fn <- sum(ys) - tp
  f1 <- 2 * tp / (2 * tp + fp + fn)
  last <- c(ps[-length(ps)] != ps[-1], TRUE)
  f1[!last] <- -1
  ps[which.max(f1)]
}
```

---

## 9. GitHub Repository & Execution Guide

### 9.1 Official Repository Link
- **Repository URL:** [https://github.com/JonSnow42/Stock-Price-Breakout](https://github.com/JonSnow42/Stock-Price-Breakout)
- **Account:** `JonSnow42` | **Repository:** `Stock-Price-Breakout` | **Branch:** `main`

### 9.2 Repository Architecture and Directory Map
```
Stock-Price-Breakout/
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
├── README.md                            # Comprehensive project overview and instructions
├── plots/
│   ├── README.md                        # Visualizations index and directory guide
│   ├── eda/                             # Dedicated directory for 6 EDA figures (01 to 06)
│   │   ├── README.md                    # Technical documentation for all EDA plots
│   │   ├── 01_sector_price_trend.png
│   │   ├── 02_return_distribution_by_sector.png
│   │   ├── 03_sector_correlation_heatmap.png
│   │   ├── 04_rsi_distribution.png
│   │   ├── 05_breakout_frequency_by_sector.png
│   │   └── 06_sample_stock_breakout.png
│   └── ml/                              # Dedicated directory for 6 ML evaluation figures (01 to 06)
│       ├── README.md                    # Technical documentation for all ML evaluation plots
│       ├── 01_roc_curves_test.png
│       ├── 02_precision_recall_curves_test.png
│       ├── 03_model_comparison_test.png
│       ├── 04_tuning_improvement.png
│       ├── 05_feature_importance.png
│       └── 06_confusion_matrix_best_model.png
├── results/
│   ├── README.md                        # Documentation of results tables, RDS objects, and metrics
│   ├── final_comparison_table.csv       # Test metrics across all models
│   ├── feature_importance.csv           # Importance scores for GBM, RF, XGBoost
│   ├── feature_selection_dropped.csv    # Log of pruned collinear features
│   └── *.rds                            # Serialized model predictions & parameters
└── Final_Report/
    ├── README.md                        # Report overview and compilation instructions
    ├── FULL_ACADEMIC_REPORT.md          # Complete master academic report (Markdown format)
    ├── Final_Academic_Report.docx       # Editable Microsoft Word document
    ├── Final_Academic_Report.pdf        # Verified 20-25 page PDF document
    └── build_report.R                   # Native R report build and verification script
```

### 9.3 Step-by-Step Execution Workflow
1. **Clone Repository:** `git clone https://github.com/JonSnow42/Stock-Price-Breakout.git`
2. **Install Packages in R:**
   ```r
   install.packages(c("DBI", "RSQLite", "dplyr", "ggplot2", "pROC",
                      "ranger", "gbm", "xgboost", "e1071", "rpart",
                      "class", "nnet", "MASS", "corrplot", "tidyr", "readr"))
   ```
3. **Database Staging:** `source("database_connectivity.R")`
4. **Exploratory Visualizations:** `source("ed22.R")`
5. **Baseline Training:** `source("01_ml_models.R")`
6. **Hyperparameter Tuning:** `source("02_hyperparameter_tuning.R")`
7. **Model Comparison Visualizations:** `source("03_model_comparison_visualization.R")`
8. **Report Verification:** `source("Final_Report/build_report.R")`

---

## 10. References

[1] Fama, E. F. (1970). Efficient Capital Markets: A Review of Theory and Empirical Work. *Journal of Finance*, 25(2), 383–417. https://doi.org/10.2307/2325486  
[2] Jegadeesh, N., & Titman, S. (1993). Returns to Buying Winners and Selling Losers: Implications for Stock Market Efficiency. *Journal of Finance*, 48(1), 65–91. https://doi.org/10.1111/j.1540-6261.1993.tb04702.x  
[3] Friedman, J. H. (2001). Greedy Function Approximation: A Gradient Boosting Machine. *Annals of Statistics*, 29(5), 1189–1232. https://doi.org/10.1214/aos/1013203451  
[4] Chen, T., & Guestrin, C. (2016). XGBoost: A Scalable Tree Boosting System. *Proceedings of the 22nd ACM SIGKDD International Conference on Knowledge Discovery and Data Mining*, 785–794. https://doi.org/10.1145/2939672.2939785  
[5] Breiman, L. (2001). Random Forests. *Machine Learning*, 45(1), 5–32. https://doi.org/10.1023/A:1010933404324  
[6] Wright, M. N., & Ziegler, A. (2017). ranger: A Fast Implementation of Random Forests for High Dimensional Data in C++ and R. *Journal of Statistical Software*, 77(1), 1–17. https://doi.org/10.18637/jss.v077.i01  
[7] Saito, T., & Rehmsmeier, M. (2015). The Precision-Recall Plot Is More Informative than the ROC Plot When Evaluating Binary Classifiers on Imbalanced Datasets. *PLOS ONE*, 10(3), e0118432. https://doi.org/10.1371/journal.pone.0118432  
[8] Robin, X., Turck, N., Hainard, A., Tiberti, N., Lisacek, F., Sanchez, J.-C., & Müller, M. (2011). pROC: An Open-Source Package for R and S+ to Analyze and Compare ROC Curves. *BMC Bioinformatics*, 12, 77. https://doi.org/10.1186/1471-2105-12-77  
[9] Wickham, H. (2016). *ggplot2: Elegant Graphics for Data Analysis*. Springer-Verlag New York. ISBN 978-3-319-24277-4.  
[10] Ripley, B. D. (1996). *Pattern Recognition and Neural Networks*. Cambridge University Press. ISBN 978-0-521-46086-5.  
[11] Venables, W. N., & Ripley, B. D. (2002). *Modern Applied Statistics with S* (4th ed.). Springer. ISBN 0-387-95457-0.  
[12] Chang, C.-C., & Lin, C.-J. (2011). LIBSVM: A Library for Support Vector Machines. *ACM Transactions on Intelligent Systems and Technology*, 2(3), 27:1–27:27.  
[13] Heliyon. (2024). Explainable Deep Learning Approach for Stock Market Trend Prediction. *Heliyon*, 10(21), e40095. https://doi.org/10.1016/j.heliyon.2024.e40095  
[14] AppliedMath. (2025). Stock Market Prediction Using Machine Learning and Deep Learning Techniques: A Review. *AppliedMath*, 5(3), 76. https://doi.org/10.3390/appliedmath5030076  
[15] Yahoo Finance Historical Market Data API. Accessed via R and Yahoo Finance. https://finance.yahoo.com  
