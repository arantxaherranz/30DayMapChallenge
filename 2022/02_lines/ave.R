#read the Excel
library(readxl)

ave <- read_excel("lines/ave.xlsx")
View(ave)

lines <- read_excel("lines/lines_ave.xlsx")
View(lines)

#get mapSpain and codes
library(mapSpain)

prov <- esp_get_prov()
codelist <- mapSpain::esp_codelist
view(codelist)


ggplot(spain_com)+
  geom_sf() 

points(x = lines$Longitude, y = lines$Latitude, col = "slateblue", cex = 3, pch =20)

library(ggrepel)
library(maps)

sp <- map_data("world") %>% filter(region == "Spain")

ggplot(sp, aes(long, lat, group = group), fill = "grey", alpha =.3)+
  geom_polygon()+
  geom_point(lines, mapping = aes(Longitude, Latitude), inherit.aes = FALSE)+
  scale_x_continuous(limits = c(0, 15)) +
  scale_y_continuous(limits = c(0, 7))

  geom_text_repel( data=data %>% arrange(pop) %>% tail(10), aes(x=long, y=lat, label=name), size=5) +
  geom_point( data=data %>% arrange(pop) %>% tail(10), aes(x=long, y=lat), color="red", size=3) +
  theme_void() + ylim(50,59) + coord_map() +
  theme(legend.position="none")

library(ggmap)
library(ggplot2)
library(ggthemes)


spain_map <- get_stamenmap(
  bbox = c(left= -15.029, bottom = 32.064, right= 9.009, top= 46.210),
  maptype = "terrain",
  zoom = 6)

ggplot2::validate_mapping(mapping)

ggmap(spain_map)+
  geom_point(ave, 
             mapping = aes(Long...3, Lat...2),
             size = 2)
  scale_x_discrete()
  scale_y_discrete()
  theme_map()
  
  
  
  
  
  
  
  


