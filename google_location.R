library(jsonlite)
library(tidyverse)
library(leaflet)
library(htmlwidgets)
library(ggplot2)

data1=read_json(path="",simplifyVector=TRUE)
data1<-data.frame(data1$locations)

data<-data1 %>% mutate(lat=latitudeE7/1e7) %>% mutate(lon=longitudeE7/1e7) %>% select(lat, lon) 

samp<-sample(1e4)
subdata<-data[samp,]

map<-leaflet() %>% addTiles() %>% addCircleMarkers(subdata$lon,subdata$lat,radius=7,color='r')
saveWidget(map, file="subset.html")

noClusters<-150
clus <- kmeans(as.matrix(data),noClusters, iter.max=30)

map_centers<- leaflet() %>% addTiles() %>% addCircleMarkers(clus$centers[,2],clus$centers[,1], radius=2,color='b')

saveWidget(map_centers, file="clustered.html")