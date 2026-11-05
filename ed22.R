# ============================================================
# Exploratory Data Analysis (R)
# ML-Based Stock Market Trend Analysis & Momentum Breakout Prediction
# Input: processed_dataset.csv
# Output: 6 PNG visualizations in plots/
# ============================================================

library(ggplot2)
library(dplyr)
library(readr)
library(tidyr)
library(scales)
library(corrplot)

df <- read_csv("/home/saurabh/Downloads/processed_dataset.csv", show_col_types = FALSE)
df$Date <- as.Date(df$Date)

theme_report <- theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(color = "grey40"),
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

dir.create("plots", showWarnings = FALSE)

# ------------------------------------------------------------
# 1. SECTOR PRICE TREND (indexed to 100) OVER 10 YEARS
# ------------------------------------------------------------
sector_cols <- grep("^Sector_", names(df), value = TRUE)
df$Sector <- apply(df[sector_cols], 1, function(r) {
  gsub("Sector_", "", sector_cols[which(r == 1)][1])
})

sector_trend <- df %>%
  group_by(Sector, Date) %>%
  summarise(AvgClose = mean(`Adj Close`), .groups = "drop") %>%
  arrange(Sector, Date) %>%
  group_by(Sector) %>%
  mutate(Indexed = AvgClose / first(AvgClose) * 100) %>%
  ungroup()

p1 <- ggplot(sector_trend, aes(x = Date, y = Indexed, color = Sector)) +
  geom_line(linewidth = 0.6) +
  labs(title = "Sector-Wise Price Trend (2016-2026)",
       subtitle = "Average adjusted close per sector, indexed to 100 at start",
       x = "Date", y = "Indexed Price (Base = 100)") +
  theme_report

ggsave("plots/01_sector_price_trend.png", p1, width = 10, height = 6, dpi = 150)

# ------------------------------------------------------------
# 2. DAILY RETURN DISTRIBUTION BY SECTOR (BOXPLOT -> VOLATILITY)
# ------------------------------------------------------------
p2 <- ggplot(df, aes(x = reorder(Sector, Daily_Return, FUN = function(x) sd(x, na.rm=TRUE)),
                      y = Daily_Return, fill = Sector)) +
  geom_boxplot(outlier.alpha = 0.08, outlier.size = 0.4) +
  coord_cartesian(ylim = c(-0.08, 0.08)) +
  labs(title = "Daily Return Distribution by Sector",
       subtitle = "Wider boxes/whiskers indicate higher volatility",
       x = "Sector", y = "Daily Return") +
  theme_report +
  theme(axis.text.x = element_text(angle = 40, hjust = 1), legend.position = "none")

ggsave("plots/02_return_distribution_by_sector.png", p2, width = 10, height = 6, dpi = 150)

# ------------------------------------------------------------
# 3. CORRELATION HEATMAP OF DAILY RETURNS ACROSS SECTORS
# ------------------------------------------------------------
sector_returns_wide <- df %>%
  group_by(Sector, Date) %>%
  summarise(AvgReturn = mean(Daily_Return, na.rm = TRUE), .groups = "drop") %>%
  pivot_wider(names_from = Sector, values_from = AvgReturn) %>%
  select(-Date)

corr_mat <- cor(sector_returns_wide, use = "pairwise.complete.obs")

png("plots/03_sector_correlation_heatmap.png", width = 1000, height = 900, res = 150)
corrplot(corr_mat, method = "color", type = "upper", order = "hclust",
         addCoef.col = "black", number.cex = 0.55, tl.col = "black",
         tl.srt = 45, tl.cex = 0.75,
         col = colorRampPalette(c("#B2182B", "white", "#2166AC"))(200),
         title = "Correlation of Average Daily Returns Across Sectors",
         mar = c(0,0,2,0))
dev.off()

# ------------------------------------------------------------
# 4. RSI DISTRIBUTION (MOMENTUM INDICATOR) WITH OVERBOUGHT/OVERSOLD ZONES
# ------------------------------------------------------------
p4 <- ggplot(df, aes(x = RSI_14)) +
  geom_histogram(binwidth = 2, fill = "#2166AC", alpha = 0.8, color = "white") +
  geom_vline(xintercept = 70, linetype = "dashed", color = "#B2182B", linewidth = 0.8) +
  geom_vline(xintercept = 30, linetype = "dashed", color = "#1A9850", linewidth = 0.8) +
  annotate("text", x = 73, y = Inf, label = "Overbought (70)", vjust = 2, hjust = 0,
           color = "#B2182B", size = 3.5) +
  annotate("text", x = 27, y = Inf, label = "Oversold (30)", vjust = 2, hjust = 1,
           color = "#1A9850", size = 3.5) +
  labs(title = "Distribution of 14-Day Relative Strength Index (RSI)",
       subtitle = "Momentum indicator used for breakout signal construction",
       x = "RSI (14-day)", y = "Frequency (ticker-days)") +
  theme_report

ggsave("plots/04_rsi_distribution.png", p4, width = 10, height = 6, dpi = 150)

# ------------------------------------------------------------
# 5. BREAKOUT EVENT FREQUENCY BY SECTOR
# ------------------------------------------------------------
breakout_summary <- df %>%
  group_by(Sector) %>%
  summarise(BreakoutRate = mean(Breakout) * 100, n = n()) %>%
  arrange(desc(BreakoutRate))

p5 <- ggplot(breakout_summary, aes(x = reorder(Sector, BreakoutRate), y = BreakoutRate, fill = Sector)) +
  geom_col() +
  coord_flip() +
  labs(title = "Momentum Breakout Frequency by Sector",
       subtitle = "% of ticker-days where price closed above the prior 20-day high on elevated volume",
       x = "Sector", y = "Breakout Rate (%)") +
  theme_report +
  theme(legend.position = "none")

ggsave("plots/05_breakout_frequency_by_sector.png", p5, width = 10, height = 6, dpi = 150)

# ------------------------------------------------------------
# 6. PRICE + MOVING AVERAGES + BREAKOUT POINTS FOR ONE SAMPLE STOCK
# ------------------------------------------------------------
sample_ticker <- "NVDA"
stock <- df %>% filter(Ticker == sample_ticker, Date >= as.Date("2023-01-01"))
breakout_points <- stock %>% filter(Breakout == 1)

p6 <- ggplot(stock, aes(x = Date)) +
  geom_line(aes(y = `Adj Close`, color = "Adj Close"), linewidth = 0.6) +
  geom_line(aes(y = SMA_20, color = "SMA 20"), linewidth = 0.5, linetype = "dashed") +
  geom_line(aes(y = SMA_50, color = "SMA 50"), linewidth = 0.5, linetype = "dotted") +
  geom_point(data = breakout_points, aes(y = `Adj Close`), color = "#B2182B", size = 1.6) +
  scale_color_manual(values = c("Adj Close" = "black", "SMA 20" = "#2166AC", "SMA 50" = "#1A9850")) +
  labs(title = paste0(sample_ticker, ": Price, Moving Averages & Detected Breakout Points"),
       subtitle = "Red dots = momentum breakout events (2023 onward)",
       x = "Date", y = "Adjusted Close (USD)", color = "") +
  theme_report

ggsave("plots/06_sample_stock_breakout.png", p6, width = 10, height = 6, dpi = 150)

cat("All 6 plots saved to plots/\n")
