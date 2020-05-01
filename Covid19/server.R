if (packageVersion("shiny") < 1.5) {
  source("R/server/infobox.R")
}
shinyServer(
  function(input, output, session) {
    
    output$worldMap <- renderLeaflet({
      todayData %>%
        filter(Confirmed > 0) %>%
        leaflet(width = 2500, height = 3000) %>%
        addTiles() %>% 
        setView(lng = 48.7083738, lat = -4.9197415, zoom = 2) %>%

        addCircles(lng = ~Long_, lat = ~Lat, weight = 0.5,
                   radius = ~Confirmed * 3, popup = ~Country_Region, 
                   label = ~paste("Confirmed cases", Confirmed)) %>%
        addMarkers(lng = ~Long_, lat = ~Lat, label = ~Province_State,
                   clusterOptions = markerClusterOptions())
  
        
    })
    output$selectRegions <- renderUI({
      selectizeInput("regionSelected", label = "Select Regions",
                     choices = unique(todayData$Country_Region), 
                     selected = NULL, multiple = TRUE)
    })
    displayBoxPlot(input, output)
    displayTreemap(input, output)
    updateMapRegion(input, output)
    
    output$tweets <- renderTweet()
    
    
  }
)
