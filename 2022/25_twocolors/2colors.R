remotes::install_github("jespermaag/gganatogram")
library(gganatogram)
library(gridExtra)

organPlot <- data.frame(organ = c("heart", "leukocyte", "nerve", "brain",
                                  "liver", "stomach", "colon"),
                        type = c("circulation", "circulation",
                                 "nervous system", "nervous system", "digestion", "digestion",
                                 "digestion"),
                        colour = c("red", "red", "purple", "purple", "orange",
                                   "orange", "orange"),
                        value = c(10, 5, 1, 8, 2, 5, 5),
                        stringsAsFactors=FALSE)


organPlot %>%
  dplyr::filter(type %in% c('circulation', 'nervous system')) %>%
  gganatogram(fillOutline='white', organism='human',
              sex='female', fill="colour") +
  theme_void() +
  scale_fill_gradient(low = "white", high = "red")+
  ggtitle("Circulation and Nervous System")