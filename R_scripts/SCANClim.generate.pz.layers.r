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

pz.layer.list       <- c()

for(admin.source in unique(i.protected.zones$admin.source))
{# TEST: admin.source <- unique(i.protected.zones$admin.source)[1]
  # filter on admin source
  pest.pz.table.source.fltr <- i.protected.zones[which(i.protected.zones$admin.source == admin.source),]
  
  for(admin.level in unique(pest.pz.table.source.fltr$admin.level))
  {#TEST: admin.level <- 0
    pest.pz.table.level.fltr <- pest.pz.table.source.fltr[which(pest.pz.table.source.fltr$admin.level == admin.level),]
    
    # load actual layer
    actual.layer <- get(load(paste(data.dir, "rdata\\", admin.source, admin.level,".layer.RData",sep="")))
    
    # create a layer including only the relevant administrative units
    actual.layer.select <- admin.layer.fun(actual.layer, admin.level, admin.source, pest.pz.table.level.fltr)
    
    pz.layer.list    <- c(pz.layer.list, actual.layer.select$layer)
    units.na.list    <- c(units.na.list, actual.layer.select$units.na)
    
  }
  
  
}
rm(pest.pz.table.source.fltr, admin.source, actual.layer, actual.layer.select)
