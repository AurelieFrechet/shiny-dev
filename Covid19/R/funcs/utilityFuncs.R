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
  while (! url.exists(testPath)) {
    testPath = paste0(basePath, dateFormat(delay), ".csv")
    delay = delay + 1
  } 
  todayPath = testPath
  print(todayPath)
  readr::read_csv(todayPath)
}

convertDataTS <- function(df, from = 5){
  nbCols <- ncol(df)
  df %>%
    pivot_longer(cols = from:nbCols)
}



# Find the continent of each Country_Region and save it as CountryContinent.csv
# library(countrycode)
# todayData %>% 
#   group_by(Country_Region) %>% 
#   summarize(totalConfirmed = sum(Confirmed),
#             totalDeath = sum(Deaths),
#             totalRecovered = sum(Recovered),
#             totalActive = sum(Active)) %>%
#   mutate(continent = countrycode(sourcevar = Country_Region,
#                                  origin = "country.name", 
#                                  destination = "continent"))
# 
# statsCountry[, c("Country_Region", "continent")] %>%
#   write.csv(, file = "data/CountryContinent.csv", row.names = FALSE)

