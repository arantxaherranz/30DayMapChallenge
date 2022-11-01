#read the dataset in https://www.partow.net/miscellaneous/airportdatabase/index.html#Downloads

airport <- read.csv("points/gadb_country_declatlon.csv")
View(airport)

library(tidyverse)
library(sf)
library(mapview)

mapview(airport, xcol = "Longitude", ycol = "Latitude",
        crs = 4269, grid = FALSE)

