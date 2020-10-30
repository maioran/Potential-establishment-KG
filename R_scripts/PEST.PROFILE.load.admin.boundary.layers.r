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

# check if FAO gaul layers are needed from revised observed distribution table 
if(any(pest.kg.table$admin.source == "fao.gaul"))
{
  if(0 %in% pest.kg.table$admin.level[which(pest.kg.table$admin.source == "fao.gaul")])
  {
    FAO.GAUL0.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_0_reshaped_0005.shp", sep=""), "g2015_2014_0_reshaped_0005")
    FAO.GAUL0.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
    
  }
  
  if(1 %in% pest.kg.table$admin.level[which(pest.kg.table$admin.source == "fao.gaul")])
  {
    FAO.GAUL1.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_1_reshaped_0005.shp", sep=""), "g2015_2014_1_reshaped_0005")
    FAO.GAUL1.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
    
  }
  
  if(2 %in% pest.kg.table$admin.level[which(pest.kg.table$admin.source == "fao.gaul")])
  {
    FAO.GAUL2.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_2_reshaped_0005.shp", sep=""), "g2015_2014_2_reshaped_0005")
    FAO.GAUL2.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
    
  }
  
}

# check if EUROSTAT NUTS layers are needed from revised observed distribution table 
if(any(pest.kg.table$admin.source %in% c("eu.nuts")))
{# distribution.nuts <- c(2,3)
  nuts.layers       <- unique(pest.kg.table$admin.level[which(pest.kg.table$admin.source == "eu.nuts")])
  
  if(3 %in% pest.kg.table$admin.level[which(pest.kg.table$admin.source == "eu.nuts")])
  {
    EU.NUTS3.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_3_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_3_reshaped")
    EU.NUTS3.layer      <- sp::spTransform(EU.NUTS3.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
    
  }
  
  if(2 %in% pest.kg.table$admin.level[which(pest.kg.table$admin.source == "eu.nuts")])
  {
    EU.NUTS2.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_2_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_2_reshaped")
    EU.NUTS2.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
    
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
      EU.NUTS3.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_3_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_3_reshaped")
      EU.NUTS3.layer      <- sp::spTransform(EU.NUTS3.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
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
      EU.NUTS2.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_2_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_2_reshaped")
      EU.NUTS2.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
      pz2                 <- subset(EU.NUTS2.layer, NUTS_ID %in% i.protected.zones$NUTS_CODE)
    }
  }
  
  if(0 %in% i.protected.zones$admin.level)
  {
    pz0 <- subset(EU.NUTS0.layer, NUTS_ID %in% i.protected.zones$NUTS_CODE)
  }
  
}










