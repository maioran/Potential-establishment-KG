####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script load relevant administrative boundary layers from different sources and at 
# different administrative resolution
####################################################################################################
# ------------------
# Clean environment
# ------------------
rm(list=ls())
gc()
library("sp")

output.dir    <- "Output\\"
input.dir     <- "Data\\input\\"
data.dir      <- "Data\\"
kg.map.dir    <- paste(data.dir,"input\\GIS\\", sep="")

# save EPPO layer rdata file
EPPO.admin.layer    <- rgdal::readOGR(paste(data.dir, "input\\GIS\\EPPOadm_Borders_ms_simplified.shp", sep=""), "EPPOadm_Borders_ms_simplified", stringsAsFactors = FALSE)
EPPO.admin.layer    <- sp::spTransform(EPPO.admin.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
write.csv(EPPO.admin.layer@data[,-which(names(EPPO.admin.layer) %in% c("layer", "path"))], file=paste(data.dir, "support.info\\EPPO.admin.layer.csv", sep=""), row.names = FALSE)
save(EPPO.admin.layer, file=paste(data.dir, "rdata\\EPPO0.layer.RData", sep=""))

# FAO.GAUL
FAO.GAUL0.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_0_reshaped_0005.shp", sep=""), "g2015_2014_0_reshaped_0005", stringsAsFactors = FALSE)
FAO.GAUL0.layer      <- sp::spTransform(FAO.GAUL0.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(FAO.GAUL0.layer, file=paste(data.dir, "rdata\\FAO.GAUL0.layer.RData", sep=""))
rm(FAO.GAUL0.layer)

FAO.GAUL1.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_1_reshaped_0005.shp", sep=""), "g2015_2014_1_reshaped_0005", stringsAsFactors = FALSE)
FAO.GAUL1.layer      <- sp::spTransform(FAO.GAUL1.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(FAO.GAUL1.layer, file=paste(data.dir, "rdata\\FAO.GAUL1.layer.RData", sep=""))
rm(FAO.GAUL1.layer)

FAO.GAUL2.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_2_reshaped_0005.shp", sep=""), "g2015_2014_2_reshaped_0005", stringsAsFactors = FALSE)
FAO.GAUL2.layer      <- sp::spTransform(FAO.GAUL2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(FAO.GAUL2.layer, file=paste(data.dir, "rdata\\FAO.GAUL2.layer.RData", sep=""))
write.csv(FAO.GAUL2.layer@data[,-which(names(EPPO.admin.layer) %in% c("STR2_YEAR", "EXP2_YEAR", "Shape_Leng", "Shape_Area"))], file=paste(data.dir, "support.info\\FAO.GAUL.all.admin.layers.csv", sep=""), row.names = FALSE)
rm(FAO.GAUL2.layer)

# EU.NUTS
EU.NUTS0.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_0_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_0_reshaped", stringsAsFactors = FALSE, encoding = "WINDOWS.1252")
EU.NUTS0.layer      <- sp::spTransform(EU.NUTS0.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EU.NUTS0.layer, file=paste(data.dir, "rdata\\EU.NUTS0.layer.RData", sep=""))
write.csv(EU.NUTS0.layer@data, file=paste(data.dir, "support.info\\EU.NUTS0.admin.layer.csv", sep=""), row.names = FALSE)
rm(EU.NUTS0.layer)

EU.NUTS3.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_3_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_3_reshaped", stringsAsFactors = FALSE)
EU.NUTS3.layer      <- sp::spTransform(EU.NUTS3.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EU.NUTS3.layer, file=paste(data.dir, "rdata\\EU.NUTS3.layer.RData", sep=""))
write.csv(EU.NUTS3.layer@data[,-which(names(EU.NUTS3.layer) %in% c("LEVL_CODE", "MOUNT_TYPE", "URBN_TYPE", "COAST_TYPE"))], file=paste(data.dir, "support.info\\EU.NUTS3.admin.layer.csv", sep=""), row.names = FALSE)
rm(EU.NUTS3.layer)

EU.NUTS2.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_2_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_2_reshaped", stringsAsFactors = FALSE)
EU.NUTS2.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EU.NUTS2.layer, file=paste(data.dir, "rdata\\EU.NUTS2.layer.RData", sep=""))
write.csv(EU.NUTS2.layer@data[,-which(names(EU.NUTS2.layer) %in% c("LEVL_CODE", "MOUNT_TYPE", "URBN_TYPE", "COAST_TYPE"))], file=paste(data.dir, "support.info\\EU.NUTS3.admin.layer.csv", sep=""), row.names = FALSE)
rm(EU.NUTS2.layer)

EU27.layer          <- rgdal::readOGR(paste(data.dir, "input\\GIS\\EU27_Eurostat_NUTS_RG_01M_2021_4326_reshaped.shp", sep=""), "EU27_Eurostat_NUTS_RG_01M_2021_4326_reshaped", stringsAsFactors = FALSE)
EU27.layer          <- sp::spTransform(EU27.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EU27.layer, file=paste(data.dir, "rdata\\EU27.layer.RData", sep=""))
