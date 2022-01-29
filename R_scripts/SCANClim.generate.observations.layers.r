####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script generate the layers including the administrative units (country, regions, locations) 
# where the pest was observed according to EPPO table and/or area indicated by the experts
# Admin source can be: 'EPPO' (only level 0), 'EU.NUTS' (levels 0,2,3), 'FAO.GAUL' (levels 0, 1 ,2), and
# 'location' (in this case the coordinates should be indicated)
#
# OUTPUT of the script: 
# - observed.layer.list
# - points.layer
# - units.na.list
noquote("Generating pest observation layers")
#observed.layer.list <- c()
units.na.list       <- c()
points.layer        <- NA

if(distr.table == TRUE)
{
  for(admin.source in unique(pest.kg.table$admin.source))
  {# TEST: admin.source <- unique(pest.kg.table$admin.source)[1]
    # filter on admin source
    pest.kg.table.source.fltr <- pest.kg.table[which(pest.kg.table$admin.source == admin.source),]
    
    if(!is.na(admin.source))
    {
      if(admin.source != "location")
      { 
        for(admin.level in unique(pest.kg.table.source.fltr$admin.level))
        { #TEST: admin.level <- 0
          pest.kg.table.level.fltr <- pest.kg.table.source.fltr[which(pest.kg.table.source.fltr$admin.level == admin.level),]
          
          # load actual layer
          actual.layer <- get(load(paste(data.dir, "rdata\\", admin.source, admin.level,".layer.RData",sep="")))
          
          # create a layer including only the relevant administrative units
          actual.layer.select <- admin.layer.fun(actual.layer, admin.level, admin.source, pest.kg.table.level.fltr)
          
          # merge the layers in a unique Spatial polygon dataframe
          # if this is the first admin source of the first admin layer then it creates the first polygon layers
          # otherwise it merges the successive layers
          if(!exists("observed.layer.list"))
          {
            observed.layer.list <- actual.layer.select$layer
          }else
          {
            observed.layer.list <- raster::union(observed.layer.list, actual.layer.select$layer)
          }
          
          if(!is.null(actual.layer.select$units.na))
          {
            units.na.list       <- c(units.na.list, actual.layer.select$units.na)
          }
          
          
        }
      }else
      {
        # create a layer of location points
        points.layer              <- pest.kg.table.source.fltr
        points.layer$lat  <- as.numeric(points.layer$lat)
        points.layer$long <- as.numeric(points.layer$long)
        sp::coordinates(points.layer) <- ~ long + lat
        
      }
      
    }
    
  }
  if(!is.null(units.na.list))
  {
    write.table(units.na.list, file=paste(output.dir,"\\Admin.names.to.check.csv", sep=""),row.names = FALSE, col.names=FALSE, fileEncoding = "UTF-8")
    
  }
}

rm(pest.kg.table.source.fltr, admin.source, actual.layer, actual.layer.select)
