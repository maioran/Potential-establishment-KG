climate.colors.pest <- climate.colors
climate.colors.pest[which(!rat$climate %in% pest.climates.list)] <- "#00000000"

# map coordinate range (x1, x2, y1, y2) and grid extent (xat, yat)
x1  <- map.coord.reg$x1
x2  <- map.coord.reg$x2
y1  <- map.coord.reg$y1
y2  <- map.coord.reg$y2
xat <- map.coord.reg$xat
yat <- map.coord.reg$yat

r <- crop(r, extent(x1, x2, y1, y2))

# protected zones at different NUTS levels
if(3 %in% protected.zones$nuts)
{
  # Protected zone areas NUTS3
  pz3 <- subset(EU.NUTS3.layer, NUTS_ID %in% protected.zones$NUTS_CODE)

}
if(2 %in% protected.zones$nuts)
{
  # Protected zone areas NUTS3
  pz2 <- subset(EU.NUTS2.layer, NUTS_ID %in% protected.zones$NUTS_CODE)
  
}
if(0 %in% protected.zones$nuts)
{
  # Protected zone areas NUTS3
  pz0 <- subset(EU.NUTS0.layer, NUTS_ID %in% protected.zones$NUTS_CODE)
  
}

# regions to remove (sardinia)
sardinia <- subset(EU.NUTS2.layer, NUTS_ID == "ITG2")

# modifying legend dimension if region is not global
if(region.to.plot != "Global")
{
  cex.legend <- 0.4
  
}else
{
  cex.legend <- 0.7
}

x.Petroskoi <- c(34.333333)
y.Petroskoi <- c(61.783333)
name <- c("Petroskoi")
petroskoi.table <- data.frame(x.Petroskoi, y.Petroskoi, name)
coordinates(petroskoi.table) <- ~ x.Petroskoi + y.Petroskoi

# setup file
jpeg(paste(output.dir,pest.name,"\\Koppen-Geiger\\",pest.name,"_KG_",period,"_", actual.date, ".jpg", sep=""),width = 16, height = 15, units="cm", res=800)
#detach("package:ggplot2", unload=TRUE)
print(rasterVis::levelplot(r, col.regions=climate.colors.pest, xlab="", ylab="", maxpixels = ncell(r),
                scales=list(x=list(limits=c(xmin(r), xmax(r)), at=seq(xmin(r), xmax(r), xat)),
                            y=list(limits=c(ymin(r), ymax(r)), at=seq(ymin(r), ymax(r), yat)), cex=0.6), 
                colorkey=list(space="top", tck=0, maxpixels=ncell(r), labels=list(cex=cex.legend)))
      + latticeExtra::layer(sp.polygons(EPPO.admin.layer, lwd=0.5, col="grey"))
      + latticeExtra::layer(sp.polygons(world.select, lwd=0.5, col="black"))
      + latticeExtra::layer(sp.polygons(pz3, lwd=1, col="red"))
      + latticeExtra::layer(sp.polygons(pz2, lwd=1, col="red"))
      + latticeExtra::layer(sp.polygons(pz0, lwd=1, col="red"))
      + latticeExtra::layer(sp.polygons(sardinia, lwd=0.5, col="grey"))
      + latticeExtra::layer(sp.points(petroskoi.table, cex=2, col="black", pch=19))
      + latticeExtra::layer(sp.points(petroskoi.table, cex=1, col="white", pch="P.")))

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
