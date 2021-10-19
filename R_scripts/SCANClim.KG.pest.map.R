####################################################################################################
# SCAN-Clim
# Create climate suitability map
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
levels(r.pest)[[1]]$colors <- climate.colors.pest
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
jpeg(paste0(output.dir,"\\Koppen-Geiger\\",i.region.to.plot,"_",pest.name,"_KG_",period,"_", actual.date, ".jpg"),width = print.width, height = print.heigth, units="cm", res=800)

# create map inlcuding KG raster and EPPO Admin layer as background
kg.map <- rasterVis::levelplot(r.pest, col.regions=levels(r.pest)[[1]]$colors, 
                               xlab="", ylab="", maxpixels = ncell(r.pest),
                               scales=list(x=list(limits=c(raster::extent(r.pest)[1], raster::extent(r.pest)[2]), at=seq(raster::extent(r.pest)[1], raster::extent(r.pest)[2], xat)),
                                           y=list(limits=c(raster::extent(r.pest)[3], raster::extent(r.pest)[4]), at=seq(raster::extent(r.pest)[3], raster::extent(r.pest)[4], yat)), cex=0.6), 
                             # scales=list(x=list(limits=c(raster::xmin(r.pest), raster::xmax(r.pest)), at=seq(raster::xmin(r.pest), raster::xmax(r.pest), xat)),
                             #             y=list(limits=c(raster::ymin(r.pest), raster::ymax(r.pest)), at=seq(raster::ymin(r.pest), raster::ymax(r.pest), yat)), cex=0.6), 
                               colorkey=list(labels=list(labels=r.pest@data@attributes[[1]]$climate, cex=cex.legend), space="top", tck=0, maxpixels=ncell(r.pest)))

kg.map <- kg.map + latticeExtra::layer(panel.text(efsa.x, efsa.y, paste("\uA9 EFSA\n",format(Sys.Date(), "%d %B %Y"),sep=""), adj=0, cex=0.7))
kg.map <- kg.map + latticeExtra::layer(sp.polygons(EPPO.admin.layer, lwd=0.5, col="dark grey"), data=list(EPPO.admin.layer=EPPO.admin.layer))

# add observations (admin layers)
if(distr.table==TRUE)
{
  kg.map <- kg.map + latticeExtra::layer(sp.polygons(observed.layer.list, lwd=0.5, col="black"), data=list(observed.layer.list=observed.layer.list))
  # write shapefile
  
}

# add observation points if any
if(!is.na(points.layer))
{
  kg.map <- kg.map + latticeExtra::layer(sp.points(points.layer, cex=0.5, col="black", lwd=0.5, pch=21, fill="red", ), data=list(points.layer=points.layer))
}

# add layer including protected zones (TEST - NOT IMPLEMENTED IN THIS VERSION)
# if(exists("pz.layer.list"))
# {
#   for(pz.layer in pz.layer.list)
#   {# pest.layer <- pz.layer.list[[1]]
#     kg.map <- kg.map + latticeExtra::layer(sp.polygons(pz.layer, lwd=0.8, col="red"), data=list(pz.layer=pz.layer))
#   }
# }

print(kg.map)

dev.off()

# save GIS layers
if(i.gis=="yes")
{
  rgdal::writeOGR(points.layer, paste0(output.dir, "GIS\\", pest.name, "_obs_points_layer",".shp"), layer="points.layer", driver="ESRI Shapefile")
  writeRaster(r.pest, paste0(output.dir, "GIS\\", pest.name, "_KG.grd"), overwrite=TRUE)
  rgdal::writeOGR(EPPO.admin.layer, paste0(output.dir, "GIS\\", pest.name, "_world_bound.shp"), layer="EPPO.admin.layer", driver="ESRI Shapefile")
  if(distr.table==TRUE) 
  {
    rgdal::writeOGR(observed.layer.list, paste0(output.dir, "GIS\\", pest.name, "_obs_layer",".shp"), layer="observed.layer.list", driver="ESRI Shapefile")
  }

}

# print map in html if report required
if(i.report=="yes"){print(kg.map)}


