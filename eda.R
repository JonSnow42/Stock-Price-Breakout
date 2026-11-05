install.packages("ggplot2")
install.packages("corrplot")

library(ggplot2)
library(corrplot)

#raw data
raw <- read.csv("master_dataset.csv")

dim(raw)                                   # rows and columns
head(raw)                                  # first 6 rows
str(raw)                                   # column types
colSums(is.na(raw))                        # missing values per column
sum(duplicated(raw[, c("Ticker","Date")])) # duplicate rows
table(raw$Ticker)                          # rows per company
range(as.Date(raw$Date))                   # date range
summary(raw[, c("Open","High","Low","Close","Volume")])
aggregate(Close ~ Ticker, raw, mean)       # average price per company

stock_data <- read.csv("processed_dataset.csv")
stock_data$Date <- as.Date(stock_data$Date)

head(stock_data)
str(stock_data)

#1
ggplot(stock_data, aes(x = Date, y = Close)) +
  geom_line(color = "blue") +
  labs(title = "Closing Price Over Time",
       x = "Date",
       y = "Closing Price")


ggplot(stock_data, aes(x = Daily_Return)) +
  geom_histogram(fill = "green", bins = 30) +
  labs(title = "Distribution of Daily Returns",
       x = "Daily Return",
       y = "Frequency")


ggplot(subset(stock_data, Ticker == "AAPL"),
       aes(x = Date, y = Volume)) +
  geom_line(color = "red") +
  labs(title = "Trading Volume Over Time")



num_data <- stock_data[, c("Open", "High", "Low", "Close", "Volume")]

cor_matrix <- cor(num_data)

corrplot(cor_matrix, method = "color")




unique(stock_data$Ticker)
apple <- subset(stock_data, Ticker == "AAPL")
head(apple)


ggplot(apple, aes(x = Date)) +
  geom_line(aes(y = Close, color = "Close Price")) +
  geom_line(aes(y = SMA_20, color = "20-Day SMA")) +
  labs(title = "Closing Price vs 20-Day Moving Average",
       x = "Date",
       y = "Price")
