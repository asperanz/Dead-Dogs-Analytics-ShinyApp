library(shiny)
library(shinythemes)
library(leaflet)


# Define UI for application that draws a histogram
# shinyUI(fluidPage(
# 
#     # Application title
#     titlePanel("Dead Dogs Live Concerts Map"),
# 
#     # Sidebar with a slider input for number of bins
#     sidebarLayout(
#         sidebarPanel(
#             selectizeInput("year",
#                            label = h4("Year of concert"),
#                            choices = unique(dd_concerts$year),
#                            selected = NULL,
#                            multiple = TRUE)),
#         mainPanel(
#             leafletOutput("map")
#         )
#     )
# ))

shinyUI(bootstrapPage(theme = "Sandstone.css",
    tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
    
    leafletOutput("map", width = "100%", height = "100%"),
    
    absolutePanel(top = 10, right = 10,
                  tags$h2("Dead Dogs Live Concerts Map"),
                  selectizeInput("year",
                                 label = h4("Year of concert"),
                                 choices = unique(dd_concerts$year),
                                 selected = NULL,
                                 multiple = TRUE))
    )
)
