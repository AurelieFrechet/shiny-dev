todayUI <- tabsetPanel(
  tabPanel(
    "Cases world map",
    sidebarLayout(
      sidebarPanel(
        width = 3,
        uiOutput("selectRegions")
      ),
      mainPanel(
        width = 9,
        leafletOutput("worldMap")
      )
    )
  ),
  tabPanel(
    "World Statistics",
    fluidRow(
      column(
        6,
        highchartOutput("boxPlotContinentsCases")
      ),
      column(
        6,
        highchartOutput("boxPlotContinentDeaths")
      )
    ),
    fluidRow(
      column(12, includeMarkdown("R/ui/byCountry.Rmd"))
    ),
    fluidRow(
      column(6,
      highchartOutput("treeMap")
    ),
    column(6, 
           highchartOutput("treemapRatio")
           )
  )
)
)
