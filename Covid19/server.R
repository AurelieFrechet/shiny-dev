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
