# 1. 利用地圖資料與natural earth data 上的 urban 資料，畫出類似地球夜景的效果
# 2. 利用大圓畫出航道

library(maps)
library(maptools)
library(geosphere)
library(plyr) 
library(ggplot2)
library(sp)
library(rgeos)
library(grid)
library(gridExtra)

# "http://www.stanford.edu/~cengel/cgi-bin/anthrospace/wp-content/uploads/2012/03/airports.csv"
airports <- read.csv("airports.csv", as.is=TRUE, header=TRUE)
# "http://www.stanford.edu/~cengel/cgi-bin/anthrospace/wp-content/uploads/2012/03/PEK-openflights-export-2012-03-19.csv"
flights <- read.csv("PEK-openflights-export-2012-03-19.csv", as.is=TRUE, header=TRUE)

# aggregate nunber of flights
flights.ag <- ddply(flights, c("From","To"), function(x) count(x$To))

# add latlons
flights.ll <- merge(flights.ag, airports, all.x=T, by.x="To", by.y="IATA")
beijing.ll <- c(airports$longitude[airports["IATA"]=="PEK"],airports$latitude[airports["IATA"]=="PEK"])

# calculate routes -- Dateline Break FALSE, otherwise we get a bump in the shifted ggplots
rts <- gcIntermediate(beijing.ll, flights.ll[,c('longitude', 'latitude')], 100, breakAtDateLine=FALSE, addStartEnd=TRUE, sp=TRUE)
rts.ff <- ggplot2:::fortify.SpatialLinesDataFrame(rts) # convert into something ggplot can plot

flights.ll$id <-as.character(c(1:nrow(flights.ll))) # that rts.ff$id is a char
gcircles <- merge(rts.ff, flights.ll, all.x=T, by="id") # join attributes, we keep them all, just in case


### Recenter ####

# center <- 115 # positive values only - US centered view is 260
center <- 260
get.long.centered <- function(long) {
  ifelse(long < center - 180, long + 360, long)
}

# shift coordinates to recenter great circles
gcircles$long.recenter <- get.long.centered(gcircles$long)

# shift coordinates to recenter worldmap
worldmap <- map_data ("world")
worldmap$long.recenter <- get.long.centered(worldmap$long)

### Function to regroup split lines and polygons
# takes dataframe, column with long and unique group variable, returns df with added column named group.regroup
RegroupElements <- function(df, longcol, idcol){  
  g <- rep(1, length(df[,longcol]))
  if (diff(range(df[,longcol])) > 300) {          # check if longitude within group differs more than 300 deg, ie if element was split
    d <- df[,longcol] > mean(range(df[,longcol])) # we use the mean to help us separate the extreme values
    g[!d] <- 1     # some marker for parts that stay in place (we cheat here a little, as we do not take into account concave polygons)
    g[d] <- 2      # parts that are moved
  }
  g <-  paste(df[, idcol], g, sep=".") # attach to id to create unique group variable for the dataset
  df$group.regroup <- g
  df
}

### Function to close regrouped polygons
# takes dataframe, checks if 1st and last longitude value are the same, if not, inserts first as last and reassigns order variable
ClosePolygons <- function(df, longcol, ordercol){
  if (df[1,longcol] != df[nrow(df),longcol]) {
    tmp <- df[1,]
    df <- rbind(df,tmp)
  }
  o <- c(1: nrow(df))  # rassign the order variable
  df[,ordercol] <- o
  df
}

# now regroup
gcircles.rg <- ddply(gcircles, .(id), RegroupElements, "long.recenter", "id")
worldmap.rg <- ddply(worldmap, .(group), RegroupElements, "long.recenter", "group")

# close polys
worldmap.cp <- ddply(worldmap.rg, .(group.regroup), ClosePolygons, "long.recenter", "order")  # use the new grouping var

# background <- readJPEG("world_night.jpg")
# g <- rasterGrob(background, interpolate=TRUE) 

urban <- readShapeSpatial("ne_10m_urban_areas.shp")
urban <- gSimplify(urban, tol = 0.05)
urbanareas <- fortify(urban)
urbanareas$long.centered <- get.long.centered(urbanareas$long)

ggplot() +
  # geom_polygon(size = 0.2, fill="transparent", colour = "grey65") +
  geom_polygon(mapping = aes(long.recenter,lat,group=group.regroup), size = 0.1, colour = "#090D2A", fill = "#090D2A", alpha = 1, data = worldmap.cp) +
  coord_equal() +
  theme(plot.margin = unit(c(0, 0, 0, 0), "lines"), 
        axis.text.x = element_blank(), axis.text.y = element_blank(), 
        axis.title.x = element_blank(), axis.title.y = element_blank(), 
        legend.text = element_text(size = rel(0.8)), legend.title = element_blank(), 
        strip.text = element_text(size = rel(0.8)), complete = TRUE,
        panel.background = element_rect(fill = "#00001C", colour = "#00001C"), 
        legend.position = "none") +
  geom_point(mapping = aes(long.centered, lat), data = urbanareas, colour = "white", shape = 46) +
  geom_line(aes(long.recenter,lat,group=group.regroup, color=freq, alpha=freq), size=0.4, data= gcircles.rg) +        # set transparency here
  scale_colour_gradient(low="#fafafa", high="#EE0000") +                                                              # set color gradient here
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  labs(x = NULL, y = NULL)
