#source https://data.ny.gov/widgets/i9wp-a4ja

nyc_subway <- read.csv("network/NYC_Transit_Subway_Entrance_And_Exit_Data.csv")
View(nyc_subway)

library(tigris)
library(dplyr)
library(leaflet)
library(sp)
library(ggmap)
library(maptools)
library(broom)
library(httr)
library(rgdal)

ggplot(nyc_subway, aes(Station.Longitude, Station.Latitude, color = Route1))+
  geom_point()


nyc_map <- get_map(location = c(lon = -74.00, lat = 40.71), maptype = "terrain", zoom = 11)

leaflet() %>%
  addTiles() %>%
  setView(-74.00, 40.71, zoom = 12) %>%
  addProviderTiles("CartoDB.Positron")+
  ggplot(nyc_subway, aes(Station.Longitude, Station.Latitude, color = Route1))+
  geom_point()





