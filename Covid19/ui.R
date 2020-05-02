if (packageVersion("shiny") < 1.5) {
  source("R/ui/todayUI.R")
  source("R/ui/evolutionUI.R")
}

tagList(
  tags$head(
    tags$script(async = NA, src = "https://platform.twitter.com/widgets.js"),
    tags$link(rel = "stylesheets", href = "www/styles.css")
  ),
  navbarPage("Covid-19",
             theme = "styles.css",
    tabPanel("Today !",
             todayUI),
    tabPanel("Evolution",
             evolutionUI),
    tabPanel("About the Data"),
    tabPanel("News Feeds",
             uiOutput("tweets"))
  )
)