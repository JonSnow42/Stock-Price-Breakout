#!/usr/bin/env python3
"""
sync_toc_pages.py
Synchronizes Table of Contents, List of Figures, and List of Tables
in generate_academic_report.py to match the exact PDF pages.
"""

with open("Final_Report/generate_academic_report.py", "r") as f:
    text = f.read()

# Exact TOC dictionary
toc_old = """    toc_items = [
        ("1. Introduction", "4"),
        ("   1.1 Background of Stock Market Trend Analysis", "4"),
        ("   1.2 Financial Momentum in Equity Trading", "4"),
        ("   1.3 Momentum Breakouts: Technical Definition and Mechanics", "5"),
        ("   1.4 Practical Utility in Quantitative Portfolio Management", "5"),
        ("   1.5 Formal Problem Statement", "5"),
        ("   1.6 Project Objectives (Primary & Secondary)", "6"),
        ("   1.7 Scope, Boundary Conditions, and Methodological Limitations", "6"),
        ("2. Dataset Description & Database Architecture", "7"),
        ("   2.1 Data Source and Historical Extraction Protocol", "7"),
        ("   2.2 Universe of Selected S&P 500 Companies", "7"),
        ("   2.3 Temporal Characteristics and Trading Horizon", "8"),
        ("   2.4 Original vs. Processed Dataset Specifications", "8"),
        ("   2.5 Relational SQLite Database Architecture (stocks.db)", "9"),
        ("   2.6 Data Cleansing, Verification, and Missingness Audit", "9"),
        ("   2.7 Comprehensive Feature Dictionary", "10"),
        ("3. Exploratory Data Analysis & Visualizations", "11"),
        ("   3.1 Multi-Year Sector Price Trends (2016–2026)", "11"),
        ("   3.2 Sector-Level Daily Return Distributions & Volatility Regimes", "11"),
        ("   3.3 Cross-Sector Return Correlation Heatmap", "12"),
        ("   3.4 Momentum Indicator Distribution: RSI-14", "13"),
        ("   3.5 Breakout Event Frequency by Industrial Sector", "13"),
        ("   3.6 Micro-Level Case Study: NVDA Price, SMAs & Detected Breakouts", "14"),
        ("   3.7 Synthesis of Exploratory Findings", "14"),
        ("4. Statistical Analysis & Preprocessing Pipeline", "15"),
        ("   4.1 Mathematical Formulation of Technical Indicators", "15"),
        ("   4.2 Pearson Correlation Screening and Multicollinearity Pruning", "15"),
        ("   4.3 In-Sample Scaling and Feature Normalization", "16"),
        ("   4.4 Statistical Nature of Class Imbalance", "16"),
        ("   4.5 Supervised Target Engineering and Zero-Leakage Proof", "17"),
        ("5. Machine Learning Models & Experimental Methodology", "18"),
        ("   5.1 End-to-End Machine Learning Pipeline Architecture", "18"),
        ("   5.2 Chronological Partitioning Protocol (Train / Valid / Test)", "18"),
        ("   5.3 Algorithmic Formulations of the Ten ML Classifiers", "19"),
        ("   5.4 Hyperparameter Optimization via Random Grid Search", "21"),
        ("   5.5 Decision Threshold Calibration on Validation PR-AUC", "22"),
        ("6. Output Screenshots, Model Evaluation & Comparative Results", "23"),
        ("   6.1 Final Benchmark Results on Held-Out Test Set (2025–2026)", "23"),
        ("   6.2 Precision-Recall (PR) Curve Analysis", "24"),
        ("   6.3 Receiver Operating Characteristic (ROC) Curve Analysis", "24"),
        ("   6.4 Comparative Performance Profiles Across Key Metrics", "25"),
        ("   6.5 Validation-Stage Hyperparameter Tuning Trajectory", "25"),
        ("   6.6 Feature Importance Attribution (GBM, RF, XGBoost)", "26"),
        ("   6.7 Confusion Matrix Diagnostics of Champion Model (GBM)", "27"),
        ("   6.8 Critical Comparative Discussion and Error Analysis", "28"),
        ("7. Conclusion & Future Scope", "29"),
        ("   7.1 Summary of Engineering and Research Accomplishments", "29"),
        ("   7.2 Empirical Takeaways on Market Predictability", "29"),
        ("   7.3 Limitations in Live Execution Regimes", "30"),
        ("   7.4 Future Research Directions", "30"),
        ("8. Important R Code Snippets", "31"),
        ("9. GitHub Repository & Execution Guide", "33"),
        ("10. References", "34")
    ]"""

toc_new = """    toc_items = [
        ("1. Introduction", "6"),
        ("   1.1 Background of Stock Market Trend Analysis", "6"),
        ("   1.2 Financial Momentum in Equity Trading", "6"),
        ("   1.3 Momentum Breakouts: Technical Definition and Mechanics", "6"),
        ("   1.4 Practical Utility in Quantitative Portfolio Management", "7"),
        ("   1.5 Formal Problem Statement", "7"),
        ("   1.6 Project Objectives (Primary & Secondary)", "7"),
        ("   1.7 Scope, Boundary Conditions, and Methodological Limitations", "8"),
        ("2. Dataset Description & Database Architecture", "8"),
        ("   2.1 Data Source and Historical Extraction Protocol", "8"),
        ("   2.2 Universe of Selected S&P 500 Companies", "9"),
        ("   2.3 Temporal Characteristics and Trading Horizon", "9"),
        ("   2.4 Original vs. Processed Dataset Specifications", "10"),
        ("   2.5 Relational SQLite Database Architecture (stocks.db)", "10"),
        ("   2.6 Data Cleansing, Verification, and Missingness Audit", "10"),
        ("   2.7 Comprehensive Feature Dictionary", "10"),
        ("3. Exploratory Data Analysis & Visualizations", "12"),
        ("   3.1 Multi-Year Sector Price Trends & Volatility (Figs 1 & 2)", "12"),
        ("   3.2 Cross-Sector Correlations & RSI Distribution (Figs 3 & 4)", "12"),
        ("   3.3 Breakout Frequencies & NVDA Validation Case Study (Figs 5 & 6)", "13"),
        ("4. Statistical Analysis & Preprocessing Pipeline", "14"),
        ("   4.1 Mathematical Formulation of Technical Indicators", "14"),
        ("   4.2 Pearson Correlation Screening & Pruning", "14"),
        ("   4.3 In-Sample Scaling and Feature Normalization", "15"),
        ("   4.4 Statistical Nature of Class Imbalance", "15"),
        ("   4.5 Supervised Target Engineering and Zero-Leakage Proof", "16"),
        ("5. Machine Learning Models & Experimental Methodology", "16"),
        ("   5.1 End-to-End Machine Learning Pipeline Architecture", "16"),
        ("   5.2 Chronological Partitioning Protocol (Train / Valid / Test)", "16"),
        ("   5.3 Formulations of the Ten Supervised Classifiers", "17"),
        ("   5.4 Hyperparameter Optimization via Random Grid Search", "18"),
        ("   5.5 Decision Threshold Calibration on Validation PR-AUC", "18"),
        ("6. Output Screenshots, Model Evaluation & Comparative Results", "18"),
        ("   6.1 Final Benchmark Results on Held-Out Test Set (2025–2026)", "18"),
        ("   6.2 Discriminatory Power & PR / ROC Profiles (Figs 7 & 8)", "19"),
        ("   6.3 Multi-Metric Benchmarks & Tuning Deltas (Figs 9 & 10)", "20"),
        ("   6.4 Feature Importance & Confusion Matrix (Figs 11 & 12)", "20"),
        ("   6.5 Critical Comparative Discussion and Error Analysis", "21"),
        ("7. Conclusion & Future Scope", "22"),
        ("   7.1 Summary of Engineering and Research Accomplishments", "22"),
        ("   7.2 Empirical Takeaways on Market Predictability", "22"),
        ("   7.3 Methodological and Financial Limitations", "22"),
        ("   7.4 Future Research Directions", "23"),
        ("8. Important R Code Snippets", "23"),
        ("9. GitHub Repository & Execution Guide", "24"),
        ("10. References", "25")
    ]"""

text = text.replace(toc_old, toc_new)

# Synchronize Figure List
figs_old = """    figures_list = [
        ("Figure 1", "Sector-Wise Price Trend (2016–2026), Indexed to 100", "11"),
        ("Figure 2", "Daily Return Distribution and Volatility Spans across Sectors", "12"),
        ("Figure 3", "Hierarchically Clustered Correlation Heatmap of Sector Daily Returns", "12"),
        ("Figure 4", "Empirical Distribution of 14-Day Relative Strength Index (RSI)", "13"),
        ("Figure 5", "Historical Momentum Breakout Frequency (%) by Industrial Sector", "14"),
        ("Figure 6", "NVDA Price Action, Moving Averages (20/50), and Detected Breakouts", "14"),
        ("Figure 7", "Precision-Recall Curves on Held-Out Test Set across All 10 Classifiers", "24"),
        ("Figure 8", "Receiver Operating Characteristic (ROC) Curves on Test Set", "25"),
        ("Figure 9", "Multi-Metric Model Comparison on Test Data (ROC-AUC, PR-AUC, F1)", "25"),
        ("Figure 10", "Validation-Stage Performance Delta Before vs. After Hyperparameter Tuning", "26"),
        ("Figure 11", "Top 12 Predictive Features for Gradient Boosting, Random Forest, and XGBoost", "27"),
        ("Figure 12", "Confusion Matrix Heatmap of Best Performing Model (Gradient Boosting)", "28")
    ]"""

figs_new = """    figures_list = [
        ("Figure 1", "Sector-Wise Price Trend (2016–2026), Indexed to 100", "12"),
        ("Figure 2", "Daily Return Distribution and Volatility Spans across Sectors", "12"),
        ("Figure 3", "Correlation Heatmap Across Sector Returns", "12"),
        ("Figure 4", "14-Day RSI Distribution (30/70 Bounds)", "12"),
        ("Figure 5", "Breakout Frequency (%) by Industrial Sector", "13"),
        ("Figure 6", "NVDA Price Action, Moving Averages (20/50), and Detected Breakouts", "13"),
        ("Figure 7", "Precision-Recall Curves on Held-Out Test Set across All 10 Classifiers", "19"),
        ("Figure 8", "Receiver Operating Characteristic (ROC) Curves on Test Set", "20"),
        ("Figure 9", "Multi-Metric Model Comparison on Test Data (ROC-AUC, PR-AUC, F1)", "20"),
        ("Figure 10", "Validation-Stage Performance Delta Before vs. After Hyperparameter Tuning", "20"),
        ("Figure 11", "Top 12 Predictive Features for Gradient Boosting, Random Forest, and XGBoost", "20"),
        ("Figure 12", "Confusion Matrix Heatmap of Champion Model (Gradient Boosting)", "20")
    ]"""

text = text.replace(figs_old, figs_new)

# Synchronize Table List
tbls_old = """    tables_list = [
        ("Table 1", "Project Team Members and Functional Responsibilities", "2"),
        ("Table 2", "Supervisory Panel and Institutional Affiliation", "2"),
        ("Table 3", "Selected S&P 500 Constituent Universe Categorized across 10 GICS Sectors", "7"),
        ("Table 4", "Comprehensive Feature Dictionary of Processed & Engineered Predictors", "10"),
        ("Table 5", "Collinearity Screening Audit: Pairwise Correlations and Pruned Features", "16"),
        ("Table 6", "Chronological Data Partitioning Schema (Train, Validation, and Test)", "19"),
        ("Table 7", "Hyperparameter Search Spaces, Grid Allocations, and Optimal Selected Values", "22"),
        ("Table 8", "Final Comprehensive Evaluation Benchmark on Held-Out Test Set (2025–2026)", "23")
    ]"""

tbls_new = """    tables_list = [
        ("Table 1", "Project Team Members and Functional Responsibilities", "2"),
        ("Table 2", "Supervisory Panel and Institutional Affiliation", "2"),
        ("Table 3", "Curated S&P 500 Constituent Universe Categorized across 10 GICS Sectors", "9"),
        ("Table 4", "Comprehensive Feature Dictionary of Processed & Engineered Predictors", "10"),
        ("Table 5", "Collinearity Screening Audit: Pairwise Correlations and Pruned Features", "14"),
        ("Table 6", "Chronological Data Partitioning Schema (Train, Validation, and Test)", "16"),
        ("Table 7", "Hyperparameter Search Spaces, Grid Allocations, and Optimal Selected Values", "18"),
        ("Table 8", "Final Comprehensive Evaluation Benchmark on Held-Out Test Set (2025–2026)", "18")
    ]"""

text = text.replace(tbls_old, tbls_new)

with open("Final_Report/generate_academic_report.py", "w") as f:
    f.write(text)

print("Synchronized Table of Contents, Figures, and Tables page numbers!")
