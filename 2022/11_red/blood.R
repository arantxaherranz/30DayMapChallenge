#source: https://worldpopulationreview.com/country-rankings/blood-type-by-country

blood <- read.csv("csvData.csv")
View(blood)

library(countrycode)
library(tidyverse)

#add iso2 code 
blood$iso2 <- countrycode(blood$country, origin= "country.name", destination = "iso2c", )
View(blood)

#creata world data and add iso2
world <- map_data("world")
world$iso2 <- countrycode (world$region, origin= "country.name", destination = "iso2c", )

#merge two dataset
type_blood <- blood %>%
  left_join(world, by= c("iso2" = "iso2"))
View(type_blood)

#create a world map
library(ggplot2)

ggplot()+
  geom_polygon(data=world, aes(x=long, y=lat, group = group))+
  coord_fixed(1.3)

ggplot(type_blood, aes(long, lat, group = group)) +
  coord_fixed(1.3)+
  geom_polygon(aes(fill = factor(oNeg)))+
  geom_polygon(data =type_blood, colour = "gray", fill = NA)+
  scale_fill_viridis_d(option = "rocket")+
  ggtitle("Blood type by Country") +
  theme_minimal ()+
  theme(axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          rect = element_blank())+
  theme(plot.title = element_text(size = 12, family = "sans", face="bold", hjust=0.5))+
  theme (legend.position = "bottom",
           legend.title = element_text(color = "black", size=10, family = "sans"),
           legend.text = element_text (color = "black", size =8, family = "sans"),
           legend.key.size = unit(0.3, 'cm'),
           legend.key.height = unit(0.3, 'cm'),
           legend.key.width = unit(0.3, 'cm'), 
  )+
  labs (fill = "0 negative",
          x="",
          y= "")+
  theme (panel.grid.major = element_blank(),
           panel.grid.minor = element_blank())


  


