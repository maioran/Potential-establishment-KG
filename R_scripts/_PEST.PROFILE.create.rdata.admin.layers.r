####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script load relevant administrative boundary layers from different sources and at 
# different administrative resolution
####################################################################################################

# save EPPO layer rdata file
EPPO.admin.layer    <- rgdal::readOGR(paste(data.dir, "input\\GIS\\EPPOadm_Borders_ms_simplified.shp", sep=""), "EPPOadm_Borders_ms_simplified")
EPPO.admin.layer    <- sp::spTransform(EPPO.admin.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EPPO.admin.layer, file=paste(data.dir, "rdata\\EPPO.admin.layer.RData", sep=""))

# load EU (Eurostat) NUTS0 layer
EU.NUTS0.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2016_4326_LEVL_0.shp", sep=""), "NUTS_RG_01M_2016_4326_LEVL_0")
EU.NUTS0.layer      <- sp::spTransform(EU.NUTS0.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EU.NUTS0.layer, file=paste(data.dir, "rdata\\EU.NUTS0.layer.RData", sep=""))

FAO.GAUL0.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_0_reshaped_0005.shp", sep=""), "g2015_2014_0_reshaped_0005")
FAO.GAUL0.layer      <- sp::spTransform(FAO.GAUL0.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(FAO.GAUL0.layer, file=paste(data.dir, "rdata\\FAO.GAUL0.layer.RData", sep=""))

FAO.GAUL1.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_1_reshaped_0005.shp", sep=""), "g2015_2014_1_reshaped_0005")
FAO.GAUL1.layer      <- sp::spTransform(FAO.GAUL1.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(FAO.GAUL1.layer, file=paste(data.dir, "rdata\\FAO.GAUL1.layer.RData", sep=""))

FAO.GAUL2.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_2_reshaped_0005.shp", sep=""), "g2015_2014_2_reshaped_0005")
FAO.GAUL2.layer      <- sp::spTransform(FAO.GAUL2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(FAO.GAUL2.layer, file=paste(data.dir, "rdata\\FAO.GAUL2.layer.RData", sep=""))

EU.NUTS3.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_3_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_3_reshaped")
EU.NUTS3.layer      <- sp::spTransform(EU.NUTS3.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EU.NUTS3.layer, file=paste(data.dir, "rdata\\EU.NUTS3.layer.RData", sep=""))

EU.NUTS2.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_2_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_2_reshaped")
EU.NUTS2.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EU.NUTS2.layer, file=paste(data.dir, "rdata\\EU.NUTS2.layer.RData", sep=""))