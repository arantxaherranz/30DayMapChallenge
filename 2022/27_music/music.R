
library(tidyverse)
library(ggplot2)

world <- map_data("world")
world

#source: https://github.com/Spijkervet/eurovision-dataset

eurovision <- read.csv("contestants.csv")
View(eurovision)

library(tidyr)
library(dplyr)

winners <- eurovision %>% filter(place_final == 1)
View(winners)

total_winner <- winners[, -c(6:9)]
View(total_winner)
total_winner <- total_winner[, -c(8:15)]

by_country <- group_by(winners, to_country) %>% 
  summarise(sum(place_final), n = n())
View(by_country)

eu_color <- c("#764FFF", "#F793FF", "#91FA41", "#CCB990", "#48FAB4",
              "#FADE41", "#F5F4FF")



#plot european map

library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(rgeos)
library(sp)

library(giscoR)

# Obtenemos todos los países y transformamos al mismo CRS
paises <- gisco_get_countries(resolution = 20) %>%
  st_transform(3035)

# Gráfico
choro_adv <- ggplot() +
  # Primera capa con todos los países
  geom_sf(data = paises, fill = "grey80", color = NA) +
  # Establece límites
  xlim(c(2200000, 7150000)) +
  ylim(c(1380000, 5500000))

choro_adv

choro_adv +
  geom_sf(by_country, aes(fill = sum(place_final)), color = NA)






