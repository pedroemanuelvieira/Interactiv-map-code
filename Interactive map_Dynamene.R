#Simple code to recreate the interactive map from the publication: 
#"Deep segregation in the open ocean: Macaronesia as an evolutionary hotspot for low dispersal marine invertebrates"
#From Vieira et al., Molecular Ecology

#Install if necessary the leaflet package, otherwise just load it with 
library(leaflet)

#In correct folder, just load the csv file with the co-ordinates(this file was simplified from Table S1)
point_data_Dynamene <- read.csv("Sites_Dynamene.csv", sep=";", header = TRUE)

#Set colors
factpal <- colorFactor(topo.colors(1000), point_data_Dynamene$Species)

#Creation of the interactive map 
leaflet(point_data_Dynamene) %>%
  addTiles() %>%
  addCircleMarkers(~long, ~lat, label=~as.character(Sites), #This allows to see the name of the site
                   radius = 5,
                   opacity = 10,
                   weight = 10,
                   color = ~factpal(Species), #Allows to observe by color the sampling locations of each species 
                   group = ~as.character(Species))%>%
  addLayersControl(#adds buttons to toogle on and off the target species
    overlayGroups = ~as.character(Species),
    options = layersControlOptions(collapsed = FALSE)
  )%>%
  addMiniMap(toggleDisplay = TRUE)%>% #adds mini-map 
  addScaleBar(options = list(imperial = FALSE)) %>% #adds scale bar in km
  addProviderTiles(providers$Hydda.Base)
