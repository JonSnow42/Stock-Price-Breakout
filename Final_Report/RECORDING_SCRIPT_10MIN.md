# 10-Minute Simple Video Recording Script
## Project: Stock Market Trend Analysis and Momentum Breakout Prediction
**Presenter:** Saurabh Madhesia | **Reg. No.:** 24BDS1082  
**Faculty Guide:** Dr. Vijayalakshmi A | **Institution:** SCOPE, VIT Chennai  
**Target Video Duration:** 9 to 10 Minutes  
**Language Style:** Simple, clear, everyday English that anyone can follow without getting lost in technical jargon.

---

### 🎥 Quick Recording Tips
- **Speak naturally:** Talk as if you are explaining your project to a batchmate or a curious friend.
- **Pacing:** Speak at a steady pace. Don't rush through the numbers.
- **Slide transitions:** When changing slides, pause for a second before starting the next point.

---

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    10-MINUTE VIDEO RECORDING MAP                        │
├──────────┬──────────────────────────────────────────────────────────────┤
│ Time     │ Slide & Simple Topic                                         │
├──────────┼──────────────────────────────────────────────────────────────┤
│ 0:00     │ Slide 1: Welcome & Project Title                             │
│ 0:35     │ Slide 2: What is a Breakout & Why Manual Trading Fails       │
│ 1:20     │ Slide 3: What We Set Out to Build (4 Steps)                  │
│ 2:05     │ Slide 4: Our Data & Why We Used SQLite                       │
│ 2:50     │ Slide 5: Graph 1 - How Different Sectors Performed (10 Years)│
│ 3:35     │ Slide 6: Graph 2 - Which Sectors Move Together               │
│ 4:25     │ Slide 7: Our Golden Rule: No Cheating (Predicting Tomorrow)  │
│ 5:15     │ Slide 8: Splitting by Time & The 98% Accuracy Trap           │
│ 6:05     │ Slide 9: The 10 Models We Tested                             │
│ 6:50     │ Slide 10: The Big Results Table & Who Won                    │
│ 7:45     │ Slide 11: Why PR Curves Show the Real Truth                  │
│ 8:30     │ Slide 12: What Did the Data Actually Learn? (84% Drivers)    │
│ 9:15     │ Slide 13: What This Means in Real Life (1 in 5 Win Rate)     │
│ 9:55     │ Slide 14: Conclusion & GitHub Repository                     │
└──────────┴──────────────────────────────────────────────────────────────┘
```

---

### 🎬 Complete Spoken Script (Word-for-Word)

---

#### **[0:00 - 0:35] Slide 1: Welcome & Title**
> *(Look at the camera with a smile. Speak clearly and calmly.)*

"Hello everyone. Welcome to my capstone presentation.

My name is Saurabh Madhesia, registration number 24BDS1082, from the School of Computer Science and Engineering at VIT Chennai. I completed this work under the guidance of Dr. Vijayalakshmi A ma'am.

Today, I am presenting our Data Science project titled:  
**'Stock Market Trend Analysis and Momentum Breakout Prediction'**.

In this project, we took 10 full years of stock market data and used data science techniques—like database design, exploratory data analysis, and predictive modeling—to see if we can spot big stock moves before they happen. Let me explain the core problem we wanted to solve."

---

#### **[0:35 - 1:20] Slide 2: What is a Breakout & The Problem**
> *[Show Slide 2 on screen]*

"First, what is a **Momentum Breakout**?

Think of a stock whose price has been stuck under a ceiling—say, 100 dollars—for several weeks. It hits 100, drops, hits 100 again, and drops. A breakout happens when buyers suddenly rush in, trading volume explodes, and the price forcefully punches right through that ceiling. When this happens, the stock usually goes on a big multi-week rally.

Traders love catching these moves early. But doing it manually has four major problems:

1. **First, it's pure guesswork:** Two different people looking at the exact same chart will draw two completely different lines.
2. **Second, lots of fake alarms:** A stock might jump in the morning, trap buyers, and crash by the afternoon. Traders call this a 'bull trap'.
3. **Third, real breakouts are very rare:** Out of 100 trading days, a real breakout happens on only **2 days**.
4. **And fourth, cheating in code:** Many student projects accidentally use today's closing price to predict today's price. That is cheating, and it completely fails in real life.

We wanted to fix these problems using proper data science."

---

#### **[1:20 - 2:05] Slide 3: What We Set Out to Build**
> *[Show Slide 3 on screen]*

"Our main goal was simple:  
When the stock market closes at 3:30 PM today, can our system look at the data and tell us: **'Hey, this stock has a high chance of breaking out tomorrow'**?

To do this, we followed four clear steps:

- **1. Collect 10 years of clean data:** 50 major US stocks from 2016 all the way to 2026.
- **2. Store it properly in an SQLite database:** We built a database called `stocks.db` so our data is organized, fast to search, and never messy.
- **3. Create smart indicators and clean them:** We calculated 26 financial features like moving averages and volume ratios, and removed redundant features.
- **4. Test 10 different models:** We compared 10 different algorithms to find out which one predicts breakouts best."

---

#### **[2:05 - 2:50] Slide 4: Our Data & Relational Storage**
> *[Show Slide 4 on screen]*

"Let's look at the data.

We selected **50 top companies from the US S&P 500**, covering **10 different sectors**—like Technology, Banking, Healthcare, Energy, and Consumer products.

- The raw data has **125,650 daily rows**.
- We needed 50 days of past data to calculate our 50-day moving averages. After dropping that warm-up window, we had **121,600 clean, ready-to-use records**.
- We verified every record for stock splits and dividend adjustments.

Instead of keeping giant, messy Excel or CSV files, we put everything into an SQLite database called `stocks.db`. It has 4 clean tables: one for raw prices, one for normalized features, and two tables to log all our experimental results. This made our entire project clean and 100% reproducible."

---

#### **[2:50 - 3:35] Slide 5: How Sectors Performed Over 10 Years**
> *[Show Slide 5 on screen — Point to the graph]*

"Next, we did Exploratory Data Analysis to see how different sectors behaved over the decade.

In this chart, we set every sector's starting value to 100 in 2016. Look at the massive difference:

- **Technology** completely crushed the rest of the market. An investment of 100 grew to over **750**, driven by the cloud boom and the recent AI surge in companies like Nvidia, Microsoft, and Apple.
- On the other hand, defensive sectors like **Utilities and Real Estate** moved very slowly and steadily, ending around **150**.
- Cyclical stocks also had huge crashes during the 2020 COVID panic and the 2022 inflation cycle.

The big takeaway from this data is: **different sectors have completely different risk and volatility**. You cannot treat a tech stock the same way as a power company."

---

#### **[3:35 - 4:25] Slide 6: Which Sectors Move Together**
> *[Show Slide 6 on screen — Point to the heatmap]*

"Next, we looked at how sectors move together and how often breakouts happen in each sector.

- In the correlation heatmap on the left, sectors like Technology, Financials, and Industrials move together very closely, with correlations between 0.65 and 0.82.
- But **Energy and Utilities** dance to their own tune. They have low correlation with the rest of the market.
- Even more interesting is the breakout frequency: breakouts happen **3 times more often in Technology (around 3.4%)** than in Utilities (only 1.1%).

This told us something crucial: our system must know which sector a stock belongs to, because tech stocks break out much more often than defensive stocks."

---

#### **[4:25 - 5:15] Slide 7: Our Golden Rule: No Cheating**
> *[Show Slide 7 on screen]*

"Now, coming to the most important rule of our project: **Zero Cheating**.

First, what is our mathematical rule for a breakout today?
A breakout happens today if:  
1. Today's closing price is higher than the highest price of the past 20 days, **AND**  
2. Today's trading volume is at least **1.5 times** the 20-day average volume.

Now, here is the key: **we don't predict today. We predict tomorrow.**  
Our target is: *'Given everything that happened up to today's market close, will tomorrow be a breakout day?'*  
Because we predict tomorrow, you have all night to look at the signal and place orders before the next morning.

We also checked feature correlation. If two features told the exact same story—like two different moving averages with a 90% correlation—we dropped one. That gave us **23 clean, independent features**."

---

#### **[5:15 - 6:05] Slide 8: Splitting by Time & The 98% Accuracy Trap**
> *[Show Slide 8 on screen]*

"How did we split our data?

In normal projects, people randomly shuffle rows. But in the stock market, random shuffling is completely wrong. You cannot use data from 2024 to predict 2020! That's like reading the exam answers beforehand.

So we strictly split by time:
- **Training Set (63%):** 2016 to 2022 — used only to train models.
- **Validation Set (21%):** 2023 to 2024 — used to tune settings and find the best cutoff.
- **Test Set (16%):** 2025 to 2026 — completely untouched data (19,600 rows).

Now, here is a big trap: **Accuracy**.  
Because only 2 out of 100 days are breakouts, if a lazy model simply guesses 'No Breakout' every single day, it gets **98% accuracy**! But it caught zero breakouts, so it's completely useless.

That is why we ignore raw accuracy and focus on **Precision and Recall**."

---

#### **[6:05 - 6:50] Slide 9: The 10 Models We Tested**
> *[Show Slide 9 on screen]*

"To make sure our results were rock solid, we tested **10 different algorithms** from different families:

- **Linear models:** Logistic Regression and Linear Discriminant Analysis.
- **Margin models:** Support Vector Machines (SVM).
- **Tree-based models:** Decision Trees, Random Forest, Gradient Boosting, and XGBoost.
- **Distance & Probability models:** K-Nearest Neighbours and Naive Bayes.
- **And a Neural Network:** Multi-Layer Perceptron.

All 10 models were built and tested directly in R."

---

#### **[6:50 - 7:45] Slide 10: The Results: Who Won?**
> *[Show Slide 10 on screen — Point to the green row]*

"Here are the final benchmark results on our **19,600 untouched test days**.

Because of the rare-event data, our main score is **PR-AUC**—which measures Precision and Recall together.

- If you just guess randomly, your score is only **0.02**.
- Look at row number 1: **Gradient Boosting (GBM) is our overall champion!**  
  It scored a PR-AUC of **0.1721**. That is an **8 times improvement** over random guessing! It achieved **20% Precision** and **31% Recall** with the highest overall F1-score of **0.2451**.
- **Neural Network** came in second with 0.1645, and it caught the highest percentage of breakouts at **42%**.
- **XGBoost** came third at 0.1630.
- Every single model beat the random baseline by at least 6 to 8 times."

---

#### **[7:45 - 8:30] Slide 11: Why PR Curves Show the Truth**
> *[Show Slide 11 on screen — Point to the left and right plots]*

"This slide shows why choosing the right metric matters so much in data science.

- Look at the **ROC Curves on the right**. Every single model scores above 80% and the lines look almost identical. Why? Because the 98% non-breakout days hide all the mistakes. ROC makes everything look deceptively easy.
- But look at the **Precision-Recall Curves on the left**. Here, the noise is stripped away, and the real differences show up. Gradient Boosting clearly stays on top across the whole practical trading range."

---

#### **[8:30 - 9:15] Slide 12: What Did the Data Actually Learn?**
> *[Show Slide 12 on screen]*

"This was our most exciting finding: **what did the models actually care about?**

When we looked at feature importance, two features accounted for **84% of the entire decision**:

1. **`Dist_High_20` (43% importance):** How close the stock's price is to its 20-day high ceiling. Breakouts don't happen out of nowhere; first, the price quietly crawls right up against the resistance ceiling.
2. **`Log_Vol_Ratio` (41% importance):** Whether trading volume suddenly jumped compared to normal. This proves big buyers are quietly accumulating shares.

Together, **these two features explain 84% of the signal!**  
The data proves that a tight price under the ceiling plus a sudden jump in volume is the true fingerprint of a breakout."

---

#### **[9:15 - 9:55] Slide 13: What This Means in Real Life**
> *[Show Slide 13 on screen]*

"Now, what do these numbers mean for a real trader?

On our 19,600 test sessions:
- The system correctly ignored **18,655 quiet, boring days**.
- It successfully caught **132 real, explosive breakouts 24 hours in advance**.
- Yes, there are false alarms. But here is the bottom line:  
  **1 out of every 5 alerts from our model is a genuine winning breakout!**

Remember: in the normal market, only 1 in 50 days is a breakout. Our system improves your odds from **1 in 50 to 1 in 5**. In quantitative finance, that 9-times improvement gives a huge statistical edge."

---

#### **[9:55 - 10:30] Slide 14: Conclusion & Wrap-Up**
> *[Show Slide 14 on screen — Look back at the camera]*

"To wrap up our presentation:

1. We proved that data science can reliably spot pre-breakout setups 24 hours in advance without any cheating or lookahead bias.
2. Price proximity to resistance plus sudden volume expansion drive 84% of the predictive power.
3. Gradient Boosting was our champion, beating random chance by 8 times.
4. Our entire project—the R scripts, the SQLite database, our 25-page academic report, and these slides—is open-source and available on GitHub at `JonSnow42/Stock-Price-Breakout`.

Thank you very much for listening, and I hope this gave you a clear and simple understanding of my project!"

---

### 💡 Practice Tips for Your Video Recording
- **Total Spoken Words:** ~1,120 words. At an average speaking rate of 120–130 words/minute, this will naturally take **9 minutes and 15 seconds to 9 minutes and 45 seconds**.
- **No tongue-twisters:** Every complex term has been replaced with plain English words like *"ceiling"*, *"roof"*, *"volume jump"*, and *"1 in 5 odds"*.
- **Confidence:** Remember, you know your project better than anyone else. Keep a smile, speak with energy, and you'll do great!
