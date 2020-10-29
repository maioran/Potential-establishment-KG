####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script load relevant administrative boundary layers from different sources and at 
# different administrative resolution
####################################################################################################

# load EPPO layer
EPPO.admin.layer    <- rgdal::readOGR(paste(data.dir, "input\\GIS\\EPPOadm_Borders_ms_simplified.shp", sep=""), "EPPOadm_Borders_ms_simplified")
EPPO.admin.layer    <- sp::spTransform(EPPO.admin.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))

# load EU (Eurostat) NUTS0 layer
EU.NUTS0.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2016_4326_LEVL_0.shp", sep=""), "NUTS_RG_01M_2016_4326_LEVL_0")
EU.NUTS0.layer      <- sp::spTransform(EU.NUTS0.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))

# check if NUTS 2 or 3 or fao gaul layers are needed from revised observed distribution table or from protectez zone list
if(any(pest.kg.table$admin.source%in% c("fao.gaul", "eu.nuts")) | length(unique(i.protected.zones$admin.level))!=0)
{# distribution.nuts <- c(2,3)
  distribution.nuts <- unique(pest.kg.table$admin.level[which(pest.kg.table$admin.source == "eu.nuts")])
  gaul.layers       <- unique(pest.kg.table$admin.level[which(pest.kg.table$admin.source == "fao.gaul")])
  prot.zones.nuts   <- unique(i.protected.zones$admin.level)
  nuts.layers       <- unique(c(distribution.nuts, prot.zones.nuts))
  
  if(3 %in% nuts.layers)
  {
    EU.NUTS3.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_3_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_3_reshaped")
    EU.NUTS3.layer      <- sp::spTransform(EU.NUTS3.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
  }
  
  if(2 %in% nuts.layers)
  {
    EU.NUTS2.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_2_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_2_reshaped")
    EU.NUTS2.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
  }
  
  if(0 %in% gaul.layers)
  {
    FAO.GAUL0.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_0_reshaped_0005.shp", sep=""), "g2015_2014_0_reshaped_0005")
    FAO.GAUL0.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
    
  }
  
  if(1 %in% gaul.layers)
  {
    FAO.GAUL1.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_1_reshaped_0005.shp", sep=""), "g2015_2014_1_reshaped_0005")
    FAO.GAUL1.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
    
  }
  
  if(2 %in% gaul.layers)
  {
    FAO.GAUL2.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_2_reshaped_0005.shp", sep=""), "g2015_2014_2_reshaped_0005")
    FAO.GAUL2.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
    
  }
    
}











