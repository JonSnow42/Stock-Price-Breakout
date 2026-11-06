# 10-Minute Video Recording Presentation Script
## Project: Stock Market Trend Analysis and Momentum Breakout Prediction
**Presenter:** Saurabh Madhesia | **Reg. No.:** 24BDS1082  
**Faculty Guide:** Dr. Vijayalakshmi A | **Institution:** SCOPE, VIT Chennai  
**Target Video Duration:** Exactly 9:30 to 10:00 Minutes  
**Primary Focus:** Data Science concepts, Data Representation, Relational Storage (SQLite), Exploratory Data Analysis (EDA), Statistical Pruning, and Predictive Evaluation.

---

### 🎥 Pro Video Recording Checklist
1. **Camera Position:** Keep your camera at eye level. Look straight into the lens when introducing and concluding.
2. **Screen Sharing:** Ensure your slide presentation is in full-screen 16:9 mode.
3. **Pacing & Breathing:** Aim for 125–135 words per minute. Pause for 1–2 seconds at slide transitions so your cuts look seamless.
4. **Mindset:** You are presenting a **Data Science Capstone Project**. Frame the story around *data collection, database architecture, exploratory analysis, and statistical feature extraction*. Predictive modeling is the final chapter of that data pipeline, not the entire story.

---

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    10-MINUTE VIDEO RECORDING MAP                        │
├─────────┬───────────────────────────────────────────────────────────────┤
│ Timestamp│ Slide & Core Data Science Focus                              │
├─────────┼───────────────────────────────────────────────────────────────┤
│ 0:00    │ Slide 1: Welcome & Project Introduction                       │
│ 0:35    │ Slide 2: The Data Problem: Noisy Markets & Rare Outliers     │
│ 1:20    │ Slide 3: The End-to-End Data Science Pipeline                 │
│ 2:05    │ Slide 4: Data Engineering & Relational SQLite Architecture    │
│ 2:50    │ Slide 5: Exploratory Analysis: 10-Year Sector Dynamics        │
│ 3:35    │ Slide 6: Statistical Analysis: Sector Correlations & Clusters │
│ 4:25    │ Slide 7: Feature Engineering & Automated Statistical Pruning  │
│ 5:15    │ Slide 8: Chronological Data Partitioning & Rare-Event Calib.  │
│ 6:05    │ Slide 9: Predictive Modeling: 10 Statistical Paradigms        │
│ 6:50    │ Slide 10: Quantitative Benchmark on 19,600 Test Records       │
│ 7:45    │ Slide 11: Metric Diagnostics: Precision-Recall vs ROC Theory  │
│ 8:30    │ Slide 12: Analytical Inference: The 83.7% Signal Drivers      │
│ 9:15    │ Slide 13: Operational Data Validation: Confusion Matrix       │
│ 9:55    │ Slide 14: Project Summary, GitHub Repository & Wrap-Up        │
└─────────┴───────────────────────────────────────────────────────────────┘
```

---

### 🎬 Word-for-Word Spoken Video Script

---

#### **[0:00 - 0:35] Slide 1: Title Slide**
> *(Camera on you / screen sharing Slide 1. Speak warmly and with confidence.)*

"Hello everyone. Welcome to this presentation.

My name is Saurabh Madhesia, registration number 24BDS1082, from the School of Computer Science and Engineering at VIT Chennai. I am working under the guidance of Dr. Vijayalakshmi A ma'am.

Today, I am excited to walk you through my Data Science capstone project titled:  
**'Stock Market Trend Analysis and Momentum Breakout Prediction: A 10-Year Quantitative Study Across 50 S&P 500 Equities'**.

In this project, our primary focus was applying core data science principles—data representation, relational database modeling, exploratory data analysis, and statistical feature engineering—to extract meaningful patterns from over a decade of financial data. Let’s dive straight into the problem."

---

#### **[0:35 - 1:20] Slide 2: Background & Problem Overview**
> *[Screen: Slide 2]*

"Financial markets generate vast streams of daily numerical data. One of the most sought-after market phenomena is what traders call a **Momentum Breakout**.

In simple terms, imagine an equity price that has been stuck below an upper resistance ceiling for several weeks. A breakout occurs when the price forcefully closes above that multi-week ceiling on unusually heavy trading volume, signaling strong institutional buying.

However, from a data science perspective, analyzing this data presents four big hurdles:

1. **First, Unstructured Heuristics:** Traditional technical analysis relies on manual, subjective chart reading. Two different people can draw two completely different trendlines on the exact same price chart.
2. **Second, False Positive Noise:** Simple price screens often trigger fake breakouts—commonly called 'bull traps'—where the price briefly spikes and immediately collapses.
3. **Third, Severe Statistical Imbalance:** Real breakouts are extreme outliers. They occur on only about **2.2%** of trading sessions, making the data heavily skewed.
4. **And fourth, Lookahead Leakage:** Many academic analyses accidentally mix future intraday information into their predictors, creating invalid results that fail in the real world.

Our goal was to solve these four data challenges using a structured, automated data science framework."

---

#### **[1:20 - 2:05] Slide 3: Project Objectives & Pipeline Architecture**
> *[Screen: Slide 3]*

"Our primary objective was to engineer a 100% leak-free, reproducible quantitative pipeline in RStudio to identify tomorrow's breakout setups using only the data available at the close of today's market.

We structured the project around four comprehensive data science milestones:

- **1. Multi-Sector Data Collection:** Acquiring and cleaning 10 full years of historical daily data across 50 large-cap US equities.
- **2. Relational Database Design:** Structuring our raw and derived datasets into a dedicated SQLite database—`stocks.db`—for fast querying and reproducibility.
- **3. Feature Extraction & Multicollinearity Pruning:** Deriving 26 candidate technical and volume indicators, and using statistical correlation screening to drop redundant variables.
- **4. Predictive Evaluation & Benchmarking:** Testing 10 diverse algorithmic paradigms to validate our engineered features on an untouched out-of-time test set."

---

#### **[2:05 - 2:50] Slide 4: Data Engineering & Relational SQLite Architecture**
> *[Screen: Slide 4]*

"Now, let’s look at how our data is structured and represented.

We curated a universe of **50 large-cap equities from the S&P 500**, balanced across **10 GICS economic sectors**—including Technology, Financials, Healthcare, Industrials, and Energy—spanning from **2016 through mid-2026**.

- Our raw dataset contains **125,650 daily observations**.
- To calculate rolling indicators like our 50-day moving average, we set aside a 50-day warm-up window. After trimming this period, we obtained **121,600 fully validated, analysis-ready records**.
- All historical prices were audited to ensure complete adjustment for corporate stock splits and cash dividends.

Rather than relying on loose CSV files, we designed an SQLite relational database called `stocks.db`. It contains four structured tables:
`stock_data` for indexed price records, `model_features` for normalized predictive variables, and dedicated logging tables for our parameter tuning and experimental results."

---

#### **[2:50 - 3:35] Slide 5: Exploratory Data Analysis: Sector Price Trends**
> *[Screen: Slide 5 — Point out the trendlines]*

"The next phase of our project was Exploratory Data Analysis. We wanted to understand how different market sectors evolved over the 10-year horizon.

In this visualization, we normalized all 10 sector price indices to a base of 100 in 2016. The data reveals three distinct structural patterns:

- **First, Mega-Cap Technology Outperformance:** The Technology sector expanded from a base of 100 to over 750. This monumental growth was driven by the cloud software expansion and the 2023–2026 Generative AI boom in companies like Nvidia, Microsoft, and Apple.
- **Second, Defensive Stability:** Defensive sectors like Utilities, Real Estate, and Consumer Staples grew at a modest, steady pace, ending between 120 and 180.
- **Third, Volatility Heterogeneity:** High-beta sectors suffered massive cyclical drawdowns during the 2020 pandemic crash and the 2022 interest rate cycle.

This exploratory analysis proved that market volatility is fundamentally non-uniform across sectors."

---

#### **[3:35 - 4:25] Slide 6: Statistical Analysis: Sector Correlations & Clusters**
> *[Screen: Slide 6 — Point to the heatmap]*

"Next, we conducted a statistical correlation analysis on daily returns across all 10 sectors.

- Looking at our lower-triangular correlation heatmap, hierarchical clustering groups cyclical sectors—specifically Technology, Consumer Discretionary, Financials, and Industrials—into a tightly co-moving cluster with pairwise correlations between **0.65 and 0.82**.
- In contrast, **Energy and Utilities** exhibited low correlations to the broader market, ranging from 0.35 to 0.45, serving as natural market diversifiers.
- Furthermore, our empirical frequency analysis uncovered significant **Breakout Asymmetry**: breakouts occurred three times more frequently in high-beta sectors—reaching **3.4%** in Technology—compared to barely **1.1%** in Utilities.

This statistical finding guided our feature design, proving that sector one-hot encodings were necessary for any downstream modeling."

---

#### **[4:25 - 5:15] Slide 7: Feature Engineering & Automated Statistical Pruning**
> *[Screen: Slide 7]*

"Here is how we translated trading concepts into clean mathematical representations without data leakage.

First, we defined the same-day breakout event at Day $t$:  
The adjusted closing price must strictly exceed the prior 20-day high ceiling, AND the trading volume must be at least **1.5 times** its 20-day historical average.

Then, to prevent any lookahead bias, we established our target as the **one-day forward lead**:  
We ask: *'Given all data known up to 3:30 PM today (Day $t$), will tomorrow (Day $t+1$) experience a breakout?'*  
This gives market participants an entire evening to evaluate signals and position capital before the market opens.

Next, we performed statistical multicollinearity screening. Using automated Pearson correlation filtering, we dropped any variable with an absolute correlation exceeding **0.90**:
- `Price_vs_SMA50` was pruned due to a 0.93 correlation with `MACD_Pct`.
- `ATR_Pct` was pruned due to a 0.92 correlation with 20-day volatility.
- `Price_vs_SMA20` was pruned due to a 0.91 correlation with 10-day returns.

This reduced redundancy and left us with **23 standardized, non-collinear predictors**."

---

#### **[5:15 - 6:05] Slide 8: Chronological Partitioning & Rare-Event Calibration**
> *[Screen: Slide 8]*

"Now, how did we partition our time-series data?

In standard data science tasks, practitioners often use random k-fold shuffling. But in time-series and financial analysis, random shuffling is fatal because it leaks future market regimes into the past.

Instead, we enforced **strict chronological out-of-time partitioning**:
- **Training Set (63.2%):** 2016 through 2022 (76,900 rows) — used exclusively for computing normalization statistics and fitting models.
- **Validation Set (20.6%):** 2023 through 2024 (25,100 rows) — used for hyperparameter tuning and decision threshold calibration.
- **Test Set (16.2%):** 2025 through mid-2026 (19,600 rows) — completely untouched data for final out-of-sample evaluation.

To handle the severe class imbalance—where only **2.15% to 2.45%** of instances are positive—we implemented square-root class weighting ($w_1 \approx 6.31$), majority downsampling, and calibrated our decision threshold ($\tau^*$) on validation data to maximize the F1-score rather than using the arbitrary 0.50 default."

---

#### **[6:05 - 6:50] Slide 9: Predictive Modeling: 10 Statistical Paradigms**
> *[Screen: Slide 9]*

"To evaluate the predictive power of our engineered features, we benchmarked **ten diverse mathematical and statistical modeling paradigms**:

1. **Linear and Margin Methods:** Weighted Logistic Regression for parametric log-odds estimation, Linear Discriminant Analysis for maximizing between-class variance, and Support Vector Machines with an RBF kernel for non-linear margin separation.
2. **Tree-Based Ensembles:** Single Decision Trees (CART), Random Forest with 300 de-correlated bagged trees, Gradient Boosting (GBM), and XGBoost for second-order loss optimization.
3. **Distance, Probabilistic, and Neural Approaches:** K-Nearest Neighbours ($k=81$) based on Euclidean proximity, Naive Bayes using conditional class posteriors, and a Single-Hidden-Layer Multi-Layer Perceptron Neural Network.

All ten models were implemented natively in R using established packages like `gbm`, `xgboost`, `ranger`, and `nnet`."

---

#### **[6:50 - 7:45] Slide 10: Quantitative Benchmark on 19,600 Test Records**
> *[Screen: Slide 10 — Direct attention to the highlighted row]*

"This table presents the definitive evaluation across **19,600 untouched records** from our 2025–2026 test period.

Because our target is rare, our primary evaluation benchmark is **Precision-Recall AUC (PR-AUC)** rather than raw accuracy.

- A baseline random guesser achieves a PR-AUC equal to the positive class prevalence: only **0.0215**.
- **Gradient Boosting (GBM) emerged as our top-performing model**, achieving a **PR-AUC of 0.1721**—delivering an **8.0x performance lift** over random guessing! At an optimal decision threshold of 0.4717, it achieved a balanced F1-score of **0.2451**, with **20.15% Precision** and **31.28% Recall**.
- **Neural Network (MLP)** ranked second with a PR-AUC of 0.1645, and it captured the highest overall sensitivity, detecting **42.65%** of all true breakouts.
- **XGBoost** ranked third at 0.1630.
- Even traditional linear discriminant analysis and nearest neighbors delivered over a 7x lift, demonstrating that our engineered features hold strong predictive signal regardless of the underlying algorithm."

---

#### **[7:45 - 8:30] Slide 11: Metric Diagnostics: Precision-Recall vs ROC Theory**
> *[Screen: Slide 11 — Point between the two plots]*

"This slide illustrates an important lesson in Data Science evaluation metrics.

- On the right, notice the **ROC Curves**. Every single algorithm exceeds an ROC-AUC of 0.80 and the curves cluster tightly together. Why? Because the massive 98% negative majority dilutes the false positive rate, making ROC-AUC overly optimistic and uninformative.
- On the left, look at the **Precision-Recall Curves**. Here, the true differences between algorithms become immediately apparent. Gradient Boosting consistently maintains the highest precision across the realistic recall range of 10% to 40%, confirming why PR-AUC is the gold standard for rare-event analysis."

---

#### **[8:30 - 9:15] Slide 12: Analytical Inference: The 83.7% Signal Drivers**
> *[Screen: Slide 12]*

"Beyond prediction, a core goal of data science is interpretability: **what is the data actually telling us?**

We extracted feature importance rankings across all tree-based ensemble models. Across GBM, Random Forest, and XGBoost, the same two features overwhelmingly dominated:

1. **`Dist_High_20` (43.13% importance):** Measures price proximity to the previous 20-day high ceiling. Breakouts rarely emerge from deep drawdowns; they occur when prices coil tightly against upper resistance.
2. **`Log_Vol_Ratio` (40.57% importance):** Measures logarithmic volume expansion against the 20-day baseline, indicating institutional capital accumulating shares.

Together, **these two features account for 83.7% of total decision power in Gradient Boosting!**  
This provides strong empirical, data-driven validation for classical market theories originally proposed by Nicolas Darvas and Stan Weinstein."

---

#### **[9:15 - 9:55] Slide 13: Operational Data Validation: Confusion Matrix**
> *[Screen: Slide 13]*

"Finally, let’s translate these numbers into operational reality on our 19,600 test sessions:

- The model successfully filtered out **18,655 non-breakout market days**, achieving a **97.3% Specificity**.
- It correctly anticipated **132 real, explosive breakouts 24 hours in advance**.
- While there are 523 false positives, here is what that means in practice:
  **1 out of every 5 generated alerts is a confirmed winning breakout!**

In a market where the baseline occurrence is only 2%, delivering a **9.4x signal lift** transforms a noisy random guessing environment into a systematic, positive-expectancy quantitative framework."

---

#### **[9:55 - 10:30] Slide 14: Project Summary, GitHub Repository & Wrap-Up**
> *[Screen: Slide 14 — Bring camera back to you for the final sentence]*

"To summarize our project:
- We successfully built an end-to-end Data Science workflow: from ingesting 125,000 raw market records into a relational SQLite architecture, to exploratory sector analysis, correlation pruning, and predictive evaluation.
- We confirmed that resistance proximity and volume expansion drive over 83% of breakout predictability.
- As next steps, this pipeline can be extended to incorporate natural language sentiment analysis from financial news feeds and high-frequency intraday order book data.
- The complete codebase—including our R scripts, SQLite database, 25-page academic report, and presentation slides—is open-source and available on GitHub at `JonSnow42/Stock-Price-Breakout`.

Thank you so much for watching, and I hope this provided a clear overview of our data science work!"

---

### 💡 Quick Tips for a Polished Video Recording
1. **Introduction:** Smile and speak clearly. The first 30 seconds set the impression for the entire video.
2. **Transitions:** When changing slides, say a short transition phrase like: *"Now, moving to data representation..."* or *"Next, let's examine our exploratory findings..."*
3. **Pacing:** Don't rush when reading tables or figures. Give the viewer 2–3 seconds to absorb the visual before diving into the explanation.
4. **Volume & Clarity:** Use an external microphone or headset if possible, and keep background noise minimal.
