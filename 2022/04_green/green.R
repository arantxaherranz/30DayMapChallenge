#source: https://ourworldindata.org/renewable-energy

green <- read.csv("renewable-share-energy.csv")
View(green)

library(tidyverse)
library(ggplot2)

world <- map_data("world")
world

#changing name to make a merge
colnames(green)[1] <- "region"

df <- merge(green, world, by = "region")
df

ggplot() +
  geom_map(
    data = world, map = world,
    aes(long, lat, map_id = region),
    color = "red", fill = "lightgray", size = .2
  )+
  geom_map(data= df, map = world,
           aes(fill= Renewables....equivalent.primary.energy., 
               map_id = region))+
  scale_fill_continuous(low="#87b972", high="#435c39", guide="colorbar")+ 
  scale_y_continuous(breaks=c()) +
  scale_x_continuous(breaks=c()) +
  labs(fill="%", title="How much of our primary energy comes from renewables?", 
       x="", y="",
       caption = "Data: Our World in Data | Author: Arantxa Herranz") +
  theme(panel.background = element_rect(fill = "white"), 
        plot.title = element_text(colour = "#435c39"))




