# Stock Market Trend Analysis and Momentum Breakout Prediction
## Capstone Project Presentation Deck (14 Slides)

**Candidate:** Saurabh Madhesia (Reg. No.: `24BDS1082`)  
**Department:** School of Computer Science & Engineering, Vellore Institute of Technology (VIT Chennai)  
**Faculty Guide:** Dr. Vijayalakshmi A, Associate Professor / Professor, SCOPE, VIT Chennai  
**Academic Year:** 2026–27  
**Artifact Deliverables:**
- **PowerPoint Presentation:** [`Final_Report/Stock_Market_Breakout_Presentation.pptx`](file:///home/saurabh/Stock_Project/Final_Report/Stock_Market_Breakout_Presentation.pptx)
- **PDF Presentation:** [`Final_Report/Stock_Market_Breakout_Presentation.pdf`](file:///home/saurabh/Stock_Project/Final_Report/Stock_Market_Breakout_Presentation.pdf)
- **R Orchestrator Script:** [`Final_Report/build_presentation.R`](file:///home/saurabh/Stock_Project/Final_Report/build_presentation.R)
- **Public GitHub Repository:** [https://github.com/JonSnow42/Stock-Price-Breakout](https://github.com/JonSnow42/Stock-Price-Breakout)

---

### Slide Deck Architecture & Slide-by-Slide Outline

```
┌────────────────────────────────────────────────────────────────────────┐
│                      14-SLIDE PRESENTATION MAP                         │
├────────┬───────────────────────────────────────────────────────────────┤
│ Slide  │ Topic & Key Focus                                             │
├────────┼───────────────────────────────────────────────────────────────┤
│  01    │ Title Slide: Metadata, Affiliation, & Official VIT Crest      │
│  02    │ Background & Problem Overview: 4 Structural Market Challenges │
│  03    │ Project Objectives: Primary Goal & 4 Core Milestones          │
│  04    │ Dataset & Database Architecture: 125k Rows & stocks.db Schema │
│  05    │ EDA: Sector-Wise Price Trends (2016–2026 Indexed Dynamics)    │
│  06    │ EDA: Sector Correlations & Breakout Asymmetry Heatmap         │
│  07    │ Feature Engineering: Mathematical Target & Pearson Pruning    │
│  08    │ Chronological Splitting & Class Imbalance Strategy (w1=6.31)  │
│  09    │ Ten Supervised Machine Learning Algorithms (Diverse Paradigms)│
│  10    │ Model Benchmark Results on Held-Out Test Set (Full Ranking)   │
│  11    │ Model Diagnostics: PR-AUC vs. ROC-AUC Diagnostic Curves       │
│  12    │ Feature Importance: 83.7% Drivers (Resistance + Volume)       │
│  13    │ Champion Model Confusion Matrix & Quantitative Utility        │
│  14    │ Conclusion, Limitations, Future Scope & Project Links         │
└────────┴───────────────────────────────────────────────────────────────┘
```

---

### Slide 1: Title Slide
- **Background:** Deep Navy (`#0B1D3A`) with subtle cyan and white accents.
- **Visuals:** Embedded high-resolution official VIT logo (`assets/vit_logo.png`).
- **Header Badge:** `B.TECH DATA SCIENCE CAPSTONE PROJECT · ACADEMIC YEAR 2026–27`
- **Title:** Stock Market Trend Analysis and Momentum Breakout Prediction
- **Subtitle:** *A 10-Year Quantitative Machine Learning Study Across 50 S&P 500 Equities (2016–2026)*
- **Author Details:**
  - Submitted by: Saurabh Madhesia | Reg. No.: 24BDS1082
  - Department: School of Computer Science & Engineering, VIT Chennai
- **Guide Details:**
  - Under the Guidance of: Dr. Vijayalakshmi A, Associate Professor / Professor
  - School of Computer Science & Engineering (SCOPE), VIT Chennai
- **Speaker Notes:**
  > "Good morning respected guide, panel members, and evaluators. Today, I am presenting my B.Tech Data Science capstone project titled 'Stock Market Trend Analysis and Momentum Breakout Prediction'. In this project, we designed and implemented a leak-free, out-of-time machine learning framework in RStudio to forecast short-term momentum breakouts across 50 representative US equities using 10 years of historical data."

---

### Slide 2: Background & Problem Overview
- **Header:** Background & Problem Overview
- **Subtitle:** What is a momentum breakout, and why does predicting it matter?
- **Top Definition Banner:** *A Momentum Breakout occurs when an equity price forcefully closes above an established multi-week consolidation resistance ceiling accompanied by extraordinary trading volume, signaling institutional accumulation.*
- **4 Key Challenge Cards:**
  1. **01 · Subjective Analysis:** Traditional chart-reading relies on manual visual heuristics; two analysts often reach conflicting conclusions on identical charts.
  2. **02 · High False-Positive Rate:** Simple 20-day high screeners frequently trigger false breakouts ('bull traps') that reverse downward intraday.
  3. **03 · Severe Class Imbalance:** True momentum breakouts are statistically rare (~2.15%–2.45% of trading days), rendering raw classification accuracy misleading.
  4. **04 · Lookahead Bias Risk:** Financial models often inadvertently leak same-day volume or closing prices into prediction features, invalidating live results.
- **Speaker Notes:**
  > "Momentum breakouts represent the foundation of trend-following strategies, yet real-world quantitative execution faces four major roadblocks: chartist subjectivity, widespread bull traps, severe class rarity where only 2% of daily sessions are genuine breakouts, and lookahead leakage. Our project aims to replace qualitative heuristics with rigorous, reproducible supervised learning."

---

### Slide 3: Project Objectives
- **Header:** Project Objectives
- **Subtitle:** Core engineering and analytical goals of the machine learning pipeline
- **Primary Objective Banner:** *Build and empirically benchmark a 100% leak-free, reproducible machine learning pipeline in RStudio to forecast next-trading-day (t+1) momentum breakout opportunities across large-cap US equities.*
- **4 Strategic Milestone Cards:**
  1. **1. 10-Year Multi-Sector Data:**
     - 125,650 daily OHLCV observations (2016–2026)
     - 50 large-cap S&P 500 equities across 10 GICS sectors
     - Zero missing values or duplicate records
  2. **2. Relational DB (`stocks.db`):**
     - SQLite database initialized via DBI & RSQLite
     - Fast relational staging of raw & processed data
     - Complete audit logging for tuning & model runs
  3. **3. Feature Engineering & Pruning:**
     - 26 candidate technical, volatility & volume metrics
     - Automated Pearson pruning (|r| <= 0.90) drops 3 collinear variables
     - 23 standardized predictors retained
  4. **4. ML Benchmarking & Tuning:**
     - 10 supervised classifiers across diverse paradigms
     - Square-root weighting & downsampling for rare events
     - Decision thresholds optimized on validation PR-AUC
- **Speaker Notes:**
  > "Our primary objective was to engineer a clean, end-to-end predictive pipeline. We set four specific milestones: acquiring a clean 10-year multi-sector dataset, structuring it in SQLite, deriving 26 technical and volume features with collinearity pruning, and rigorously benchmarking ten supervised learning algorithms."

---

### Slide 4: Dataset & Database Architecture
- **Header:** Dataset & Database Architecture
- **Subtitle:** Curated S&P 500 constituent universe and relational SQLite storage
- **Top 3 KPI Badges:**
  - `125,650` Raw OHLCV Observations (50 stocks × 10 years, 2016–2026)
  - `10 Sectors` GICS Diversification (Tech, Finance, Healthcare, Energy, etc.)
  - `121,600` Final Model Instances (23 standardized non-collinear features)
- **Left Container (Dataset Lifecycle):**
  - **Master Dataset (`master_dataset.csv`):** 125,650 rows × 9 cols; raw Yahoo Finance daily feed (15.3 MB).
  - **Processed Dataset (`processed_dataset.csv`):** 123,150 rows × 45 cols; 50-day rolling warm-up window removed (73.4 MB).
  - **Data Integrity Audit:** Zero missing values (NA/NaN); zero duplicate dates; corporate actions (splits/dividends) fully adjusted.
- **Right Container (SQLite Schema `stocks.db` · 63.1 MB):**
  - `Table 1: stock_data` (123,150 rows × 45 cols) — Relational warehouse for fast queries.
  - `Table 2: model_features` (121,600 rows × 27 cols) — Standardized features with split tags.
  - `Table 3: model_results` (33 benchmark records) — Official tracking registry.
  - `Table 4: tuning_log` (47 search trials) — Hyperparameter validation logs.
- **Speaker Notes:**
  > "We selected 50 representative S&P 500 stocks spanning all major GICS sectors from 2016 to 2026. The raw data contains 125,650 rows. After dropping the 50-day warm-up window necessary for 50-day moving averages, 121,600 records were ingested into our relational SQLite database across four structured tables."

---

### Slide 5: Exploratory Data Analysis: Sector Price Trends
- **Header:** Exploratory Data Analysis: Sector Price Trends
- **Subtitle:** Multi-year sector price performance and volatility divergence (2016–2026)
- **Left Visual:** Embedded high-resolution graphic [`plots/eda/01_sector_price_trend.png`](file:///home/saurabh/Stock_Project/plots/eda/01_sector_price_trend.png) showing normalized sector trajectories.
- **Right Analytical Takeaways:**
  1. **Mega-Cap Technology Outperformance:** Technology expanded from a base of 100 to over 750, driven by the cloud software boom and the 2023–2026 generative AI semiconductor surge (NVDA, MSFT, AAPL).
  2. **Defensive vs. Cyclical Divergence:** Defensive sectors (Utilities, Real Estate, Consumer Staples) grew moderately (120–180), displaying steady, low-beta price trajectories.
  3. **Volatility Heterogeneity:** High-beta sectors experienced large cyclical drawdowns (e.g., 2020 COVID crash, 2022 Fed rate tightening), confirming that baseline volatility varies substantially across sectors.
- **Speaker Notes:**
  > "As shown in Figure 1, the ten GICS sectors display massive structural divergence over the decade. Technology surged over 7.5x, while Utilities and Consumer Staples exhibited calm, low-beta progressions. This disparity confirmed that breakout behaviors cannot be modeled with single static thresholds without accounting for sector heterogeneity."

---

### Slide 6: Sector Correlations & Breakout Asymmetry
- **Header:** Sector Correlations & Breakout Asymmetry
- **Subtitle:** Cross-sector return correlation heatmap and empirical breakout prevalence
- **Left Visual:** Embedded high-resolution graphic [`plots/eda/03_sector_correlation_heatmap.png`](file:///home/saurabh/Stock_Project/plots/eda/03_sector_correlation_heatmap.png) showing lower-triangular pairwise correlations.
- **Right Analytical Takeaways:**
  1. **Cyclical & Growth Co-Movement:** Hierarchical clustering groups Technology, Consumer Discretionary, Financials, and Industrials into a strong co-moving cluster ($r = 0.65$ to $0.82$).
  2. **Defensive & Energy Independence:** Utilities, Real Estate, and Staples form a defensive cluster ($r = 0.40$ to $0.55$). Energy exhibits the lowest correlation to the broad market ($r \approx 0.35$–$0.45$).
  3. **Breakout Asymmetry by Sector:** Breakout frequency is highest in high-beta industries (Technology: 3.42%, Industrials: 2.85%) and lowest in Utilities (1.12%), proving breakout probability is fundamentally sector-dependent.
- **Speaker Notes:**
  > "Figure 2 illustrates sector co-movement. We observe strong clustering among cyclical equities, while Energy and Utilities provide diversification. Importantly, the empirical breakout frequency ranges from 3.42% in Technology down to 1.12% in Utilities, underscoring the necessity of one-hot sector encoding."

---

### Slide 7: Feature Engineering & Zero-Leakage Target
- **Header:** Feature Engineering & Zero-Leakage Target
- **Subtitle:** Quantitative target definition and multicollinearity pruning protocol
- **Top Formula Cards:**
  - **1. Same-Day Breakout Event ($Day\ t$):**
    $$\text{Breakout\_Today}(t) = \mathbb{I}(\text{Adj\_Close}(t) > \text{High\_20\_prior}(t) \ \land \ \text{Volume}(t) > 1.5 \times \text{Avg\_Volume\_20}(t))$$
  - **2. Supervised Target Label ($Day\ t+1\ \text{Lead}$):**
    $$\text{Target} = \text{Breakout\_Next}(t) = \text{Breakout\_Today}(t + 1) = \text{lead}(\text{Breakout\_Today}(t), 1)$$
- **Bottom Left: Mathematical Proof of Zero Leakage:**
  - *Strict Information Cutoff:* At market close of day $t$, all 23 predictors utilize prices and volumes strictly up to day $t$.
  - *Predicting Future State:* The target evaluates conditions occurring strictly on day $t+1$, allowing quantitative traders to position capital before market open.
- **Bottom Right: Automated Pearson Pruning ($|r| > 0.90$):**
  - `Price_vs_SMA50` dropped due to $|r| = 0.93$ with `MACD_Pct`
  - `ATR_Pct` dropped due to $|r| = 0.92$ with `Volatility_20`
  - `Price_vs_SMA20` dropped due to $|r| = 0.91$ with `Return_10d`
  - **23 Predictors Retained:** Standardized via training set Z-score parameters.
- **Speaker Notes:**
  > "A critical contribution of this project is the strict elimination of lookahead bias. At market close of day t, our features capture indicators known up to day t, and we predict whether a breakout occurs on day t+1. Furthermore, our automated Pearson correlation filter dropped 3 severely collinear features exceeding 0.90 correlation, retaining 23 clean predictors."

---

### Slide 8: Chronological Splitting & Class Imbalance Strategy
- **Header:** Chronological Splitting & Class Imbalance Strategy
- **Subtitle:** Realistic out-of-time evaluation and rare-event calibration
- **3 Temporal Split Containers:**
  1. **Training Set (63.2%):** `76,900 rows` | 2016-11-21 to 2022-12-30 | 1,881 breakouts (2.45%) | In-sample model fitting & feature scaling parameters.
  2. **Validation Set (20.6%):** `25,100 rows` | 2023-01-03 to 2024-12-31 | 580 breakouts (2.31%) | Hyperparameter tuning & optimal F1 threshold calibration.
  3. **Test Set (16.2%):** `19,600 rows` | 2025-01-02 to 2026-07-28 | 422 breakouts (2.15%) | Untouched held-out benchmark evaluation (no snooping).
- **Bottom Left: Addressing Severe Class Imbalance (~2.2% Positives):**
  - *Square-Root Class Weighting (Tree & Linear Models):* Positive instances weighted $w_1 = \sqrt{N_0 / N_1} \approx 6.31$, penalizing false negatives without destabilizing gradient variance.
  - *Negative Downsampling (SVM, KNN, MLP):* Training majority class downsampled to 4:1 ratio; validation and test sets remain untouched at natural market prevalence.
- **Bottom Right: Decision Threshold Calibration ($\tau^*$):**
  - *Why Default $\tau = 0.50$ Fails:* Under extreme class imbalance, predicted probabilities cluster near zero. A fixed 0.50 threshold yields near-zero recall.
  - *Optimal F1 Threshold (Locked on Validation):* The threshold maximizing validation F1 score is computed and locked on validation data, then applied directly to the test set.
- **Speaker Notes:**
  > "To avoid time-series data snooping, we applied strict chronological splitting: 2016–2022 for training, 2023–2024 for validation and threshold calibration, and 2025–2026 as an untouched out-of-time test set. To overcome the 2.2% class imbalance, we applied square-root weighting (w1 ≈ 6.31) and calibrated decision thresholds on validation data rather than using the arbitrary 0.50 cutoff."

---

### Slide 9: Ten Supervised Machine Learning Algorithms
- **Header:** Ten Supervised Machine Learning Algorithms
- **Subtitle:** Broad algorithmic benchmark across six fundamental statistical paradigms
- **3 Category Pillars:**
  1. **Linear & Margin Classifiers:**
     - **Logistic Regression (`stats::glm`):** Weighted GLM modeling log-odds via logit link; fast parametric linear baseline.
     - **Linear Discriminant Analysis (`MASS::lda`):** Maximizes ratio of between-to-within class variance under pooled covariance.
     - **Support Vector Machine (`e1071::svm`):** Radial basis function (RBF) kernel margin maximization with Platt scaling.
  2. **Tree-Based Ensemble Models:**
     - **Decision Tree (`rpart::rpart`):** CART algorithm recursively splitting on Gini impurity with tree depth limits.
     - **Random Forest (`ranger::ranger`):** 300 de-correlated bagged trees with random subspace sampling (`mtry = 4`).
     - **Gradient Boosting (`gbm::gbm`):** Sequential stagewise boosting fitting negative gradients of Bernoulli loss.
     - **XGBoost (`xgboost::xgb.train`):** Second-order Taylor loss optimization with L1/L2 leaf penalties and shrinkage.
  3. **Distance, Probabilistic & Neural:**
     - **K-Nearest Neighbours (`class::knn`):** Instance-based Euclidean voting ($k = 81$) averaging local positive breakout density.
     - **Naive Bayes (`e1071::naiveBayes`):** Class posteriors via Bayes' rule under feature conditional independence.
     - **Neural Network / MLP (`nnet::nnet`):** Single-hidden-layer perceptron trained via BFGS with weight decay penalty ($\lambda = 0.10$).
- **Speaker Notes:**
  > "We implemented ten distinct supervised learning algorithms covering linear classifiers, tree ensembles, distance metrics, Bayesian probability, and artificial neural networks. All models were implemented natively in R using standard packages such as gbm, xgboost, ranger, and nnet."

---

### Slide 10: Model Benchmark Results (Test Set)
- **Header:** Model Benchmark Results (Held-Out Test Set)
- **Subtitle:** Performance comparison on 19,600 untouched records (2025–2026; 422 breakouts)
- **Benchmark Table:**

| Rank & Model Name | ROC-AUC | PR-AUC | Precision | Recall | F1-Score | Optimal Threshold |
|---|:---:|:---:|:---:|:---:|:---:|:---:|
| **1. Gradient Boosting (GBM)** | **0.8536** | **0.1721** | **20.15%** | **31.28%** | **0.2451** | **0.4717** |
| 2. Neural Network (MLP) | 0.8582 | 0.1645 | 16.64% | 42.65% | 0.2394 | 0.5345 |
| 3. XGBoost | 0.8573 | 0.1630 | 20.98% | 28.44% | 0.2414 | 0.4752 |
| 4. Linear Discriminant Analysis | 0.8523 | 0.1549 | 21.06% | 25.36% | 0.2301 | 0.1289 |
| 5. K-Nearest Neighbours ($k=81$) | 0.8460 | 0.1518 | 22.17% | 24.64% | 0.2334 | 0.5185 |
| 6. Random Forest | 0.8447 | 0.1490 | 21.11% | 21.56% | 0.2134 | 0.1529 |
| 7. Logistic Regression | 0.8554 | 0.1482 | 18.21% | 32.23% | 0.2327 | 0.4071 |
| 8. Naive Bayes | 0.8135 | 0.1409 | 20.73% | 22.99% | 0.2180 | 0.9747 |
| 9. Decision Tree (CART) | 0.8189 | 0.1374 | 19.25% | 29.38% | 0.2326 | 0.5128 |
| 10. SVM (Radial Kernel) | 0.8079 | 0.1329 | 19.41% | 26.54% | 0.2242 | 0.2659 |
| *Baseline (Random Guessing)* | *0.5000* | *0.0215* | *2.15%* | *100.0%* | *0.0421* | *N/A* |

- **Key Finding Callout:** *Gradient Boosting (GBM) achieved champion performance with a PR-AUC of 0.1721—delivering an 8.0x lift over the 0.0215 random guessing baseline. Neural Network achieved the highest overall Recall (42.65%), while KNN delivered top Precision (22.17%).*
- **Speaker Notes:**
  > "Table 1 shows the definitive out-of-sample benchmark on 19,600 held-out test rows. Because the dataset is heavily imbalanced, PR-AUC is our primary evaluation metric. Gradient Boosting is our champion model, achieving the highest PR-AUC of 0.1721 and the top F1-score of 0.2451. Neural Network achieved the highest recall at 42.65%."

---

### Slide 11: Model Diagnostics: PR & ROC Curves
- **Header:** Model Diagnostics: PR & ROC Curves
- **Subtitle:** Why Precision-Recall AUC is the decisive metric for rare financial events
- **Left Visual:** Precision-Recall Curves on Test Set ([`plots/ml/02_precision_recall_curves_test.png`](file:///home/saurabh/Stock_Project/plots/ml/02_precision_recall_curves_test.png))
- **Right Visual:** ROC Curves on Test Set ([`plots/ml/01_roc_curves_test.png`](file:///home/saurabh/Stock_Project/plots/ml/01_roc_curves_test.png))
- **Bottom Analytical Callout:**
  - **ROC Curves (Right):** All models exceed 0.80 ROC-AUC because the huge negative majority dilutes the false positive rate.
  - **PR Curves (Left):** PR-AUC clearly differentiates algorithm quality under class imbalance; GBM maintains superior precision across the practical 10%–40% recall band.
- **Speaker Notes:**
  > "Comparing ROC and PR curves demonstrates why standard accuracy and ROC-AUC can be deceptive in financial ML. In ROC space, all models look almost identical above 0.80 because true negatives dominate. In Precision-Recall space on the left, the difference is stark: GBM maintains an 8-fold precision lift across practical operating regions."

---

### Slide 12: Feature Importance: The 83.7% Drivers
- **Header:** Feature Importance: The 83.7% Drivers
- **Subtitle:** Tree ensemble feature importance rankings across GBM, Random Forest, and XGBoost
- **Left Visual:** Multi-panel feature importance bar plot ([`plots/ml/05_feature_importance.png`](file:///home/saurabh/Stock_Project/plots/ml/05_feature_importance.png))
- **Right Analytical Explanations:**
  1. **1. `Dist_High_20` (43.13% Importance):**
     - Measures price proximity to the prior 20-day high ceiling.
     - Breakouts occur when price compresses tightly against upper resistance.
  2. **2. `Log_Vol_Ratio` (40.57% Importance):**
     - Log-ratio of current volume to its 20-day average.
     - Unusual volume expansion confirms institutional accumulation absorbing supply.
  3. **Core Signal Takeaway (83.7% Total):**
     - Proximity to resistance + volume expansion jointly explain 83.7% of decision power in the winning Gradient Boosting model!
- **Speaker Notes:**
  > "Figure 4 reveals the economic drivers of the model. Across all three tree-based ensembles, two features dominate: Dist_High_20 at 43.1% and Log_Vol_Ratio at 40.6%. Together, these two variables account for 83.7% of predictive power, providing strong empirical validation of Nicolas Darvas and Stan Weinstein's classical technical theories."

---

### Slide 13: Champion Model: Confusion Matrix Analysis
- **Header:** Champion Model: Confusion Matrix Analysis
- **Subtitle:** Operational trade-offs and performance of Gradient Boosting at optimal threshold ($\tau^* = 0.4717$)
- **Left Visual:** Heatmap confusion matrix ([`plots/ml/06_confusion_matrix_best_model.png`](file:///home/saurabh/Stock_Project/plots/ml/06_confusion_matrix_best_model.png))
- **Right Card 1 (Matrix Breakdown · $N = 19,600$):**
  - **True Negatives (TN): 18,655 (97.27% Specificity):** Correctly filters out quiet non-breakout market sessions.
  - **True Positives (TP): 132 Breakouts Caught:** Successfully anticipates real breakouts 24 hours in advance.
  - **False Positives: 523 | False Negatives: 290**
- **Right Card 2 (Operational Utility for Quantitative Trading):**
  - **1 in 5 Alerts is a Verified Breakout (20.15% Precision):** Delivers a 9.4x signal lift over the 2.15% raw market base rate.
  - **Captures 31.28% of All Breakout Opportunities (Recall):** Allows systematic deployment of trading capital ahead of sharp multi-week equity advances.
- **Speaker Notes:**
  > "Figure 5 breaks down the actual confusion matrix on the held-out test set. At the optimal threshold of 0.4717, the model correctly identifies 18,655 non-breakout sessions with 97.3% specificity, while catching 132 explosive breakout moves. In practice, 1 out of every 5 alerts is a verified winner, which allows a systematic trading desk to operate with positive expectancy."

---

### Slide 14: Conclusion, Future Scope & Project Links
- **Header:** Conclusion, Future Scope & Project Links
- **Subtitle:** Summary of findings, limitations, and public reproduction resources
- **3 Summary Pillars:**
  1. **1. Key Accomplishments:**
     - Demonstrated that quantitative ML can reliably predict pre-breakout accumulation regimes ahead of price expansion.
     - GBM achieved top PR-AUC of 0.1721 (8.0x lift over random baseline) and F1 of 0.2451.
     - Proved that resistance proximity and volume expansion drive over 83.7% of predictive power.
     - Strict chronological splits and next-day lead targets eliminated lookahead leakage.
  2. **2. Limitations & Future Scope:**
     - Daily EOD Data: Misses intraday order book dynamics and execution slippage during fast market openings.
     - Survivorship Bias: The 50 stocks represent current 2026 constituents.
     - Future Work: Ingest news sentiment NLP and options volatility surfaces.
     - Future Work: Implement LSTM/Transformer models and realistic backtesting with transaction costs.
  3. **3. Open-Source Reproduction:**
     - Public GitHub Repository: [https://github.com/JonSnow42/Stock-Price-Breakout](https://github.com/JonSnow42/Stock-Price-Breakout)
     - Full Codebase in R: `00_setup.R`, `01_ml_models.R`, `02_tuning.R`, `03_visualization.R`
     - Reproducible Relational DB: SQLite `stocks.db` (63 MB)
     - Academic Reports: Complete 25-page report (DOCX & PDF) in `Final_Report/`
- **Speaker Notes:**
  > "To conclude, our research proves that machine learning can reliably identify momentum breakout setups 24 hours in advance with a 9.4x signal lift. The entire project—including R scripts, database, reports, and this presentation—is publicly available on GitHub. Thank you, and I now welcome your questions."

---

### Presentation Preparation & Defense Guide

#### Quick Facts for Defense & Viva Voce
- **Candidate:** Saurabh Madhesia (24BDS1082)
- **Institution:** Vellore Institute of Technology (VIT Chennai)
- **Development Toolchain:** Pure R (`stats`, `MASS`, `e1071`, `rpart`, `ranger`, `gbm`, `xgboost`, `nnet`, `RSQLite`, `ggplot2`), Node.js (`pptxgenjs`), LibreOffice CLI. **Zero Python used.**
- **Universe:** 50 Large-Cap S&P 500 Equities across 10 GICS sectors.
- **Sample Period:** 10 Years (2016-11-21 to 2026-07-28).
- **Total Records:** 125,650 raw rows; 121,600 model instances after warm-up drop.
- **Champion Model:** Gradient Boosting Machine (`gbm::gbm`) — PR-AUC: 0.1721 | F1-Score: 0.2451 | Precision: 20.15% | Recall: 31.28% | Decision Threshold: 0.4717.
- **Top 2 Features:** `Dist_High_20` (43.13%) and `Log_Vol_Ratio` (40.57%) account for 83.70% of feature attribution.
