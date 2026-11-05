getwd()
list.files()


# Load the packages
library(DBI)
library(RSQLite)


# Create or connect to the database file
con <- dbConnect(
  RSQLite::SQLite(),
  dbname = "stocks.db"
)

# Check whether the connection works
dbIsValid(con)

# Load processed data
stock_data <- read.csv("processed_dataset.csv")

# Store dates consistently for SQL queries
stock_data$Date <- as.character(as.Date(stock_data$Date))

# Save dataset to SQLite
dbWriteTable(con, "stock_data", stock_data,
             overwrite = TRUE, row.names = FALSE)

dbExecute(con, "
CREATE TABLE IF NOT EXISTS model_results (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    model_name TEXT NOT NULL,
    target TEXT,
    roc_auc REAL,
    pr_auc REAL,
    precision REAL,
    recall REAL,
    f1_score REAL,
    experiment_date TEXT
)")

# Check tables
dbListTables(con)

# Confirm imported row count
dbGetQuery(con, "SELECT COUNT(*) AS total_rows FROM stock_data")

# View sample records
dbGetQuery(con, "SELECT * FROM stock_data LIMIT 5")

# Check records by ticker
dbGetQuery(con, "
    SELECT Ticker, COUNT(*) AS total_rows
    FROM stock_data
    GROUP BY Ticker
    ORDER BY Ticker
")

# Check target distribution
dbGetQuery(con, "
    SELECT Breakout, COUNT(*) AS total_rows
    FROM stock_data
    GROUP BY Breakout
")




dbDisconnect(con)
