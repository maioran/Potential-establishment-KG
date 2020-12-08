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

# EPPO 
# save EPPO layer rdata file
EPPO.admin.layer    <- rgdal::readOGR(paste(data.dir, "input\\GIS\\EPPOadm_Borders_ms_simplified.shp", sep=""), "EPPOadm_Borders_ms_simplified", stringsAsFactors = FALSE)
EPPO.admin.layer    <- sp::spTransform(EPPO.admin.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EPPO.admin.layer, file=paste(data.dir, "rdata\\EPPO0.layer.RData", sep=""))
write.csv(EPPO.admin.layer@data[,-which(names(EPPO.admin.layer) %in% c("layer", "path"))], file=paste(data.dir, "support.info\\EPPO Codes and names.csv", sep=""), row.names = FALSE)
rm(EPPO.admin.layer)

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
write.csv(FAO.GAUL2.layer@data[,-which(names(FAO.GAUL2.layer) %in% c("STR2_YEAR", "EXP2_YEAR", "Shape_Leng", "Shape_Area"))], file=paste(data.dir, "support.info\\FAO.GAUL codes and names.csv", sep=""), row.names = FALSE)
rm(FAO.GAUL2.layer)

# EU.NUTS
EU.NUTS0.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_0_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_0_reshaped", stringsAsFactors = FALSE, encoding = "UTF-8")
EU.NUTS0.layer      <- sp::spTransform(EU.NUTS0.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EU.NUTS0.layer, file=paste(data.dir, "rdata\\EU.NUTS0.layer.RData", sep=""))

EU.NUTS2.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_2_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_2_reshaped", stringsAsFactors = FALSE, encoding = "English_United States.1252")
EU.NUTS2.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EU.NUTS2.layer, file=paste(data.dir, "rdata\\EU.NUTS2.layer.RData", sep=""))

EU.NUTS3.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_3_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_3_reshaped", stringsAsFactors = FALSE, encoding = "UTF-8")
EU.NUTS3.layer      <- sp::spTransform(EU.NUTS3.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EU.NUTS3.layer, file=paste(data.dir, "rdata\\EU.NUTS3.layer.RData", sep=""))

# Print table of EU NUTS administrative codes and names in the support info folder
EU.NUTS.table <- EU.NUTS3.layer@data
# remove not needed columns
EU.NUTS.table <- EU.NUTS.table[,-which(colnames(EU.NUTS.table) %in% c("MOUNT_TYPE", "URBN_TYPE", "COAST_TYPE", "LEVL_CODE", "id"))]
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NUTS_ID")] <- "NUTS3_ID"
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NAME_LATN")] <- "NUTS3_NAME_LATIN"
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NUTS_NAME")] <- "NUTS3_NAME"

# add nuts2 code
EU.NUTS.table$NUTS_ID <- substring(EU.NUTS.table$NUTS3_ID, 1, nchar(EU.NUTS.table$NUTS3_ID)-1)
# add nuts2 names
EU.NUTS.table <- merge(EU.NUTS.table, EU.NUTS2.layer@data[,c("NUTS_ID", "NAME_LATN", "NUTS_NAME")], by=c("NUTS_ID"))
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NUTS_ID")] <- "NUTS2_ID"
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NAME_LATN")] <- "NUTS2_NAME_LATIN"
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NUTS_NAME")] <- "NUTS2_NAME"

# add nuts0 names
EU.NUTS.table <- merge(EU.NUTS.table, EU.NUTS0.layer@data[,c("CNTR_CODE", "NAME_LATN", "NUTS_NAME")], by=c("CNTR_CODE"))
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NAME_LATN")] <- "NUTS0_NAME_LATIN"
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NUTS_NAME")] <- "NUTS0_NAME"

# reorder columns
EU.NUTS.table <- EU.NUTS.table[, c("CNTR_CODE", "NUTS0_NAME_LATIN", "NUTS0_NAME", 
                                   "NUTS2_ID",  "NUTS2_NAME_LATIN", "NUTS2_NAME",
                                   "NUTS3_ID",  "NUTS3_NAME_LATIN", "NUTS3_NAME")]
write.csv(EU.NUTS.table, file=paste(data.dir, "support.info\\EU.NUTS.codes and names.csv", sep=""), row.names = FALSE)
rm(EU.NUTS3.layer, EU.NUTS0.layer, EU.NUTS2.layer)

EU27.layer          <- rgdal::readOGR(paste(data.dir, "input\\GIS\\EU27_Eurostat_NUTS_RG_01M_2021_4326_reshaped.shp", sep=""), "EU27_Eurostat_NUTS_RG_01M_2021_4326_reshaped", stringsAsFactors = FALSE)
EU27.layer          <- sp::spTransform(EU27.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EU27.layer, file=paste(data.dir, "rdata\\EU27.layer.RData", sep=""))
