###########################################################################################
## This R code was modified by EFSA starting from the source code published by the 
## Climate Change & Infectious Diseases Group, Institute for Veterinary Public Health
## Vetmeduni Vienna, Austria, and freely available at 
## http://koeppen-geiger.vu-wien.ac.at/present.htm
## 
## The heading below is the one present in the original R source code:
## 
## R source code to read and visualize Koppen-Geiger fields (Version of 27 December 2019)                                                                                    
##
## Climate classification after Kottek et al. (2006), downscaling after Rubel et al. (2017)
##
## Kottek, M., J. Grieser, C. Beck, B. Rudolf, and F. Rubel, 2006: World Map of the  
## Koppen-Geiger climate classification updated. Meteorol. Z., 15, 259-263.
##
## Rubel, F., K. Brugger, K. Haslinger, and I. Auer, 2017: The climate of the 
## European Alps: Shift of very high resolution Köppen-Geiger climate zones 1800-2100. 
## Meteorol. Z., DOI 10.1127/metz/2016/0816.
##
## (C) Climate Change & Infectious Diseases Group, Institute for Veterinary Public Health
##     Vetmeduni Vienna, Austria
##
###########################################################################################

# required packages 
#library(raster)
#library(rasterVis)
library(rworldxtra)
#library(rgdal)
library(ggplot2)
library(tmap)

# Read raster files
period <- "1986-2010"
r <- raster::raster(paste(kg.map.dir, 'KG_', period, '.grd', sep=''))

# Color palette for climate classification
climate.colors=c("#960000", "#FF0000", "#FF6E6E", "#FFCCCC", "#CC8D14", "#CCAA54", "#FFCC00", "#FFFF64", "#007800", "#005000", "#003200", "#96FF00", "#00D700", "#00AA00", "#BEBE00", "#8C8C00", "#5A5A00", "#550055", "#820082", "#C800C8", "#FF6EFF", "#646464", "#8C8C8C", "#BEBEBE", "#E6E6E6", "#6E28B4", "#B464FA", "#C89BFA", "#C8C8FF", "#6496FF", "#64FFFF", "#F5FFFF")

# Legend must correspond to all climate classes, insert placeholders
r0 <- r[1:32]; 
r[1:32] <- seq(1,32,1)

# Converts raster field to categorical data
r <- raster::ratify(r); 
rat <- levels(r)[[1]]

# Legend is always drawn in alphabetic order
rat$climate <- c('Af', 'Am', 'As', 'Aw', 'BSh', 'BSk', 'BWh', 'BWk', 'Cfa', 'Cfb','Cfc', 'Csa', 'Csb', 'Csc', 'Cwa','Cwb', 'Cwc', 'Dfa', 'Dfb', 'Dfc','Dfd', 'Dsa', 'Dsb', 'Dsc', 'Dsd','Dwa', 'Dwb', 'Dwc', 'Dwd', 'EF','ET', 'Ocean')
# climate.colors.pest <- climate.colors
# climate.colors.pest[which(!rat$climate %in% climates.list)] <- "#00000000"

rat$colors  <- climate.colors
# Remove the placeholders
r[1:32] <- r0; 
levels(r) <- rat
#writeRaster(r, paste(kg.output.dir,'testmapEU.tif', sep=''), format="GTiff", overwrite=TRUE)

# # map coordinate range (x1, x2, y1, y2) and grid extent (xat, yat)
# x1  <- map.coord.reg$x1
# x2  <- map.coord.reg$x2
# y1  <- map.coord.reg$y1
# y2  <- map.coord.reg$y2
# xat <- map.coord.reg$xat
# yat <- map.coord.reg$yat
# 
# r <- crop(r, extent(x1, x2, y1, y2))
crs(r) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0" 