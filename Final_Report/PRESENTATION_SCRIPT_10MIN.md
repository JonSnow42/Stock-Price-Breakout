# 10-Minute Presentation Script & Viva Voce Guide
## Project: Stock Market Trend Analysis and Momentum Breakout Prediction
**Presenter:** Saurabh Madhesia | **Reg. No.:** 24BDS1082  
**Guide:** Dr. Vijayalakshmi A | **Institution:** SCOPE, VIT Chennai  
**Total Target Duration:** 9 to 10 Minutes (Leaves 2–3 minutes for Q&A in a typical 12-minute slot)  
**Spoken Style:** Clear, natural, confident English suitable for an Indian B.Tech 3rd-year engineering student.

---

### Quick Presenter Checklist Before You Start
- **Pacing:** Speak at a calm, conversational speed (~125–135 words per minute). Don't rush through the numbers.
- **Tone:** Confident and practical. Focus on *why* you made engineering decisions (e.g., why accuracy fails, why chronological split was required).
- **Physical cues:** Look up at the panel members; use your laser pointer or hand to point at the key tables and highlighted charts on the screen.

---

```
┌────────────────────────────────────────────────────────────────────────┐
│                        10-MINUTE TIMELINE MAP                          │
├─────────┬──────────────────────────────────────────────────────────────┤
│ Time    │ Slide & Section                                              │
├─────────┼──────────────────────────────────────────────────────────────┤
│ 0:00    │ Slide 1: Welcome & Title Introduction                        │
│ 0:35    │ Slide 2: The Practical Problem & Why Breakouts Matter        │
│ 1:20    │ Slide 3: Project Goals & Core Milestones                     │
│ 2:05    │ Slide 4: Dataset, 10 Sectors & SQLite Storage                │
│ 2:50    │ Slide 5: EDA 1 - Sector Divergence & 10-Year Trends          │
│ 3:35    │ Slide 6: EDA 2 - Sector Heatmap & Breakout Asymmetry         │
│ 4:20    │ Slide 7: Zero-Leakage Target Formula & Feature Pruning       │
│ 5:10    │ Slide 8: Chronological Splitting & Beating 2% Imbalance      │
│ 6:00    │ Slide 9: 10 Supervised Machine Learning Models               │
│ 6:45    │ Slide 10: Final Test Benchmark Results (GBM #1)              │
│ 7:45    │ Slide 11: Diagnostics - Why PR-AUC Matters More Than ROC     │
│ 8:30    │ Slide 12: Feature Importance - The 83.7% Real Drivers        │
│ 9:15    │ Slide 13: Champion Confusion Matrix & Trading Edge           │
│ 9:55    │ Slide 14: Conclusion, Limitations & Project Links            │
│ 10:30   │ Handover to Panel for Questions & Answers (Viva)             │
└─────────┴──────────────────────────────────────────────────────────────┘
```

---

### Full Spoken Script (Word-for-Word)

---

#### [0:00 - 0:35] Slide 1: Title Slide
> *(Take a deep breath, smile, make eye contact with the evaluation panel)*

"Good morning, respected guide Dr. Vijayalakshmi ma'am, and respected panel members.

My name is Saurabh Madhesia, registration number 24BDS1082, from the School of Computer Science and Engineering, VIT Chennai.

Today, I am presenting our capstone project: **'Stock Market Trend Analysis and Momentum Breakout Prediction: A 10-Year Quantitative Machine Learning Study Across 50 S&P 500 Equities'**.

In this project, we built a 100% leak-free, reproducible machine learning pipeline in R to predict explosive next-day stock price breakouts. Let me quickly take you through the motivation and our findings."

---

#### [0:35 - 1:20] Slide 2: Background & Problem Overview
> *[Switch to Slide 2]*

"To start with, what actually is a **Momentum Breakout**?

In simple terms, imagine a stock price has been trapped under a ceiling—say, 100 rupees or 100 dollars—for several weeks. A breakout happens when big institutions step in, volume surges, and the price forcefully punches above that ceiling. When this happens, the stock often goes on a powerful multi-week upward run.

Traders love breakouts, but in real life, manual trading has four major problems:

1. **First, It's purely subjective:** Two technical analysts looking at the exact same chart will draw two completely different trendlines.
2. **Second, Bull traps:** Most simple screeners trigger false breakouts where the stock spikes in the morning and dumps by the afternoon.
3. **Third, Severe class imbalance:** Real breakouts are rare—they happen on only **2.2%** of trading days.
4. **And fourth, Lookahead leakage:** Many academic papers accidentally use today's closing price or volume to predict today's price, which is basically cheating and completely fails in live trading.

Our goal was to eliminate all human guesswork and solve these challenges using data science."

---

#### [1:20 - 2:05] Slide 3: Project Objectives
> *[Switch to Slide 3]*

"Our primary objective was to build and benchmark a strictly leak-free machine learning system in RStudio that can look at the market at 3:30 PM today, and tell us whether a stock will break out tomorrow.

To achieve this, we set four clear technical milestones:

- **1. Multi-Sector Historical Data:** Collect 10 full years of clean daily data across 50 large-cap US stocks.
- **2. Relational Database:** Store and index everything inside a relational SQLite database—`stocks.db`—for clean auditing and fast SQL queries.
- **3. Feature Engineering & Automated Pruning:** Engineer 26 candidate technical and volume indicators, and prune out heavily correlated variables.
- **4. Comprehensive ML Benchmarking:** Implement and compare 10 different supervised learning algorithms across multiple machine learning paradigms."

---

#### [2:05 - 2:50] Slide 4: Dataset & Database Architecture
> *[Switch to Slide 4]*

"Let's look at the dataset.

We selected **50 top equities from the S&P 500**, covering **10 major sectors**—including Technology, Financials, Healthcare, Energy, and Consumer goods—spanning from **2016 all the way to 2026**.

- The raw dataset contains **125,650 daily observations**.
- We calculated our rolling moving averages using a 50-day warm-up window. After cleanly dropping that warm-up period, we had **121,600 fully processed, model-ready records**.
- Every single corporate action—such as stock splits and dividends—was properly adjusted in the historical prices.

We designed an SQLite database called `stocks.db` with 4 tables: `stock_data` for the prices, `model_features` for the standardized predictors, and dedicated logging tables for our hyperparameter tuning and model results."

---

#### [2:50 - 3:35] Slide 5: Exploratory Data Analysis: Sector Price Trends
> *[Switch to Slide 5 — Point toward the chart]*

"During our Exploratory Data Analysis, the first major thing we noticed was extreme sector divergence over these 10 years.

As you can see in this chart:
- **Technology** completely outperformed the rest of the market, growing from a base of 100 to over 750. This was driven by the cloud boom and the recent Generative AI semiconductor rally in stocks like Nvidia, Microsoft, and Apple.
- On the other hand, defensive sectors like **Utilities and Real Estate** moved very slowly and steadily, staying between 120 and 180.
- Cyclical stocks suffered massive drawdowns during the 2020 COVID crash and the 2022 interest rate hikes.

This proved an important point: **one size does not fit all**. Baseline volatility depends heavily on the industry sector."

---

#### [3:35 - 4:20] Slide 6: Sector Correlations & Breakout Asymmetry
> *[Switch to Slide 6 — Point to the correlation heatmap]*

"Next, we analyzed cross-sector correlations and breakout frequencies.

- In the correlation heatmap on the left, we can see strong co-movement among cyclical sectors like Tech, Financials, and Industrials, with correlations between 0.65 and 0.82.
- Meanwhile, **Energy and Utilities** acted as independent hedges with much lower market correlations.
- Most importantly, we discovered **Breakout Asymmetry**: breakouts happen much more frequently in high-beta sectors—over **3.4%** of the time in Technology—compared to barely **1.1%** in Utilities.

This confirmed that we had to include one-hot encoded sector features so our models could learn sector-specific behavior."

---

#### [4:20 - 5:10] Slide 7: Feature Engineering & Zero-Leakage Target
> *[Switch to Slide 7]*

"Now, coming to the core technical formulation of our project: **how did we define a breakout without leaking future data?**

First, we defined a same-day breakout event at Day $t$:
The stock's closing price must be strictly higher than its previous 20-day high, AND its trading volume must be at least **1.5 times** its 20-day average volume.

Then, for our supervised learning target, we took the **lead of this event by 1 day**:
Our target variable is: *'Will tomorrow, Day $t+1$, be a breakout day?'*

This guarantees **zero lookahead bias**:
At market close today, our models only use prices and volumes up to today. We make the prediction in the evening, giving a quantitative trader the entire night to queue orders before tomorrow's market opens.

We also ran an automated Pearson correlation check. Any two features with a correlation higher than 0.90 were pruned. We dropped 3 collinear variables and retained **23 clean, standardized predictors**."

---

#### [5:10 - 6:00] Slide 8: Chronological Splitting & Class Imbalance Strategy
> *[Switch to Slide 8]*

"A common mistake in beginner stock market projects is using random `train_test_split()`. That is fatal in finance because you end up using future data to predict the past!

Instead, we used **strict chronological out-of-time splitting**:
- **Training Set (63.2%):** 2016 to 2022 (76,900 rows) — used only for fitting models.
- **Validation Set (20.6%):** 2023 to 2024 (25,100 rows) — used for hyperparameter tuning and finding the best decision threshold.
- **Test Set (16.2%):** 2025 to mid-2026 (19,600 rows) — completely untouched out-of-sample data.

Now, remember: only **2.15% to 2.45%** of records are breakouts.
If a dummy model simply guesses 'No Breakout' every day, it gets **97.8% accuracy**, but it is 100% useless!

To solve this severe imbalance:
1. We applied **square-root class weighting** ($w_1 \approx 6.31$) to tree models.
2. We used **negative downsampling** for distance and neural models.
3. And we tuned the **optimal F1 decision threshold ($\tau^*$)** on validation data instead of blindly using the default 0.50 cutoff."

---

#### [6:00 - 6:45] Slide 9: Ten Supervised Machine Learning Algorithms
> *[Switch to Slide 9]*

"To make this study truly rigorous, we did not test just one or two models. We implemented **ten distinct supervised learning algorithms** covering all major machine learning paradigms:

1. **Linear and Margin models:** Weighted Logistic Regression, Linear Discriminant Analysis (LDA), and Support Vector Machines with an RBF kernel.
2. **Tree-Based Ensembles:** Decision Trees (CART), Random Forest with 300 de-correlated trees, Gradient Boosting (GBM), and XGBoost.
3. **Distance, Probabilistic, and Neural models:** K-Nearest Neighbours ($k=81$), Naive Bayes, and a Single-Hidden-Layer Multi-Layer Perceptron Neural Network.

All ten models were implemented natively in R using standard libraries like `gbm`, `xgboost`, `ranger`, and `nnet`."

---

#### [6:45 - 7:45] Slide 10: Model Benchmark Results (Held-Out Test Set)
> *[Switch to Slide 10 — Direct attention to the table]*

"Here are the final benchmark results on the **19,600 untouched records of our test set**.

Because of the severe class imbalance, our primary evaluation metric is **Precision-Recall AUC (PR-AUC)**, not standard accuracy.

- An uninformed random guesser achieves a PR-AUC of only **0.0215**.
- Look at row 1: **Gradient Boosting (GBM) emerged as the Champion Model!**
  It achieved a **PR-AUC of 0.1721**—which is an **8.0x improvement** over random guessing! It also scored the highest F1-score of **0.2451**, with **20.15% Precision** and **31.28% Recall** at a threshold of 0.4717.
- **Neural Network (MLP)** came in second with a PR-AUC of 0.1645, and it actually captured the highest recall at **42.65%**.
- **XGBoost** ranked third with 0.1630.
- Even traditional LDA and KNN performed solidly, beating random guessing by over 7 times."

---

#### [7:45 - 8:30] Slide 11: Model Diagnostics: PR & ROC Curves
> *[Switch to Slide 11 — Point between the two charts]*

"This slide shows why our evaluation methodology was critical.

- If you look at the **ROC Curves on the right**, all models look almost identical and score above 0.80. That is because the huge 98% majority of non-breakouts artificially shrinks the false positive rate. ROC gives an overly optimistic illusion of success.
- But if you look at the **Precision-Recall Curves on the left**, the truth becomes clear. The curves clearly separate the models. Gradient Boosting stays well above all other curves across the practical recall range of 10% to 40%."

---

#### [8:30 - 9:15] Slide 12: Feature Importance: The 83.7% Drivers
> *[Switch to Slide 12]*

"We then asked: **Why does the model work? What is it actually seeing?**

We extracted feature importance across all tree ensemble models. Across GBM, Random Forest, and XGBoost, two features completely dominated:

1. **`Dist_High_20` (43.1% importance):** How close the current price is to its 20-day high. Breakouts don't happen out of thin air; price first coils up right beneath resistance.
2. **`Log_Vol_Ratio` (40.6% importance):** How much volume has expanded compared to its 20-day average. Unusual volume signals that large institutional buyers are absorbing supply.

Together, **these two features explain 83.7% of the model's decision!**
This is a huge finding because it empirically confirms classical quantitative trading theories from Nicolas Darvas and Stan Weinstein using modern machine learning."

---

#### [9:15 - 9:55] Slide 13: Champion Confusion Matrix & Trading Edge
> *[Switch to Slide 13]*

"Now let's translate these numbers into practical trading reality.

On our 19,600 test sessions:
- The model correctly filtered out **18,655 quiet days**—giving a **97.3% Specificity**.
- It successfully caught **132 real, explosive breakouts 24 hours in advance**.
- Yes, there are 523 false positives, but here is what that means in practice:
  **1 out of every 5 alerts triggered by the model is a genuine winning breakout!**

Remember, in the raw market, the base rate is only 2%. Our model delivers a **9.4x signal lift**. In quantitative trading, catching 1 in 5 trades with multi-week momentum gains provides a clear statistical edge with positive expectancy."

---

#### [9:55 - 10:30] Slide 14: Conclusion, Limitations & Project Links
> *[Switch to Slide 14]*

"To conclude our presentation:
1. **Accomplishments:** We demonstrated that machine learning can reliably forecast pre-breakout accumulation regimes without lookahead leakage. Gradient Boosting delivered an 8x lift over baseline.
2. **Limitations:** We used daily end-of-day data, so we don't capture intraday 1-minute order book slippage. Also, the 50 stocks represent current large caps.
3. **Future Work:** We plan to integrate news sentiment NLP and test deep learning Transformer architectures with transaction costs.
4. **Open-Source Reproducibility:** Our entire project—including R scripts, database, 25-page report, and this presentation—is publicly available on our GitHub repository at `JonSnow42/Stock-Price-Breakout`.

Thank you very much for your time and attention. I am now open to any questions from the panel."

---

### 🎓 Top 5 Likely Viva Questions & Quick-Fire Answers

Be ready for these common questions during your viva:

#### Q1: "Why did you choose PR-AUC over ROC-AUC or plain Accuracy?"
> **Answer:**  
> "Sir/Ma'am, in our dataset, breakouts happen on only 2.2% of trading days. If a dummy model predicts 'No Breakout' 100% of the time, it gets 97.8% accuracy but catches 0 breakouts. ROC-AUC is also misleading because the 98% true negatives make the False Positive Rate look artificially tiny. PR-AUC focuses exclusively on the minority positive class and measures true precision versus recall, making it the industry standard for rare financial events."

#### Q2: "How did you ensure there is NO lookahead bias in your features?"
> **Answer:**  
> "We enforced a strict mathematical cutoff: at 3:30 PM on Day $t$, all 23 features use closing prices, moving averages, and volumes strictly up to Day $t$. Our target is `lead(Breakout_Today, 1)`, which evaluates conditions on Day $t+1$. So tomorrow's price is never present in today's feature row."

#### Q3: "Why did you split chronologically instead of using k-fold cross-validation or random split?"
> **Answer:**  
> "Stock market data has strong temporal autocorrelation and regime shifts. If we randomly shuffle data, the training set will contain data from 2024 to predict 2021, which leaks future market sentiment into the past. Chronological splitting (2016–2022 train, 2023–2024 validation, 2025–2026 test) mimics real-world forward testing."

#### Q4: "Why did Gradient Boosting (GBM) beat Neural Networks and Random Forest?"
> **Answer:**  
> "Tabular financial features typically have non-linear decision boundaries and varying scales. Gradient Boosting sequentially corrects the residuals of previous trees on Bernoulli log-loss, allowing it to carve precise rectangular regions in feature space. While MLP had higher recall, GBM achieved a much cleaner balance between precision (20.15%) and recall (31.28%), giving it the top PR-AUC of 0.1721."

#### Q5: "What are the two most important features, and what is the financial intuition behind them?"
> **Answer:**  
> "The two features are `Dist_High_20` (43.1% importance) and `Log_Vol_Ratio` (40.6% importance), totaling 83.7%. The intuition is that before a stock breaks out, its price tightly compresses right below its 20-day resistance line, and institutional accumulation causes trading volume to swell. Together, price tightness plus volume expansion signal an imminent explosion."
