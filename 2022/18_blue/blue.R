library(ggplot2)
library(readxl)

#read data and create dataframe
data_eu <- read.csv("yth_demo_030__custom_3133573_page_linear.csv")
View(data_eu)

#countries name

library(eurostat)
codes_eu <- eurostat::eu_countries
View(codes_eu)

#change the column name to make a inner join
colnames(data_eu)[6] <- "code"

View(data_eu)

df <- merge(data_eu, codes_eu)
View(df)

#plot a map

library(tidyverse)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(dplyr)

#download geospatial data from GISCo

data_geo <- get_eurostat_geospatial(resolution = "60", year = 2021)
View(data_geo)

#merge with data

colnames(df)[1] <- "geo"
eu_map2 <- inner_join(data_geo, df, by = "geo")
View(eu_map2)
eu_map2 


library(ggrepel)
#plot

p <- ggplot(eu_map2, aes(fill = OBS_VALUE))+
  geom_sf(size = 0.1)+
  scale_fill_viridis_c(option = "mako",
                       direction = -1)+ #reverse order
  labs(title = "Estimated average age \nof young people leaving \nthe parental household",
       caption = "Data: European Comision | Author: Arantxa Herranz")+
  theme_void()+
  theme(legend.position = c(.2, .8),
        legend.title = element_blank(),
        text = element_text(size = 16,
                            family = "Ubuntu"))+
  coord_sf(xlim = c(-12, 44), ylim = c(35,70))

p

p1 <- ggplot(by_gender, aes(fill = OBS_VALUE))+
  geom_sf(size = 0.1)+
  scale_fill_viridis_c(option = "mako",
                       direction = -1)+ #reverse order
  facet_wrap(~by_gender$sex,
             ncol = 1)+
  labs(title = "Estimated average age of young people leaving the parental household",
       caption = "Data: European Comision | Author: Arantxa Herranz")+
  theme_void()+
  theme(legend.position = "right",
        legend.title = element_blank(),
        text = element_text(size = 16,
                            family = "Ubuntu"))+
  coord_sf(xlim = c(-12, 44), ylim = c(35,70))

p1


p2 <- ggplot(by_gender, aes(fill = OBS_VALUE))+
  geom_sf(size = 0.1)+
  scale_fill_viridis_c(option = "mako",
                       direction = -1)+ #reverse order
  facet_grid(by_gender$sex ~ .)+
  labs(title = "Estimated average age of young people \nleaving the parental household",
       caption = "Data: European Comision | Author: Arantxa Herranz")+
  theme_void()+
  theme(legend.position = "top",
        legend.title = element_blank(),
        strip.text.y = element_text(),
        text = element_text(size = 13,
                            family = "Ubuntu"))+
  coord_sf(xlim = c(-12, 44), ylim = c(35,70))

ggsave("youth_emancipation.jpeg",
       width = 800,
       height = 1000,
       units = "px",
       dpi = 300)


#show data in map
p2+
  ggrepel::geom_label_repel(
    aes(label = OBS_VALUE, geometry = geometry),
    stat = "sf_coordinates",
    min.segment.length = 0,
    label.size = NA, # with this we 
    color = "white"
  )

ggsave("by_sex.jpeg",
       width = 800,
       height = 1000,
       units = "px",
       dpi = 300)


#add image
library(cowplot)
library(magick)

theme_set(theme_cowplot())

ggdraw()+
  draw_image("https://img.freepik.com/vector-gratis/concepto-mudanza-casa-diseno-plano-camion_23-2148665508.jpg",
             x = .3, y =.4, scale = .3)+
  draw_plot(p)


