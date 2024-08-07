library(shiny)
library(leaflet.extras)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # new column for the popup label    
  dd_concerts <- dd_concerts %>% 
    mutate(popupcontent = paste("<b>Concert:</b>", concert, "<br>",
                                "<b>Location:</b>", location, "<br>",
                                "<b>Date:</b>", dd_concerts$date,
                                playlist))
  
  filteredData <- reactive({
    
      if (is.null(input$year)) {
        dd_concerts
      } else {
        dd_concerts %>%
          filter(year %in% input$year)
      }
    
  })
  
    output$map <- renderLeaflet({
      
        leaflet(filteredData()) %>%
        # Base groups
        addProviderTiles(providers$CartoDB.Positron, group = "Clear") %>%
        addProviderTiles(providers$OpenStreetMap.DE, group = "Colour") %>%
        addProviderTiles(providers$Stadia.StamenToner, group = "Black and white") %>%
        addProviderTiles(providers$CartoDB.DarkMatter, group = "Dark") %>%
        # Overlay groups
        addMarkers(~longitude 
                  ,~latitude
                  ,label = ~concert
                  ,popup = ~popupcontent
                  ,clusterOptions = markerClusterOptions()
                  ) %>% 
        addHeatmap(lng = ~longitude 
                  ,lat = ~latitude
                  ,blur = 20
                  ,max = 0.05
                  ,radius = 15
                  # ,gradient = "Spectral"
                  ) %>%
        addMiniMap(tiles = providers$Esri.WorldStreetMap
                  ,minimized = FALSE
                  ,position = "bottomleft"
                  ) %>%
        addLayersControl(baseGroups = c("Clear", "Colour", "Black and white", "Dark")
                        ,position = "bottomright")
      
    })
    
    
    observe({
      
      leafletProxy("map", data = filteredData()) %>%
        clearMarkers() %>%
        # Overlay groups
        addMarkers(~longitude 
                  ,~latitude
                  ,label = ~concert
                  ,popup = ~popupcontent
                  ,clusterOptions = markerClusterOptions()
                  ) %>% 
        addHeatmap(lng = ~longitude 
                   ,lat = ~latitude
                   ,blur = 20
                   ,max = 0.05
                   ,radius = 15
                   # ,gradient = "Spectral"
                  ) %>% 
        addMiniMap(tiles = providers$Esri.WorldStreetMap
                   ,minimized = FALSE
                   ,position = "bottomleft"
                  ) %>%
        addLayersControl(baseGroups = c("Clear", "Colour", "Black and white", "Dark")
                        ,position = "topleft")
      
    })
})
