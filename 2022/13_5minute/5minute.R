world <- map_data("world")

library(ggplot2)

ggplot()+
  geom_polygon(data=world, aes(x=long, y=lat, group = group), 
               color = "grey80", fill = "#E69F00")+
  coord_fixed(1.3)+
    theme_minimal ()+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        rect = element_blank())+
  ggtitle("5 minute map") +
  theme (legend.title = element_text(size=10, family = "sans"))+ 
  theme (panel.grid.major = element_blank(),
         panel.grid.minor = element_blank())