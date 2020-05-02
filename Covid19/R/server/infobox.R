displayBoxPlot <- function(input, output) {
  statsData <- filter(statsCountry, !is.na(continent))
  output$boxPlotContinentsCases <- renderHighchart({
    hcboxplot(x = log(statsData$totalConfirmed), var = statsData$continent) %>%
      hc_title(text = "Distribution of confirmed cases")
  })
  output$boxPlotContinentDeaths <-
    renderHighchart({
      hcboxplot(x = log(statsData$totalDeath), var = statsData$continent, 
                color = "red") %>%
        hc_title(text = "Distribution of Deaths")
    })
}

displayTreemap <- function(input, output){
  output$treeMap <- renderHighchart({
    hctreemap2(data = statsCountry, group_vars = c("Country_Region"), 
               size_var = "totalConfirmed", color_var = "totalConfirmed") %>%
      hc_title(text = "Number of confirmed cases by country")
  })
  
  statsRatio <- statsCountry %>%
    filter(totalConfirmed >=100) %>%
    mutate(deathRatio = totalDeath / totalConfirmed)
  output$treemapRatio <- renderHighchart({
    hctreemap2(data = statsRatio, group_vars = c("Country_Region"),
              size_var = "deathRatio") %>%
      hc_title(text = "Ratio of death (Deaths / Confirmed Cases)")
  })
}

updateMapRegion <- function(input, output){
  
  subsetRegions <- reactive(input$regionSelected)
  observeEvent(subsetRegions(), {
    if (length(subsetRegions() >1)) {
      dataSubsetted <- subset(todayData, Country_Region %in% subsetRegions())
      output$worldMap <- renderLeaflet({
        leaflet(data = dataSubsetted) %>%
          addTiles() %>%
          addMarkers(lng = ~Long_, lat = ~Lat, 
                     label = ~paste(Country_Region, Confirmed),
                     clusterOptions = markerClusterOptions())
      })
      
    } 
    
  })
  
}
