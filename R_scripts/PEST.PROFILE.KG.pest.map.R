####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script print the KG map
####################################################################################################

# set the kg map colors according to the climates that are relevant for the pest by setting the remaining as "white" i.e."#00000000"
climate.colors.pest <- climate.colors
climate.colors.pest[which(!levels(r)[[1]]$climate %in% pest.climates.list)] <- "#00000000"

# map coordinate range (x1, x2, y1, y2). Grid extent (xat, yat) is set directly in the levelplot function below
r.pest <- crop(r, extent(map.coord.reg$x1,map.coord.reg$x2, map.coord.reg$y1, map.coord.reg$y2))

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
  kg.print.heigth = 15
}

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

kg.map <- rasterVis::levelplot(r.pest, col.regions=climate.colors.pest, xlab="", ylab="", maxpixels = ncell(r.pest),
                               scales=list(x=list(limits=c(xmin(r.pest), xmax(r.pest)), at=seq(xmin(r.pest), xmax(r.pest), map.coord.reg$xat)),
                                           y=list(limits=c(ymin(r.pest), ymax(r.pest)), at=seq(ymin(r.pest), ymax(r.pest), map.coord.reg$yat)), cex=0.6), 
                               colorkey=list(space="top", tck=0, maxpixels=ncell(r.pest), labels=list(cex=cex.legend)))
kg.map <- kg.map + latticeExtra::layer(panel.text(-175, -50, paste("\uA9 EFSA\n",format(actual.date, "%d %B %Y"),sep=""), adj=0, cex=0.7))
kg.map <- kg.map + latticeExtra::layer(sp.polygons(EPPO.admin.layer, lwd=0.5, col="grey"), data=list(EPPO.admin.layer=EPPO.admin.layer))

for(pest.layer in observed.layer.list)
{# pest.layer <- observed.layer.list[[3]]
  kg.map <- kg.map + latticeExtra::layer(sp.polygons(pest.layer, lwd=0.5, col="black"), data=list(pest.layer=pest.layer))
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

