library(tidyverse)

# Get data from github
dd_concerts <- as_tibble(read.csv(file="https://raw.githubusercontent.com/asperanz/Dead-Dogs-Analytics-ShinyApp/main/Development/Shiny/data/Dead%20Dogs%20Live%20Concerts.csv", header=TRUE, sep=",", stringsAsFactors=FALSE))

# Get data locally from file system 
# dd_concerts <- as_tibble(read.csv("./data/Dead Dogs Live Concerts.csv", header=TRUE, sep=",", stringsAsFactors=FALSE))