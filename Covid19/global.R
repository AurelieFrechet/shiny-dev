if (packageVersion("shiny") < 1.5) {
  source("R/funcs/utilityFuncs.R")
}

library(shiny)
library(shinydashboard)
library(lubridate)
library(RCurl)
library(leaflet)
library(highcharter)
library(dplyr) ; library(tidyr)
library(xts)
library(countrycode)
library(treemap)

basePath <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/"
dataLinks <- list(confirmed_global = "time_series_covid19_confirmed_global.csv",
                  death_global = "time_series_covid19_deaths_global.csv",
                  recovered_global = "time_series_covid19_recovered_global.csv")

readToWide <- function(dataLink){
  readr::read_csv(paste0(basePath, dataLink)) %>%
    convertDataTS() %>%
    rename(date = name) %>%
    mutate(date = as.Date(date, format = "%m/%d/%y"))
}

confirmedGlobal <- readToWide(dataLinks$confirmed_global)
recoveredGlobal <- readToWide(dataLinks$recovered_global)
deathGlobal <- readToWide(dataLinks$death_global)

todayData <- retrieveTodayData()

CountryContinent <- read.csv("data/CountryContinent.csv", stringsAsFactors = FALSE)

mapCountryToContinent <- function(country){
  continentMapper <- setNames(CountryContinent$Country_Region, 
                              CountryContinent$continent)
  names(continentMapper[country == continentMapper])
}

mapCountryToContinent <- Vectorize(mapCountryToContinent)
statsCountry <- todayData %>% 
  group_by(Country_Region) %>% 
  summarize(totalConfirmed = sum(Confirmed),
            totalDeath = sum(Deaths),
            totalRecovered = sum(Recovered),
            totalActive = sum(Active)) %>%
  mutate(continent = countrycode(sourcevar = Country_Region,
                                 origin = "country.name", 
                                 destination = "continent"))

#  exTS <- deathGlobal %>%
#    filter(`Country/Region` == "France") %>%
#    xts(x = .$value, order.by = .$date) 
#  
#    highchart(type = "stock") %>%
#      hc_add_series(exTS, type = "line")
#    
# 
# treemap(statsCountry, index = c("continent", "Country_Region"), 
#         vSize = "totalConfirmed", )