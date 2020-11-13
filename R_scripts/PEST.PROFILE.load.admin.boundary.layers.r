####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script load relevant administrative boundary layers from different sources and at 
# different administrative resolution
####################################################################################################

# save EPPO layer rdata file
load(paste(data.dir, "rdata\\EPPO.admin.layer.RData",sep=""))

# load EU (Eurostat) NUTS0 layer
load(paste(data.dir, "rdata\\EU.NUTS0.layer.RData",sep=""))

# check if FAO gaul layers are needed from revised observed distribution table 
if(any(pest.kg.table$admin.source == "fao.gaul"))
{
  if(0 %in% pest.kg.table$admin.level[which(pest.kg.table$admin.source == "fao.gaul")])
  {
    load(paste(data.dir, "rdata\\FAO.GAUL0.layer.RData",sep=""))
    
  }
  
  if(1 %in% pest.kg.table$admin.level[which(pest.kg.table$admin.source == "fao.gaul")])
  {
    load(paste(data.dir, "rdata\\FAO.GAUL1.layer.RData",sep=""))
    
  }
  
  if(2 %in% pest.kg.table$admin.level[which(pest.kg.table$admin.source == "fao.gaul")])
  {
    load(paste(data.dir, "rdata\\FAO.GAUL2.layer.RData",sep=""))
  }
  
}

# check if EUROSTAT NUTS layers are needed from revised observed distribution table 
if(any(pest.kg.table$admin.source %in% c("eu.nuts")))
{# distribution.nuts <- c(2,3)
  nuts.layers       <- unique(pest.kg.table$admin.level[which(pest.kg.table$admin.source == "eu.nuts")])
  
  if(3 %in% pest.kg.table$admin.level[which(pest.kg.table$admin.source == "eu.nuts")])
  {
    load(paste(data.dir, "rdata\\EU.NUTS3.layer.RData",sep=""))
  }
  
  if(2 %in% pest.kg.table$admin.level[which(pest.kg.table$admin.source == "eu.nuts")])
  {
    load(paste(data.dir, "rdata\\EU.NUTS2.layer.RData",sep=""))
  }
  
}

# check if protected zones are needed and create specific layers
if(i.include.protected.zones=="yes")
{
  if(3 %in% i.protected.zones$admin.level)
  {
    if(exists("EU.NUTS3.layer"))
    {
      pz3 <- subset(EU.NUTS3.layer, NUTS_ID %in% i.protected.zones$NUTS_CODE)
    }else
    {
      load(paste(data.dir, "rdata\\EU.NUTS3.layer.RData",sep=""))
      pz3 <- subset(EU.NUTS3.layer, NUTS_ID %in% i.protected.zones$NUTS_CODE)
    }
  }
  
  if(2 %in% i.protected.zones$admin.level)
  {
    if(exists("EU.NUTS2.layer"))
    {
      pz2 <- subset(EU.NUTS2.layer, NUTS_ID %in% i.protected.zones$NUTS_CODE)
    }else
    {
      load(paste(data.dir, "rdata\\EU.NUTS2.layer.RData",sep=""))
      pz2                 <- subset(EU.NUTS2.layer, NUTS_ID %in% i.protected.zones$NUTS_CODE)
    }
  }
  
  if(0 %in% i.protected.zones$admin.level)
  {
    pz0 <- subset(EU.NUTS0.layer, NUTS_ID %in% i.protected.zones$NUTS_CODE)
  }
  
}










