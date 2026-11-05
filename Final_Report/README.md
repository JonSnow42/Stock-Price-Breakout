# Final Academic Project Report

**Project Title:** Machine Learning-Based Stock Market Trend Analysis and Momentum Breakout Prediction  
**Program:** Bachelor of Technology in Data Science  
**Environment:** RStudio (R 4.x on Linux / Fedora)  
**Target Length:** 20–25 Pages (Current Version: Exactly 25 Pages)  

---

## 📄 Deliverable Documents

1. **`Final_Academic_Report.docx`:** Fully styled, editable Microsoft Word document with professional academic typography, custom headings, structured tables, and embedded high-resolution figures.
2. **`Final_Academic_Report.pdf`:** Complete, publication-ready PDF document compiled with exact 25-page formatting and verified page-synchronized Table of Contents.
3. **`FULL_ACADEMIC_REPORT.md`:** Complete, exhaustive master text of the academic project report in GitHub-flavored Markdown with complete mathematical derivations, code walkthroughs, tables, and analytical narratives.
4. **`build_report.R`:** Standalone R automation script to re-generate the report documents.

---

## 📑 Report Structure (12 Standard Sections)

1. **Title Page (Page 1):** Academic title with clean placeholder frames for institutional and student details.
2. **Team Members & Academic Supervision (Page 2):** Formal tables cataloging student roles and supervisory affiliations.
3. **Abstract (Page 3):** Exhaustive academic abstract summarizing the financial problem, S&P 500 dataset, feature engineering, 10 ML models, evaluation methodology, and empirical findings.
4. **Table of Contents, List of Figures & Tables (Pages 4–5):** Complete navigation synchronized with the 25-page document.
5. **Chapter 1: Introduction (Pages 6–8):** Background of financial trend analysis, momentum principles, momentum breakout mechanics, practical portfolio utility, problem statement, objectives, and scope limitations.
6. **Chapter 2: Dataset Description & Database Architecture (Pages 8–11):** S&P 500 universe of 50 companies across 10 GICS sectors, 10-year trading horizon (2016–2026), raw (125k) vs. processed (123k) datasets, SQLite relational schema (`stocks.db`), and complete feature dictionary.
7. **Chapter 3: Exploratory Data Analysis & Visualizations (Pages 12–13):** Detailed analysis of all six EDA figures (sector trends, return distributions, correlation heatmaps, RSI distributions, breakout frequencies, NVDA case study).
8. **Chapter 4: Statistical Analysis & Preprocessing Pipeline (Pages 14–16):** Mathematical formulations, Pearson correlation screening, multicollinearity pruning, z-score normalization on training data, class imbalance analysis, and zero-lookahead target proof.
9. **Chapter 5: Machine Learning Models & Methodology (Pages 16–18):** End-to-end pipeline architecture, chronological partitioning schema, mathematical theory and R implementations of all ten algorithms, hyperparameter random grid tuning, and validation threshold calibration.
10. **Chapter 6: Output Screenshots, Model Evaluation & Comparative Results (Pages 18–21):** Test set benchmarks, PR curves, ROC curves, multi-metric profiles, tuning improvements, feature importance rankings, champion GBM confusion matrix diagnostics, and critical comparative discussion.
11. **Chapter 7: Conclusion & Future Scope (Pages 22–23):** Summary of accomplishments, market predictability takeaways, live execution limitations, and future research directions.
12. **Chapter 8: Important R Code Snippets (Pages 23–24):** Seven representative, annotated R snippets covering database ingestion, feature engineering, correlation pruning, model wrappers, PR-AUC engines, and threshold scanning.
13. **Chapter 9: GitHub Repository & Execution Guide (Pages 24–25):** Official repository URL (`https://github.com/JonSnow42/Stock-Price-Breakout`), repository map, and step-by-step reproduction instructions.
14. **Chapter 10: Academic References (Page 25):** 15 peer-reviewed academic papers, financial econometrics studies, and software package citations.
