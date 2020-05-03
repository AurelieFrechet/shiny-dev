


  baseMap <- function(data, variable){
      data["selected"] = data[, variable] 
      data %>%
      subset(selected > 0) %>%
        leaflet(width = 1200, height = 800) %>% 
      #setView(lng = 8.2481203, lat = -28.069184, zoom = 2) %>%
      # https://www.google.fr/maps/@38.2481203,-28.069184,3.53z
        addTiles() %>%
        addCircles(lng = ~Long_, lat = ~Lat, weight = 4,
                   radius = ~ selected * 5, popup = ~Combined_Key, 
                   label = ~paste(Combined_Key, selected))
  }
  