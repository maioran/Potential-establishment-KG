# uncertain point layer
uncertain.point.table <- uncertain.table[which(uncertain.table$admin.source=="location"),]
uncertain.point.table$lat  <- as.numeric(uncertain.point.table$lat)
uncertain.point.table$long <- as.numeric(uncertain.point.table$long)
sp::coordinates(uncertain.point.table) <- ~ long + lat

jpeg(paste0(output.dir,"\\Koppen-Geiger\\",i.region.to.plot,"_",pest.name,"_KG_uncertain_",period,"_", actual.date, ".jpg"),width = print.width, height = print.heigth, units="cm", res=800)

kg.map <- kg.map + latticeExtra::layer(sp.points(uncertain.point.table, cex=0.7, col="black", lwd=0.5, pch=23, fill="orange", ), data=list(uncertain.point.table=uncertain.point.table))

# uncertain 
admin.source <- "FAO.GAUL"
pest.kg.table.source.fltr <- uncertain.table[which(uncertain.table$admin.source == admin.source),]
actual.layer.select <- NA
pest.kg.table.level.fltr <- NA
for(admin.level in unique(pest.kg.table.source.fltr$admin.level))
{ # TEST: admin.level <- 0
  pest.kg.table.level.fltr <- pest.kg.table.source.fltr[which(pest.kg.table.source.fltr$admin.level == admin.level),]
  
  # load actual layer
  actual.layer <- get(load(paste(data.dir, "rdata\\", admin.source, admin.level,".layer.RData",sep="")))
  
  # create a layer including only the relevant administrative units
  actual.layer.select <- admin.layer.fun(actual.layer, admin.level, admin.source, pest.kg.table.level.fltr)
  
  # merge the layers in a unique Spatial polygon dataframe
  if(admin.level==unique(pest.kg.table.source.fltr$admin.level)[1])
  {
    observed.layer.list.un <- actual.layer.select$layer
  }else
  {
    observed.layer.list.un <- raster::union(observed.layer.list.un, actual.layer.select$layer)
  }
  
  if(!is.null(actual.layer.select$units.na))
  {
    units.na.list       <- c(units.na.list, actual.layer.select$units.na)
  }
  
  
}

kg.map <- kg.map + latticeExtra::layer(sp.polygons(observed.layer.list.un, lwd=1, col="orange"), data=list(observed.layer.list.un=observed.layer.list.un))
print(kg.map)

dev.off()

