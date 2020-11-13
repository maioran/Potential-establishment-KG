####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script print the KG map
####################################################################################################

# set the kg map colors according to the climates that are relevant for the pest by setting the remaining as "white" i.e."#00000000"
climate.colors.pest <- climate.colors
climate.colors.pest[which(!rat$climate %in% pest.climates.list)] <- "#00000000"

# map coordinate range (x1, x2, y1, y2). Grid extent (xat, yat) is set directly in the levelplot function below
r <- crop(r, extent(map.coord.reg$x1,map.coord.reg$x2, map.coord.reg$y1, map.coord.reg$y2))

# modifying legend dimension if region is not global
if(i.region.to.plot != "Global")
{
  cex.legend <- 0.4
  kg.print.width = 16
  kg.print.heigth = 15
  
}else
{
  cex.legend <- 0.7
  kg.print.width = 30
  kg.print.heigth = 24
}
# 
# x.Petroskoi <- c(34.333333)
# y.Petroskoi <- c(61.783333)
# name <- c("Petroskoi")
# petroskoi.table <- data.frame(x.Petroskoi, y.Petroskoi, name)
# coordinates(petroskoi.table) <- ~ x.Petroskoi + y.Petroskoi
# 

if(i.region.to.plot != "Global")
{
  cex.legend <- 0.4
  
}else
{
  cex.legend <- 0.7
}

# setup file
jpeg(paste(output.dir,pest.name,"\\Koppen-Geiger\\",pest.name,"_KG_",period,"_", actual.date, ".jpg", sep=""),width = kg.print.width, height = kg.print.heigth, units="cm", res=800)
#detach("package:ggplot2", unload=TRUE)

kg.map <- rasterVis::levelplot(r, col.regions=climate.colors.pest, xlab="", ylab="", maxpixels = ncell(r),
                scales=list(x=list(limits=c(xmin(r), xmax(r)), at=seq(xmin(r), xmax(r), map.coord.reg$xat)),
                            y=list(limits=c(ymin(r), ymax(r)), at=seq(ymin(r), ymax(r), map.coord.reg$yat)), cex=0.6), 
                colorkey=list(space="top", tck=0, maxpixels=ncell(r), labels=list(cex=cex.legend)))
kg.map <- kg.map
          +latticeExtra::layer(sp.polygons(EPPO.admin.layer, lwd=0.5, col="grey"))
      
      + latticeExtra::layer(sp.polygons(world.select, lwd=0.5, col="black"))
      + latticeExtra::layer(sp.polygons(pz3, lwd=1, col="red"))
      + latticeExtra::layer(sp.polygons(pz2, lwd=1, col="red"))
      + latticeExtra::layer(sp.polygons(pz0, lwd=1, col="red"))
      + latticeExtra::layer(sp.points(petroskoi.table, cex=2, col="black", pch=19))
      + latticeExtra::layer(sp.points(petroskoi.table, cex=1, col="white", pch="P."))

print(kg.map)

dev.off()
# out=paste(kg.output.dir,pest.name,'_KG_', period,'_5m.pdf', sep='')
# dev.copy2pdf(file=out)


# Find the climate class for Vienna, Europe (or another location)
# lon=16.375; lat=48.210
# KG=r[cellFromXY(r, c(lon, lat))]
# print(KG)
# 
# # Output of ASCCI-Data (numbers correspond to the climate classes of the legend)
# r <- crop(r, extent(x1, x1+100, y1, y1+100)) # extent must be within the selected region
# z <- rasterToPoints(r, spatial=T); z <- spTransform(z, CRS=projection(r))
# z <- as.data.frame(z); print(length(t(z[1]))); z = subset(z, z[1]!=32); print(length(t(z[1])))
# names(z)=c('KG', 'lon', 'lat')
# pts <- data.frame(lat=format(z[2], digits=4), lon=format(z[3], digits=7), KG=format(z[1], digits=3))
# write.csv(pts, file=paste(kg.output.dir,'KG_', period,'_5m.csv', sep=''), row.names=F)
