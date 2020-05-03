dateFormat <- function(minus = 0) {
  today <- Sys.Date() - minus
  currentDay <- substr(today, 9, 10)
  currentMonth <- substr(today, 6, 7)
  currentYear <- substr(today, 1, 4)
  
  paste(currentMonth, currentDay, currentYear, sep = "-")
}


retrieveTodayData <- function(delay = 1) {
  basePath <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/"
testPath <- paste0(basePath, dateFormat(), ".csv") 
if (url.exists(testPath)) {
  todayPath <- testPath
} else {
  todayPath = paste0(basePath, dateFormat(delay), ".csv")
}
print(todayPath)
readr::read_csv(todayPath)
}

# Find continent names from Country
# Read data taken from https://datahub.io/JohnSnowLabs/country-and-continent-codes-list#data

#continent <- read_csv("covid/data/continent.csv", na = "empty")

