
library(ggplot2)
library(mapSpain)
library(tidyverse)

#Average surface area of family dwellings (m²)
#Basque Country
# Source: https://datos.gob.es/en/catalogo/a16003011-indicadores-municipales-de-sostenibilidad-superficie-media-de-las-viviendas-familiares-m1

homes <- read.csv("polygons/euskadi.csv", colClasses=c("Código.municipio"="character"))
view(homes)

mean_houses <- mean(homes$X2020)
mean_houses <- round(mean_houses)
mean_houses

#selecting Basque Country (Euskadi) from mapSpain
euskadi <- esp_get_ccaa("Euskadi")
euskadi <- esp_get_munic(
  year = "2019",
  epsg = "4258",
  cache = TRUE,
  update_cache = FALSE,
  cache_dir = NULL,
  verbose = FALSE,
  region = "Euskadi",
  moveCAN = TRUE)

euskadi

#merge with homes dataset
#changing col name previously 

colnames(homes)[c(1)] <- c("LAU_CODE")
head(homes)

chocos <- euskadi%>% left_join(homes, by = c("LAU_CODE"))
view(chocos)

#map

fig1 <- ggplot() + 
  geom_sf(data = chocos, mapping = aes(fill = X2020), alpha= 0.9, color= NA) +
  scale_fill_gradientn("Square meters",
                       colors = hcl.colors(100, "spectral"),
                       n.breaks = 10,
                       labels = scales::label_comma(),
                       guide = guide_legend()
  ) + 
  theme(legend.title = element_text(colour="black", size=12, face="bold"),
        legend.position = "bottom",
        panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.background = element_rect(fill = "white"),
        text = element_text(family = "Ubuntu")) +
  labs(title = "Euskadi's average surface of family dwellings", 
       subtitle = "Source: Basque Government (2020)",
       caption = "Author: Arantxa Herranz")+
  theme(plot.title = element_text(hjust = 0.5))

#map of Spain /by communities (ccaa)

spain_com <- esp_get_ccaa()

fig2 <- ggplot(spain_com)+
  geom_sf(fill = "antiquewhite")+
  theme(panel.background = element_rect(fill = "white"))

#combine two fig

library(ggpubr)

ggarrange(fig1, fig2,
          nrow = 1,
          ncol = 2,
          widths = c(2, 0.7))

library(patchwork)

fig1 + inset_element(fig2,
                     left = 0.9, bottom = .3, right = .7, top = .4)

