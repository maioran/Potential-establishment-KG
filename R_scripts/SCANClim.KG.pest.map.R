####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script print the KG map
####################################################################################################

# set the kg map colors according to the climates that are relevant for the pest by setting the remaining as "white" i.e."#00000000"
climate.colors.pest <- climate.colors
climate.colors.pest[which(!levels(r)[[1]]$climate %in% pest.climates.list)] <- "#00000000"

# map coordinate range (x1, x2, y1, y2). 
# Note that grid extent (xat, yat) is set directly in the rasterVis::levelplot function few lines below
coordinate.table.sub <- coordinate.table[which(coordinate.table$Region==i.region.to.plot),]
r.pest <- raster::crop(r, extent(coordinate.table.sub$x1,
                                 coordinate.table.sub$x2, 
                                 coordinate.table.sub$y1, 
                                 coordinate.table.sub$y2))

# set legend dimension and position 
cex.legend   <- coordinate.table.sub$cex.legend
print.width  <- coordinate.table.sub$print.width
print.heigth <- coordinate.table.sub$print.heigth
efsa.x       <- coordinate.table.sub$efsa.x
efsa.y       <- coordinate.table.sub$efsa.y
# set grid extent parameters
xat          <- coordinate.table.sub$xat
yat          <- coordinate.table.sub$yat

# setup file
jpeg(paste(output.dir,"\\Koppen-Geiger\\",i.region.to.plot,"_",pest.name,"_KG_",period,"_", actual.date, ".jpg", sep=""),width = print.width, height = print.heigth, units="cm", res=800)
#detach("package:ggplot2", unload=TRUE)

kg.map <- rasterVis::levelplot(r.pest, col.regions=climate.colors.pest, xlab="", ylab="", maxpixels = ncell(r.pest),
                               scales=list(x=list(limits=c(xmin(r.pest), xmax(r.pest)), at=seq(xmin(r.pest), xmax(r.pest), xat)),
                                           y=list(limits=c(ymin(r.pest), ymax(r.pest)), at=seq(ymin(r.pest), ymax(r.pest), yat)), cex=0.6), 
                               colorkey=list(labels=list(labels=r.pest@data@attributes[[1]]$climate, cex=cex.legend), space="top", tck=0, maxpixels=ncell(r.pest)))
kg.map <- kg.map + latticeExtra::layer(panel.text(efsa.x, efsa.y, paste("\uA9 EFSA\n",format(actual.date, "%d %B %Y"),sep=""), adj=0, cex=0.7))
kg.map <- kg.map + latticeExtra::layer(sp.polygons(EPPO.admin.layer, lwd=0.5, col="dark grey"), data=list(EPPO.admin.layer=EPPO.admin.layer))

if(distr.table==TRUE)
{
  for(pest.layer in observed.layer.list)
  {# pest.layer <- observed.layer.list[[1]]
    kg.map <- kg.map + latticeExtra::layer(sp.polygons(pest.layer, lwd=0.5, col="black"), data=list(pest.layer=pest.layer))
  }
}


if(!is.na(points.layer))
{
  kg.map <- kg.map + latticeExtra::layer(sp.points(points.layer, cex=0.5, col="black", lwd=0.5, pch=21, fill="red", ), data=list(points.layer=points.layer))
}
if(exists("pz.layer.list"))
{
  for(pz.layer in pz.layer.list)
  {# pest.layer <- pz.layer.list[[1]]
    kg.map <- kg.map + latticeExtra::layer(sp.polygons(pz.layer, lwd=0.8, col="red"), data=list(pz.layer=pz.layer))
  }
}


print(kg.map)

dev.off()

if(report.kg==TRUE){print(kg.map)}

