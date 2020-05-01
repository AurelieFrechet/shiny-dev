evolutionUI <- tabsetPanel(
  tabPanel("Evolution per country"
    
  )
)
  

# data <- tidyr::pivot_longer(covidData, cols = 5:ncol(covidData))
# 
# france <- data %>% group_by(`Country/Region`, name) %>% 
#   filter(`Country/Region` == "France") %>%
# summarize(total = sum(value)) %>%
#   mutate(date = as.Date(name, format = "%m/%d/%y")) 
  
  
renderTweet <- function(){
  renderUI({
    tagList(
      tags$blockquote(class = "twitter-timeline",
                      tags$a(href = "https://twitter.com/cleris_mr/lists/covid-19?ref_src=twsrc%5Etfw")),
      tags$script('twttr.widgets.load(document.getElementById("tweet"));')
    )
  })
  
} 
