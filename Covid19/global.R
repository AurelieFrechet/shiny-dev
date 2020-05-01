if (packageVersion("shiny") < 1.5) {
  source("R/funcs/utilityFuncs.R")
}

library(shiny)
library(shinydashboard)
library(lubridate)
library(RCurl)
library(leaflet)
library(highcharter)
library(dplyr)
library(xts)
library(countrycode)
library(treemap)

dataPathTS <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"
covidData <- readr::read_csv(dataPathTS)
commonColumns <- c("Province/State", "Country/Region", "Confirmed", 
                   "Deaths", "Recovered")
#dataUntilMay <- 
todayData <- readRDS("data/05-01-2020.RDS")

statsCountry <- todayData %>% 
  group_by(Country_Region) %>% 
  summarize(totalConfirmed = sum(Confirmed),
            totalDeath = sum(Deaths),
            totalRecovered = sum(Recovered),
            totalActive = sum(Active)) %>%
  mutate(continent = countrycode(sourcevar = Country_Region,
                                 origin = "country.name", 
                                 destination = "continent"))
