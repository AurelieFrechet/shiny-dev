if (packageVersion("shiny") < 1.5) {
  source("R/server/infobox.R")
  source("R/server/interactiveMaps.R")
}
shinyServer(
  function(input, output, session) {
    
    variableStatistic <- reactive({
      switch(input$dataSource,
             "Confirmed" = "Confirmed",
             "Deaths" = "Deaths",
             "Recovered" = "Recovered"
      )
    })
    
    output$lastUpdate <- renderUI({
      div(class = "alert alert-warning",
          paste("The last update of the dataset was on ", 
                todayData$Last_Update[1]))
    })
    
    observeEvent(input$dataSource, {
      
      output$worldMap <- renderLeaflet({
        baseMap(todayData, input$dataSource)
      })
      output$selectRegions <- renderUI({
        selectizeInput("regionSelected", label = "Select Regions",
                       choices = unique(todayData$Country_Region), 
                       selected = NULL, multiple = TRUE)
      })
      
      observeEvent(input$regionSelected, {
        subsettedData <- reactive({
          subset(todayData, Country_Region %in% input$regionSelected)
        })
        output$worldMap <- renderLeaflet({
          if (is.null(input$regionSelected)) {
            baseMap(todayData, input$dataSource)
          } else {
            baseMap(subsettedData(), input$dataSource)
          }
        })
        
      })
      
      observe({
        click = input$worldMap_shape_click
        subData <- subset(todayData, Combined_Key == input$worldMap_shape_click$id)
        subLon <- subData$Long_
        subLat <- subData$Lat
        subCountry <- subData$Country_Region
        
        if (is.null(click))
          return()
        else {
          output$displayInfo <- renderUI({
            div(class = "alert alert-success",
                h3("Information", class = "alert-heading"),
                p(paste("Longitude : ", subLon)),
                p(paste("Latitude : ", subLat)),
                p(paste("Country : ", subCountry)),
                p(paste("Province / State : ", subData$Province_State)),
                p(paste("Number of confirmed cases : ", subData$Confirmed)),
                p(paste("Number of deaths : ", subData$Deaths)),
                p(paste("Number of recovery : ", subData$Recovered)),
                p(paste("% Deaths : ", round(100*subData$Deaths/subData$Confirmed, 2))))
          })
        }
      })
      
      observeEvent(input$clearMap, {
        output$selectRegions <- renderUI({
          selectizeInput("regionSelected", label = "Select Regions",
                         choices = unique(todayData$Country_Region), 
                         selected = NULL, multiple = TRUE) })
        renderLeaflet({
          baseMap(todayData)
        })
      })
      
    })
    
    displayBoxPlot(input, output)
    displayTreemap(input, output)
    
    output$tweets <- renderTweet()
    
    
  }
)
