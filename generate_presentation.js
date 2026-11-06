const pptxgen = require("/tmp/node_modules/pptxgenjs");
const path = require("path");

const pres = new pptxgen();
pres.layout = "LAYOUT_16x9"; // 10 x 5.625 inches
pres.author = "Saurabh Madhesia";
pres.title = "Stock Market Trend Analysis and Momentum Breakout Prediction";

const COLOR_NAVY = "0F2C59";
const COLOR_BLUE = "2166AC";
const COLOR_DARK = "1E293B";
const COLOR_MUTED = "64748B";
const COLOR_LIGHT_BG = "F8FAFC";
const COLOR_CARD_BG = "FFFFFF";
const COLOR_BORDER = "E2E8F0";
const COLOR_TEAL = "00897B";
const COLOR_GREEN = "16A34A";
const COLOR_DARK_NAVY = "0B1D3A";

// Helper function to add consistent headers & footers
function setupSlide(pres, title, subtitle, slideNum) {
  const slide = pres.addSlide();
  slide.background = { color: COLOR_LIGHT_BG };

  // Title
  slide.addText(title, {
    x: 0.6, y: 0.35, w: 8.8, h: 0.42,
    fontSize: 20, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
  });

  // Subtitle
  if (subtitle) {
    slide.addText(subtitle, {
      x: 0.6, y: 0.77, w: 8.8, h: 0.3,
      fontSize: 11, color: COLOR_MUTED, fontFace: "Calibri"
    });
  }

  // Footer line & text
  slide.addShape(pres.ShapeType.line, {
    x: 0.6, y: 5.25, w: 8.8, h: 0,
    line: { color: "CBD5E1", width: 0.75 }
  });

  slide.addText("Stock Market Trend Analysis & Momentum Breakout Prediction | VIT Chennai", {
    x: 0.6, y: 5.3, w: 6.5, h: 0.25,
    fontSize: 8.5, color: "94A3B8", fontFace: "Calibri"
  });

  slide.addText(`Slide ${slideNum} of 14`, {
    x: 7.5, y: 5.3, w: 1.9, h: 0.25,
    fontSize: 8.5, color: "94A3B8", align: "right", fontFace: "Calibri"
  });

  return slide;
}

// ==============================================================
// SLIDE 1: TITLE SLIDE (Dark Navy Background)
// ==============================================================
const s1 = pres.addSlide();
s1.background = { color: COLOR_DARK_NAVY };

// VIT Logo in white card at top center
s1.addShape(pres.ShapeType.rect, {
  x: 3.5, y: 0.35, w: 3.0, h: 1.0,
  fill: { color: "FFFFFF" },
  line: { color: "CBD5E1", width: 1 }
});
s1.addImage({
  path: "assets/vit_logo.png",
  x: 3.6, y: 0.42, w: 2.8, h: 0.86
});

// Category Badge
s1.addText("B.TECH DATA SCIENCE CAPSTONE PROJECT · ACADEMIC YEAR 2026–27", {
  x: 0.8, y: 1.55, w: 8.4, h: 0.3,
  fontSize: 10, bold: true, color: "38BDF8", align: "center", fontFace: "Calibri"
});

// Title & Subtitle
s1.addText("Stock Market Trend Analysis and\nMomentum Breakout Prediction", {
  x: 0.8, y: 1.95, w: 8.4, h: 1.1,
  fontSize: 25, bold: true, color: "FFFFFF", align: "center", fontFace: "Calibri"
});

s1.addText("A 10-Year Quantitative Machine Learning Study Across 50 S&P 500 Equities (2016–2026)", {
  x: 0.8, y: 3.15, w: 8.4, h: 0.35,
  fontSize: 12.5, italic: true, color: "94A3B8", align: "center", fontFace: "Calibri"
});

// Divider line
s1.addShape(pres.ShapeType.line, {
  x: 1.5, y: 3.65, w: 7.0, h: 0,
  line: { color: "334155", width: 1 }
});

// Author Details (Left)
s1.addText([
  { text: "Submitted by:\n", options: { bold: true, color: "38BDF8", fontSize: 10 } },
  { text: "Saurabh Madhesia\n", options: { bold: true, color: "FFFFFF", fontSize: 12 } },
  { text: "Reg. No.: 24BDS1082\n", options: { color: "CBD5E1", fontSize: 10 } },
  { text: "School of Computer Science & Engineering\nVIT Chennai", options: { color: "94A3B8", fontSize: 9.5 } }
], { x: 1.2, y: 3.85, w: 3.8, h: 1.4, fontFace: "Calibri" });

// Guide Details (Right)
s1.addText([
  { text: "Under the Guidance of:\n", options: { bold: true, color: "38BDF8", fontSize: 10 } },
  { text: "Dr. Vijayalakshmi A\n", options: { bold: true, color: "FFFFFF", fontSize: 12 } },
  { text: "Associate Professor / Professor\n", options: { color: "CBD5E1", fontSize: 10 } },
  { text: "SCOPE, Vellore Institute of Technology\nChennai Campus", options: { color: "94A3B8", fontSize: 9.5 } }
], { x: 5.2, y: 3.85, w: 3.8, h: 1.4, fontFace: "Calibri" });


// ==============================================================
// SLIDE 2: BACKGROUND & PROBLEM OVERVIEW
// ==============================================================
const s2 = setupSlide(pres, "Background & Problem Overview", "What is a momentum breakout, and why does predicting it matter?", 2);

// Top definition banner
s2.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 1.15, w: 8.8, h: 0.8,
  fill: { color: "EFF6FF" },
  line: { color: "BFDBFE", width: 1 }
});
s2.addText("A Momentum Breakout occurs when an equity price forcefully closes above an established multi-week consolidation resistance ceiling accompanied by extraordinary trading volume, signaling institutional accumulation.", {
  x: 0.8, y: 1.22, w: 8.4, h: 0.65,
  fontSize: 11.5, color: COLOR_NAVY, bold: false, fontFace: "Calibri"
});

// 4 Challenge Cards
const s2Cards = [
  { num: "01", title: "Subjective Analysis", desc: "Traditional chart-reading relies on manual visual heuristics; two analysts often reach conflicting conclusions on identical charts." },
  { num: "02", title: "High False-Positive Rate", desc: "Simple 20-day high screeners frequently trigger false breakouts ('bull traps') that reverse downward intraday." },
  { num: "03", title: "Severe Class Imbalance", desc: "True momentum breakouts are statistically rare (~2.15%–2.45% of trading days), rendering raw classification accuracy misleading." },
  { num: "04", title: "Lookahead Bias Risk", desc: "Financial models often inadvertently leak same-day volume or closing prices into prediction features, invalidating live results." }
];

s2Cards.forEach((c, idx) => {
  const xPos = 0.6 + idx * 2.25;
  s2.addShape(pres.ShapeType.rect, {
    x: xPos, y: 2.15, w: 2.05, h: 2.85,
    fill: { color: COLOR_CARD_BG },
    line: { color: COLOR_BORDER, width: 1 }
  });
  s2.addText(c.num, {
    x: xPos + 0.15, y: 2.3, w: 1.75, h: 0.35,
    fontSize: 16, bold: true, color: COLOR_BLUE, fontFace: "Calibri"
  });
  s2.addText(c.title, {
    x: xPos + 0.15, y: 2.7, w: 1.75, h: 0.45,
    fontSize: 12, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
  });
  s2.addText(c.desc, {
    x: xPos + 0.15, y: 3.2, w: 1.75, h: 1.65,
    fontSize: 9.5, color: "475569", fontFace: "Calibri"
  });
});


// ==============================================================
// SLIDE 3: PROJECT OBJECTIVES
// ==============================================================
const s3 = setupSlide(pres, "Project Objectives", "Core engineering and analytical goals of the machine learning pipeline", 3);

// Primary Objective Banner
s3.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 1.15, w: 8.8, h: 0.85,
  fill: { color: "F0FDF4" },
  line: { color: "BBF7D0", width: 1 }
});
s3.addText([
  { text: "PRIMARY OBJECTIVE\n", options: { bold: true, color: COLOR_GREEN, fontSize: 9.5 } },
  { text: "Build and empirically benchmark a 100% leak-free, reproducible machine learning pipeline in RStudio to forecast next-trading-day (t+1) momentum breakout opportunities across large-cap US equities.", options: { color: COLOR_NAVY, fontSize: 11.5, bold: false } }
], { x: 0.8, y: 1.22, w: 8.4, h: 0.7, fontFace: "Calibri" });

// 4 Specific Objectives
const s3Cards = [
  { title: "1. 10-Year Multi-Sector Data", items: ["125,650 daily OHLCV observations (2016–2026)", "50 large-cap S&P 500 equities across 10 GICS sectors", "Zero missing values or duplicate records"] },
  { title: "2. Relational DB (stocks.db)", items: ["SQLite database initialized via DBI & RSQLite", "Fast relational staging of raw & processed data", "Complete audit logging for tuning & model runs"] },
  { title: "3. Feature Engineering & Pruning", items: ["26 candidate technical, volatility & volume metrics", "Automated Pearson pruning (|r| <= 0.90) drops 3 collinear variables", "23 standardized predictors retained"] },
  { title: "4. ML Benchmarking & Tuning", items: ["10 supervised classifiers across diverse paradigms", "Square-root weighting & downsampling for rare events", "Decision thresholds optimized on validation PR-AUC"] }
];

s3Cards.forEach((c, idx) => {
  const col = idx % 2;
  const row = Math.floor(idx / 2);
  const xPos = 0.6 + col * 4.5;
  const yPos = 2.2 + row * 1.45;

  s3.addShape(pres.ShapeType.rect, {
    x: xPos, y: yPos, w: 4.3, h: 1.35,
    fill: { color: COLOR_CARD_BG },
    line: { color: COLOR_BORDER, width: 1 }
  });
  s3.addText(c.title, {
    x: xPos + 0.2, y: yPos + 0.1, w: 3.9, h: 0.28,
    fontSize: 11, bold: true, color: COLOR_NAVY, fontFace: "Calibri", valign: "top"
  });
  const bulletTexts = c.items.map(item => ({ text: item, options: { bullet: true, fontSize: 8.8, color: "334155", paraSpaceAfter: 2 } }));
  s3.addText(bulletTexts, {
    x: xPos + 0.2, y: yPos + 0.44, w: 3.9, h: 0.82,
    fontFace: "Calibri", valign: "top"
  });
});


// ==============================================================
// SLIDE 4: DATASET DESCRIPTION & DATABASE ARCHITECTURE
// ==============================================================
const s4 = setupSlide(pres, "Dataset & Database Architecture", "Curated S&P 500 constituent universe and relational SQLite storage", 4);

// 3 Top Stat Badges
const stats = [
  { val: "125,650", label: "Raw OHLCV Observations", sub: "50 stocks × 10 years (2016–2026)" },
  { val: "10 Sectors", label: "GICS Diversification", sub: "Tech, Finance, Health, Energy, etc." },
  { val: "121,600", label: "Final Model Instances", sub: "23 standardized non-collinear features" }
];

stats.forEach((st, idx) => {
  const xPos = 0.6 + idx * 3.0;
  s4.addShape(pres.ShapeType.rect, {
    x: xPos, y: 1.15, w: 2.8, h: 0.9,
    fill: { color: COLOR_CARD_BG },
    line: { color: COLOR_BORDER, width: 1 }
  });
  s4.addText(st.val, {
    x: xPos + 0.15, y: 1.22, w: 2.5, h: 0.38,
    fontSize: 18, bold: true, color: COLOR_BLUE, fontFace: "Calibri"
  });
  s4.addText(`${st.label} · ${st.sub}`, {
    x: xPos + 0.15, y: 1.62, w: 2.5, h: 0.35,
    fontSize: 8.5, color: COLOR_MUTED, fontFace: "Calibri"
  });
});

// Left Card: Dataset Stages
s4.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 2.2, w: 4.3, h: 2.8,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s4.addText("Dataset Lifecycle & Verification", {
  x: 0.8, y: 2.35, w: 3.9, h: 0.3,
  fontSize: 12, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
});
s4.addText([
  { text: "Master Dataset (master_dataset.csv):\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9.5 } },
  { text: "125,650 rows × 9 cols; unadulterated Yahoo Finance daily feed (15.3 MB).\n", options: { color: "475569", fontSize: 9 } },
  { text: "Processed Dataset (processed_dataset.csv):\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9.5 } },
  { text: "123,150 rows × 45 cols; 50-day warm-up window for 50-day SMA removed (73.4 MB).\n", options: { color: "475569", fontSize: 9 } },
  { text: "Data Integrity Audit:\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9.5 } },
  { text: "Zero missing values (NA/NaN); zero duplicate dates; corporate splits/dividends fully adjusted.", options: { color: "475569", fontSize: 9 } }
], { x: 0.8, y: 2.7, w: 3.9, h: 2.2, fontFace: "Calibri" });

// Right Card: Database Schema
s4.addShape(pres.ShapeType.rect, {
  x: 5.1, y: 2.2, w: 4.3, h: 2.8,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s4.addText("Relational SQLite Schema (stocks.db · 63.1 MB)", {
  x: 5.3, y: 2.35, w: 3.9, h: 0.3,
  fontSize: 12, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
});
s4.addText([
  { text: "Table 1: stock_data (123,150 rows × 45 cols)\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9.5 } },
  { text: "Verified relational storage for fast SQL aggregation and sector filters.\n", options: { color: "475569", fontSize: 9 } },
  { text: "Table 2: model_features (121,600 rows × 27 cols)\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9.5 } },
  { text: "Model-ready records with split tag (train/valid/test), y, and 23 scaled predictors.\n", options: { color: "475569", fontSize: 9 } },
  { text: "Table 3: model_results (33 benchmark tracking records)\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9.5 } },
  { text: "Official registry recording PR-AUC, ROC-AUC, F1, and threshold logs.\n", options: { color: "475569", fontSize: 9 } },
  { text: "Table 4: tuning_log (47 hyperparameter search trials)\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9.5 } },
  { text: "Granular trial parameter configurations and validation scores.", options: { color: "475569", fontSize: 9 } }
], { x: 5.3, y: 2.7, w: 3.9, h: 2.2, fontFace: "Calibri" });


// ==============================================================
// SLIDE 5: EXPLORATORY DATA ANALYSIS: SECTOR PRICE TRENDS
// ==============================================================
const s5 = setupSlide(pres, "Exploratory Data Analysis: Sector Price Trends", "Multi-year sector price performance and volatility divergence (2016–2026)", 5);

// Left Image Card
s5.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 1.15, w: 4.8, h: 3.85,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s5.addImage({
  path: "plots/eda/01_sector_price_trend.png",
  x: 0.7, y: 1.25, w: 4.6, h: 3.65
});

// Right Insights Cards
const s5Insights = [
  { title: "Mega-Cap Technology Outperformance", text: "Technology expanded from a base of 100 to over 750, driven by the cloud software boom and the 2023–2026 generative AI semiconductor surge (NVDA, MSFT, AAPL)." },
  { title: "Defensive vs. Cyclical Divergence", text: "Defensive sectors (Utilities, Real Estate, Consumer Staples) grew moderately (120–180), displaying steady, low-beta price trajectories." },
  { title: "Volatility Heterogeneity", text: "High-beta sectors experienced large cyclical drawdowns (e.g., 2020 COVID crash, 2022 Fed rate tightening), confirming that baseline volatility varies substantially across sectors." }
];

s5Insights.forEach((ins, idx) => {
  const yPos = 1.15 + idx * 1.3;
  s5.addShape(pres.ShapeType.rect, {
    x: 5.6, y: yPos, w: 3.8, h: 1.2,
    fill: { color: COLOR_CARD_BG },
    line: { color: COLOR_BORDER, width: 1 }
  });
  s5.addText(ins.title, {
    x: 5.75, y: yPos + 0.1, w: 3.5, h: 0.3,
    fontSize: 11, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
  });
  s5.addText(ins.text, {
    x: 5.75, y: yPos + 0.42, w: 3.5, h: 0.7,
    fontSize: 8.8, color: "475569", fontFace: "Calibri"
  });
});


// ==============================================================
// SLIDE 6: SECTOR CORRELATIONS & BREAKOUT FREQUENCY
// ==============================================================
const s6 = setupSlide(pres, "Sector Correlations & Breakout Asymmetry", "Cross-sector return correlation heatmap and empirical breakout prevalence", 6);

// Left Image Card
s6.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 1.15, w: 4.8, h: 3.85,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s6.addImage({
  path: "plots/eda/03_sector_correlation_heatmap.png",
  x: 0.8, y: 1.25, w: 4.4, h: 3.65
});

// Right Insights Cards
const s6Insights = [
  { title: "Cyclical & Growth Co-Movement", text: "Hierarchical clustering groups Technology, Consumer Discretionary, Financials, and Industrials into a strong co-moving cluster (r = 0.65 to 0.82)." },
  { title: "Defensive & Energy Independence", text: "Utilities, Real Estate, and Staples form a defensive cluster (r = 0.40 to 0.55). Energy exhibits the lowest correlation to the broad market (r ~ 0.35–0.45)." },
  { title: "Breakout Asymmetry by Sector", text: "Breakout frequency is highest in high-beta industries (Technology: 3.42%, Industrials: 2.85%) and lowest in Utilities (1.12%), proving breakout probability is fundamentally sector-dependent." }
];

s6Insights.forEach((ins, idx) => {
  const yPos = 1.15 + idx * 1.3;
  s6.addShape(pres.ShapeType.rect, {
    x: 5.6, y: yPos, w: 3.8, h: 1.2,
    fill: { color: COLOR_CARD_BG },
    line: { color: COLOR_BORDER, width: 1 }
  });
  s6.addText(ins.title, {
    x: 5.75, y: yPos + 0.1, w: 3.5, h: 0.3,
    fontSize: 11, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
  });
  s6.addText(ins.text, {
    x: 5.75, y: yPos + 0.42, w: 3.5, h: 0.7,
    fontSize: 8.8, color: "475569", fontFace: "Calibri"
  });
});


// ==============================================================
// SLIDE 7: FEATURE ENGINEERING & ZERO-LEAKAGE FORMULATION
// ==============================================================
const s7 = setupSlide(pres, "Feature Engineering & Zero-Leakage Target", "Quantitative target definition and multicollinearity pruning protocol", 7);

// Top Target Cards
s7.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 1.15, w: 4.3, h: 1.3,
  fill: { color: "EFF6FF" },
  line: { color: "BFDBFE", width: 1 }
});
s7.addText("1. Same-Day Breakout Event (Day t)", {
  x: 0.8, y: 1.25, w: 3.9, h: 0.25,
  fontSize: 11, bold: true, color: COLOR_BLUE, fontFace: "Calibri"
});
s7.addText([
  { text: "Breakout_Today(t) = I( Adj_Close(t) > High_20_prior(t)  &\n", options: { bold: true, fontSize: 9.5, color: COLOR_NAVY } },
  { text: "                          Volume(t) > 1.5 × Avg_Volume_20(t) )", options: { bold: true, fontSize: 9.5, color: COLOR_NAVY } }
], {
  x: 0.8, y: 1.55, w: 3.9, h: 0.75,
  fontFace: "Calibri", valign: "top"
});

s7.addShape(pres.ShapeType.rect, {
  x: 5.1, y: 1.15, w: 4.3, h: 1.3,
  fill: { color: "F0FDF4" },
  line: { color: "BBF7D0", width: 1 }
});
s7.addText("2. Supervised Target Label (Day t+1 Lead)", {
  x: 5.3, y: 1.25, w: 3.9, h: 0.25,
  fontSize: 11, bold: true, color: COLOR_GREEN, fontFace: "Calibri"
});
s7.addText([
  { text: "Target: Breakout_Next(t) = Breakout_Today(t + 1)\n", options: { bold: true, fontSize: 9.5, color: COLOR_NAVY } },
  { text: "= lead(Breakout_Today(t), 1)   [100% Zero-Leakage Lead]", options: { bold: true, fontSize: 9.5, color: COLOR_GREEN } }
], {
  x: 5.3, y: 1.55, w: 3.9, h: 0.75,
  fontFace: "Calibri", valign: "top"
});

// Bottom Left: Zero-Leakage Guarantee
s7.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 2.6, w: 4.3, h: 2.4,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s7.addText("Mathematical Proof of Zero Leakage", {
  x: 0.8, y: 2.75, w: 3.9, h: 0.3,
  fontSize: 12, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
});
s7.addText([
  { text: "Strict Information Cutoff:\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9.5 } },
  { text: "At market close of day t, all 23 predictors utilize prices and volumes up to day t.\n\n", options: { color: "475569", fontSize: 9 } },
  { text: "Predicting Future State:\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9.5 } },
  { text: "The target evaluates conditions occurring strictly on day t+1, allowing quantitative traders to position capital before market open.", options: { color: "475569", fontSize: 9 } }
], { x: 0.8, y: 3.1, w: 3.9, h: 1.75, fontFace: "Calibri" });

// Bottom Right: Pruning Table
s7.addShape(pres.ShapeType.rect, {
  x: 5.1, y: 2.6, w: 4.3, h: 2.4,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s7.addText("Automated Pearson Pruning (|r| > 0.90)", {
  x: 5.3, y: 2.75, w: 3.9, h: 0.3,
  fontSize: 12, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
});
const rawPrune = [
  ["Dropped Feature", "Correlated Feature", "|r|", "Status"],
  ["Price_vs_SMA50", "MACD_Pct", "0.93", "Pruned"],
  ["ATR_Pct", "Volatility_20", "0.92", "Pruned"],
  ["Price_vs_SMA20", "Return_10d", "0.91", "Pruned"],
  ["23 Predictors", "Pairwise |r| <= 0.90", "-", "Retained"]
];
const pruneRows = rawPrune.map((row, rIdx) => {
  return row.map((cellText, cIdx) => {
    let opts = {};
    if (rIdx === 0) {
      opts = { bold: true, fill: { color: "F1F5F9" }, color: "0F2C59" };
    } else if (rIdx === 4) {
      opts = { bold: true, fill: { color: "ECFDF5" }, color: "065F46" };
    } else if (cIdx === 3) {
      opts = { bold: true, color: "DC2626" };
    }
    return { text: cellText, options: opts };
  });
});
s7.addTable(pruneRows, {
  x: 5.3, y: 3.15, w: 3.9, h: 1.65,
  colW: [1.3, 1.3, 0.5, 0.8],
  fontSize: 8.5,
  fontFace: "Calibri",
  align: "center",
  border: { pt: 0.5, color: "CBD5E1" },
  fill: { color: "FFFFFF" }
});


// ==============================================================
// SLIDE 8: CHRONOLOGICAL PARTITIONING & CLASS IMBALANCE
// ==============================================================
const s8 = setupSlide(pres, "Chronological Splitting & Class Imbalance Strategy", "Realistic out-of-time evaluation and rare-event calibration", 8);

// 3 Split Cards
const splits = [
  { name: "TRAINING SET (63.2%)", period: "2016-11-21 to 2022-12-30", rows: "76,900 rows", pos: "1,881 breakouts (2.45%)", purpose: "In-sample model fitting & feature scaling parameters" },
  { name: "VALIDATION SET (20.6%)", period: "2023-01-03 to 2024-12-31", rows: "25,100 rows", pos: "580 breakouts (2.31%)", purpose: "Hyperparameter tuning & optimal F1 threshold calibration" },
  { name: "TEST SET (16.2%)", period: "2025-01-02 to 2026-07-28", rows: "19,600 rows", pos: "422 breakouts (2.15%)", purpose: "Untouched held-out benchmark evaluation (no snooping)" }
];

splits.forEach((sp, idx) => {
  const xPos = 0.6 + idx * 3.0;
  s8.addShape(pres.ShapeType.rect, {
    x: xPos, y: 1.15, w: 2.8, h: 1.75,
    fill: { color: idx === 2 ? "F0FDF4" : COLOR_CARD_BG },
    line: { color: idx === 2 ? "86EFAC" : COLOR_BORDER, width: 1.2 }
  });
  s8.addText(sp.name, {
    x: xPos + 0.15, y: 1.25, w: 2.5, h: 0.25,
    fontSize: 9.5, bold: true, color: idx === 2 ? COLOR_GREEN : COLOR_NAVY, fontFace: "Calibri"
  });
  s8.addText(sp.rows, {
    x: xPos + 0.15, y: 1.55, w: 2.5, h: 0.35,
    fontSize: 16, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
  });
  s8.addText(`${sp.period}\n${sp.pos}\n${sp.purpose}`, {
    x: xPos + 0.15, y: 1.95, w: 2.5, h: 0.85,
    fontSize: 8.5, color: "475569", fontFace: "Calibri"
  });
});

// Bottom Left: Class Balancing
s8.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 3.1, w: 4.3, h: 1.9,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s8.addText("Addressing Severe Class Imbalance (~2.2% Positives)", {
  x: 0.8, y: 3.25, w: 3.9, h: 0.3,
  fontSize: 11.5, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
});
s8.addText([
  { text: "Square-Root Class Weighting (Tree & Linear Models):\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9 } },
  { text: "Positive instances weighted w1 = sqrt(N0 / N1) ~ 6.31, penalizing false negatives without destabilizing gradient variance.\n", options: { color: "475569", fontSize: 8.5 } },
  { text: "Negative Downsampling (SVM, KNN, MLP):\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9 } },
  { text: "Training majority class downsampled to 4:1 ratio; validation and test sets remain untouched at natural market prevalence.", options: { color: "475569", fontSize: 8.5 } }
], { x: 0.8, y: 3.55, w: 3.9, h: 1.35, fontFace: "Calibri" });

// Bottom Right: Threshold Optimization
s8.addShape(pres.ShapeType.rect, {
  x: 5.1, y: 3.1, w: 4.3, h: 1.9,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s8.addText("Decision Threshold Calibration (tau*)", {
  x: 5.3, y: 3.25, w: 3.9, h: 0.3,
  fontSize: 11.5, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
});
s8.addText([
  { text: "Why Default tau = 0.50 Fails:\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9 } },
  { text: "Under extreme class imbalance, predicted probabilities cluster near zero. A fixed 0.50 threshold yields near-zero recall.\n", options: { color: "475569", fontSize: 8.5 } },
  { text: "Optimal F1 Threshold (Locked on Validation):\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9 } },
  { text: "The threshold maximizing validation F1 score is computed and locked on validation data, then applied directly to the test set.", options: { color: "475569", fontSize: 8.5 } }
], { x: 5.3, y: 3.55, w: 3.9, h: 1.35, fontFace: "Calibri" });


// ==============================================================
// SLIDE 9: TEN MACHINE LEARNING ALGORITHMS EVALUATED
// ==============================================================
const s9 = setupSlide(pres, "Ten Supervised Machine Learning Algorithms", "Broad algorithmic benchmark across six fundamental statistical paradigms", 9);

const s9Cats = [
  {
    cat: "Linear & Margin Classifiers",
    models: [
      { name: "Logistic Regression (stats::glm)", desc: "Weighted GLM modeling log-odds via logit link; fast parametric linear baseline." },
      { name: "Linear Discriminant Analysis (MASS::lda)", desc: "Maximizes ratio of between-to-within class variance under pooled covariance." },
      { name: "Support Vector Machine (e1071::svm)", desc: "Radial basis function (RBF) kernel margin maximization with Platt scaling." }
    ]
  },
  {
    cat: "Tree-Based Ensemble Models",
    models: [
      { name: "Decision Tree (rpart::rpart)", desc: "CART algorithm recursively splitting on Gini impurity with tree depth limits." },
      { name: "Random Forest (ranger::ranger)", desc: "300 de-correlated bagged trees with random subspace sampling (mtry = 4)." },
      { name: "Gradient Boosting (gbm::gbm)", desc: "Sequential stagewise boosting fitting negative gradients of Bernoulli loss." },
      { name: "XGBoost (xgboost::xgb.train)", desc: "Second-order Taylor loss optimization with L1/L2 leaf penalties and shrinkage." }
    ]
  },
  {
    cat: "Distance, Probabilistic & Neural",
    models: [
      { name: "K-Nearest Neighbours (class::knn)", desc: "Instance-based Euclidean voting (k = 81) averaging local positive breakout density." },
      { name: "Naive Bayes (e1071::naiveBayes)", desc: "Class posteriors via Bayes' rule under feature conditional independence." },
      { name: "Neural Network / MLP (nnet::nnet)", desc: "Single-hidden-layer perceptron trained via BFGS with weight decay penalty (lambda = 0.10)." }
    ]
  }
];

s9Cats.forEach((c, idx) => {
  const xPos = 0.6 + idx * 3.0;
  s9.addShape(pres.ShapeType.rect, {
    x: xPos, y: 1.15, w: 2.8, h: 3.85,
    fill: { color: COLOR_CARD_BG },
    line: { color: COLOR_BORDER, width: 1 }
  });
  s9.addText(c.cat, {
    x: xPos + 0.15, y: 1.3, w: 2.5, h: 0.35,
    fontSize: 11, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
  });
  const modelTexts = [];
  c.models.forEach(m => {
    modelTexts.push({ text: m.name + "\n", options: { bold: true, color: COLOR_BLUE, fontSize: 9 } });
    modelTexts.push({ text: m.desc + "\n\n", options: { color: "475569", fontSize: 8.5 } });
  });
  s9.addText(modelTexts, {
    x: xPos + 0.15, y: 1.7, w: 2.5, h: 3.15,
    fontFace: "Calibri", valign: "top"
  });
});


// ==============================================================
// SLIDE 10: MODEL BENCHMARK RESULTS (TEST SET)
// ==============================================================
const s10 = setupSlide(pres, "Model Benchmark Results (Held-Out Test Set)", "Performance comparison on 19,600 untouched records (2025–2026; 422 breakouts)", 10);

const rawTestRows = [
  ["Rank & Model Name", "ROC-AUC", "PR-AUC", "Precision", "Recall", "F1-Score", "Optimal Threshold"],
  ["1. Gradient Boosting (GBM)", "0.8536", "0.1721", "20.15%", "31.28%", "0.2451", "0.4717"],
  ["2. Neural Network (MLP)", "0.8582", "0.1645", "16.64%", "42.65%", "0.2394", "0.5345"],
  ["3. XGBoost", "0.8573", "0.1630", "20.98%", "28.44%", "0.2414", "0.4752"],
  ["4. Linear Discriminant Analysis", "0.8523", "0.1549", "21.06%", "25.36%", "0.2301", "0.1289"],
  ["5. K-Nearest Neighbours (k=81)", "0.8460", "0.1518", "22.17%", "24.64%", "0.2334", "0.5185"],
  ["6. Random Forest", "0.8447", "0.1490", "21.11%", "21.56%", "0.2134", "0.1529"],
  ["7. Logistic Regression", "0.8554", "0.1482", "18.21%", "32.23%", "0.2327", "0.4071"],
  ["8. Naive Bayes", "0.8135", "0.1409", "20.73%", "22.99%", "0.2180", "0.9747"],
  ["9. Decision Tree (CART)", "0.8189", "0.1374", "19.25%", "29.38%", "0.2326", "0.5128"],
  ["10. SVM (Radial Kernel)", "0.8079", "0.1329", "19.41%", "26.54%", "0.2242", "0.2659"],
  ["Baseline (Random Guessing)", "0.5000", "0.0215", "2.15%", "100.0%", "0.0421", "N/A"]
];

const testTableData = rawTestRows.map((row, rIdx) => {
  return row.map((cellText, cIdx) => {
    let opts = {};
    if (rIdx === 0) {
      opts = { bold: true, fill: { color: "F1F5F9" }, color: "0F2C59" };
    } else if (rIdx === 1) {
      opts = { bold: cIdx === 0 || cIdx === 2, fill: { color: "ECFDF5" }, color: "065F46" };
    } else if (rIdx === 11) {
      opts = { italic: true, fill: { color: "F8FAFC" }, color: "64748B" };
    }
    return { text: cellText, options: opts };
  });
});

s10.addTable(testTableData, {
  x: 0.6, y: 1.15, w: 8.8, h: 3.1,
  colW: [2.5, 1.0, 1.0, 1.1, 1.0, 1.0, 1.2],
  fontSize: 8.5,
  fontFace: "Calibri",
  align: "center",
  border: { pt: 0.5, color: "CBD5E1" },
  fill: { color: "FFFFFF" }
});

// Bottom Callout
s10.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 4.4, w: 8.8, h: 0.65,
  fill: { color: "EFF6FF" },
  line: { color: "BFDBFE", width: 1 }
});
s10.addText("KEY FINDING: Gradient Boosting (GBM) achieved champion performance with a PR-AUC of 0.1721—delivering an 8.0x lift over the 0.0215 random guessing baseline. Neural Network achieved the highest overall Recall (42.65%), while KNN delivered top Precision (22.17%).", {
  x: 0.8, y: 4.45, w: 8.4, h: 0.55,
  fontSize: 9.5, bold: false, color: COLOR_NAVY, fontFace: "Calibri"
});


// ==============================================================
// SLIDE 11: PRECISION-RECALL & ROC CURVES DIAGNOSTICS
// ==============================================================
const s11 = setupSlide(pres, "Model Diagnostics: PR & ROC Curves", "Why Precision-Recall AUC is the decisive metric for rare financial events", 11);

// Left Image Card: PR Curve
s11.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 1.15, w: 4.3, h: 3.15,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s11.addImage({
  path: "plots/ml/02_precision_recall_curves_test.png",
  x: 0.7, y: 1.25, w: 4.1, h: 2.95
});

// Right Image Card: ROC Curve
s11.addShape(pres.ShapeType.rect, {
  x: 5.1, y: 1.15, w: 4.3, h: 3.15,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s11.addImage({
  path: "plots/ml/01_roc_curves_test.png",
  x: 5.2, y: 1.25, w: 4.1, h: 2.95
});

// Bottom Insights Card
s11.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 4.4, w: 8.8, h: 0.65,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s11.addText([
  { text: "ROC Curves (Right): ", options: { bold: true, color: COLOR_NAVY, fontSize: 9 } },
  { text: "All models exceed 0.80 ROC-AUC because the huge negative majority dilutes the false positive rate.  ·  ", options: { color: "475569", fontSize: 9 } },
  { text: "PR Curves (Left): ", options: { bold: true, color: COLOR_BLUE, fontSize: 9 } },
  { text: "PR-AUC clearly differentiates algorithm quality under class imbalance; GBM maintains superior precision across the practical 10%–40% recall band.", options: { color: "475569", fontSize: 9 } }
], { x: 0.8, y: 4.45, w: 8.4, h: 0.55, fontFace: "Calibri" });


// ==============================================================
// SLIDE 12: FEATURE IMPORTANCE ATTRIBUTION: THE 83.7% DRIVERS
// ==============================================================
const s12 = setupSlide(pres, "Feature Importance: The 83.7% Drivers", "Tree ensemble feature importance rankings across GBM, Random Forest, and XGBoost", 12);

// Left Image Card
s12.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 1.15, w: 5.2, h: 3.85,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s12.addImage({
  path: "plots/ml/05_feature_importance.png",
  x: 0.7, y: 1.3, w: 5.0, h: 3.55
});

// Right Insights Cards
const s12Insights = [
  {
    title: "1. Dist_High_20 (43.13% Importance)",
    text: "Measures price proximity to the prior 20-day high ceiling. Breakouts occur when price compresses tightly against upper resistance."
  },
  {
    title: "2. Log_Vol_Ratio (40.57% Importance)",
    text: "Log-ratio of current volume to its 20-day average. Unusual volume expansion confirms institutional accumulation absorbing supply."
  },
  {
    title: "Core Signal Takeaway (83.7% Total)",
    text: "Proximity to resistance + volume expansion jointly explain 83.7% of decision power in the winning Gradient Boosting model!"
  }
];

s12Insights.forEach((ins, idx) => {
  const yPos = 1.15 + idx * 1.3;
  s12.addShape(pres.ShapeType.rect, {
    x: 6.0, y: yPos, w: 3.4, h: 1.2,
    fill: { color: idx === 2 ? "F0FDF4" : COLOR_CARD_BG },
    line: { color: idx === 2 ? "86EFAC" : COLOR_BORDER, width: 1 }
  });
  s12.addText(ins.title, {
    x: 6.15, y: yPos + 0.1, w: 3.1, h: 0.3,
    fontSize: 10.5, bold: true, color: idx === 2 ? COLOR_GREEN : COLOR_NAVY, fontFace: "Calibri"
  });
  s12.addText(ins.text, {
    x: 6.15, y: yPos + 0.42, w: 3.1, h: 0.7,
    fontSize: 8.8, color: "475569", fontFace: "Calibri"
  });
});


// ==============================================================
// SLIDE 13: CHAMPION MODEL CONFUSION MATRIX & TRADE-OFFS
// ==============================================================
const s13 = setupSlide(pres, "Champion Model: Confusion Matrix Analysis", "Operational trade-offs and performance of Gradient Boosting at optimal threshold (tau = 0.4717)", 13);

// Left Image Card
s13.addShape(pres.ShapeType.rect, {
  x: 0.6, y: 1.15, w: 4.5, h: 3.85,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s13.addImage({
  path: "plots/ml/06_confusion_matrix_best_model.png",
  x: 0.8, y: 1.25, w: 4.1, h: 3.65
});

// Right Cards: Breakdown
s13.addShape(pres.ShapeType.rect, {
  x: 5.3, y: 1.15, w: 4.1, h: 1.8,
  fill: { color: COLOR_CARD_BG },
  line: { color: COLOR_BORDER, width: 1 }
});
s13.addText("Test Set Matrix Breakdown (N = 19,600)", {
  x: 5.5, y: 1.25, w: 3.7, h: 0.3,
  fontSize: 11.5, bold: true, color: COLOR_NAVY, fontFace: "Calibri"
});
s13.addText([
  { text: "True Negatives (TN): 18,655 (97.27% Specificity)\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9 } },
  { text: "Correctly filters out quiet non-breakout market sessions.\n", options: { color: "475569", fontSize: 8.5 } },
  { text: "True Positives (TP): 132 Breakouts Caught\n", options: { bold: true, color: COLOR_GREEN, fontSize: 9 } },
  { text: "Successfully anticipates real breakouts 24 hours in advance.\n", options: { color: "475569", fontSize: 8.5 } },
  { text: "False Positives: 523  |  False Negatives: 290", options: { color: "94A3B8", fontSize: 8.5 } }
], { x: 5.5, y: 1.55, w: 3.7, h: 1.35, fontFace: "Calibri" });

s13.addShape(pres.ShapeType.rect, {
  x: 5.3, y: 3.1, w: 4.1, h: 1.9,
  fill: { color: "EFF6FF" },
  line: { color: "BFDBFE", width: 1 }
});
s13.addText("Operational Utility for Quantitative Trading", {
  x: 5.5, y: 3.25, w: 3.7, h: 0.3,
  fontSize: 11.5, bold: true, color: COLOR_BLUE, fontFace: "Calibri"
});
s13.addText([
  { text: "1 in 5 Alerts is a Verified Breakout (20.15% Precision):\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9 } },
  { text: "Delivers a 9.4x signal lift over the 2.15% raw market base rate.\n\n", options: { color: "475569", fontSize: 8.5 } },
  { text: "Captures 31.28% of All Breakout Opportunities (Recall):\n", options: { bold: true, color: COLOR_NAVY, fontSize: 9 } },
  { text: "Allows systematic deployment of trading capital ahead of sharp multi-week equity advances.", options: { color: "475569", fontSize: 8.5 } }
], { x: 5.5, y: 3.55, w: 3.7, h: 1.35, fontFace: "Calibri" });


// ==============================================================
// SLIDE 14: CONCLUSION, FUTURE SCOPE & REPOSITORY
// ==============================================================
const s14 = setupSlide(pres, "Conclusion, Future Scope & Project Links", "Summary of findings, limitations, and public reproduction resources", 14);

const s14Cols = [
  {
    title: "1. Key Accomplishments",
    items: [
      "Demonstrated that quantitative ML can reliably predict pre-breakout accumulation regimes ahead of price expansion.",
      "GBM achieved top PR-AUC of 0.1721 (8.0x lift over random baseline) and F1 of 0.2451.",
      "Proved that resistance proximity and volume expansion drive over 83.7% of predictive power.",
      "Strict chronological splits and next-day lead targets eliminated lookahead leakage."
    ]
  },
  {
    title: "2. Limitations & Future Scope",
    items: [
      "Daily EOD Data: Misses intraday order book dynamics and execution slippage during fast market openings.",
      "Survivorship Bias: The 50 stocks represent current 2026 constituents.",
      "Future Work: Ingest news sentiment NLP and options volatility surfaces.",
      "Future Work: Implement LSTM/Transformer models and realistic backtesting with transaction costs."
    ]
  },
  {
    title: "3. Open-Source Reproduction",
    items: [
      "Public GitHub Repository: https://github.com/JonSnow42/Stock-Price-Breakout",
      "Full Codebase in R: 00_setup.R, 01_ml_models.R, 02_tuning.R, 03_visualization.R",
      "Reproducible Relational DB: SQLite stocks.db (63 MB)",
      "Academic Reports: Complete 25-page report (DOCX & PDF) in Final_Report/"
    ]
  }
];

s14Cols.forEach((col, idx) => {
  const xPos = 0.6 + idx * 3.0;
  s14.addShape(pres.ShapeType.rect, {
    x: xPos, y: 1.15, w: 2.8, h: 3.85,
    fill: { color: idx === 2 ? "F0FDF4" : COLOR_CARD_BG },
    line: { color: idx === 2 ? "86EFAC" : COLOR_BORDER, width: 1 }
  });
  s14.addText(col.title, {
    x: xPos + 0.15, y: 1.3, w: 2.5, h: 0.35,
    fontSize: 11, bold: true, color: idx === 2 ? COLOR_GREEN : COLOR_NAVY, fontFace: "Calibri"
  });
  const bulletTexts = col.items.map(item => ({ text: item, options: { bullet: true, fontSize: 8.8, color: "334155", paraSpaceAfter: 4 } }));
  s14.addText(bulletTexts, {
    x: xPos + 0.15, y: 1.7, w: 2.5, h: 3.15,
    fontFace: "Calibri", valign: "top"
  });
});

// Write Presentation
const outPptx = path.join(__dirname, "Final_Report", "Stock_Market_Breakout_Presentation.pptx");
pres.writeFile({ fileName: outPptx }).then(() => {
  console.log("Presentation created successfully at: " + outPptx);
});
