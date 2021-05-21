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
list.files(paste0(data.dir, "input\\GIS\\"))
######### EPPO ####################
# save EPPO layer rdata file
EPPO.admin.layer    <- rgdal::readOGR(paste(data.dir, "input\\GIS\\EPPOadm_simplified.shp", sep=""), "EPPOadm_simplified", stringsAsFactors = FALSE)
EPPO.admin.layer    <- sp::spTransform(EPPO.admin.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EPPO.admin.layer, file=paste(data.dir, "rdata\\EPPO0.layer.RData", sep=""))
# save EPPO admin table (based on FAO GAUL)
EPPO.table <- EPPO.admin.layer@data[,-which(names(EPPO.admin.layer) %in% c("layer", "path"))]
write.csv(EPPO.table, file="Supporting_information\\EPPO Codes and names.csv", row.names = FALSE)
rm(EPPO.admin.layer, EPPO.table)

######### FAO.GAUL ####################
# FAO GAUL 0 RData
FAO.GAUL0.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_0_reshaped_0005.shp", sep=""), "g2015_2014_0_reshaped_0005", stringsAsFactors = FALSE)
FAO.GAUL0.layer      <- sp::spTransform(FAO.GAUL0.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(FAO.GAUL0.layer, file=paste(data.dir, "rdata\\FAO.GAUL0.layer.RData", sep=""))
rm(FAO.GAUL0.layer)
# FAO GAUL 1 RData
FAO.GAUL1.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_1_reshaped_0005.shp", sep=""), "g2015_2014_1_reshaped_0005", stringsAsFactors = FALSE)
FAO.GAUL1.layer      <- sp::spTransform(FAO.GAUL1.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(FAO.GAUL1.layer, file=paste(data.dir, "rdata\\FAO.GAUL1.layer.RData", sep=""))
rm(FAO.GAUL1.layer)
# FAO GAUL 2 RData
FAO.GAUL2.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\g2015_2014_2_reshaped_0005.shp", sep=""), "g2015_2014_2_reshaped_0005", stringsAsFactors = FALSE)
FAO.GAUL2.layer      <- sp::spTransform(FAO.GAUL2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(FAO.GAUL2.layer, file=paste(data.dir, "rdata\\FAO.GAUL2.layer.RData", sep=""))
# save FAO GAUL 2 admin table
write.csv(FAO.GAUL2.layer@data[,-which(names(FAO.GAUL2.layer) %in% c("STR2_YEAR", "EXP2_YEAR", "Shape_Leng", "Shape_Area"))], file="Supporting_information\\EPPO Codes and names.csv", row.names = FALSE)
rm(FAO.GAUL2.layer)

######### EU.NUTS ####################
# read table with international names of countries
country.int.codes <- read.csv("Supporting_information\\EU_NUTS_Country_code.csv", stringsAsFactors = FALSE, header = TRUE, fileEncoding="UTF-8-BOM")
# country.iso.codes <- read.csv("Supporting_information\\ISO_country_codes.csv", stringsAsFactors = FALSE, fileEncoding="UTF-8-BOM")
# country.int.codes <- merge(country.int.codes, country.iso.codes, by=c("ADM0_NAME"))

# EU NUTS 0 RData
EU.NUTS0.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_0_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_0_reshaped", stringsAsFactors = FALSE, encoding = "UTF-8")
EU.NUTS0.layer      <- sp::spTransform(EU.NUTS0.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
# encode correctly characters (UTF-8)
Encoding(EU.NUTS0.layer@data$NAME_LATN) <- "UTF-8"
Encoding(EU.NUTS0.layer@data$NUTS_NAME) <- "UTF-8"
# add column with international country names
EU.NUTS0.layer@data <- merge(EU.NUTS0.layer@data, country.int.codes, by=c("CNTR_CODE"), all.x=TRUE)
# save RData 
save(EU.NUTS0.layer, file=paste(data.dir, "rdata\\EU.NUTS0.layer.RData", sep=""))

# EU NUTS 2 RData
EU.NUTS2.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_2_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_2_reshaped", stringsAsFactors = FALSE, encoding = "English_United States.1252")
EU.NUTS2.layer      <- sp::spTransform(EU.NUTS2.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
# encode correctly characters (UTF-8)
Encoding(EU.NUTS2.layer@data$NAME_LATN) <- "UTF-8"
Encoding(EU.NUTS2.layer@data$NUTS_NAME) <- "UTF-8"
# add column with international country names
EU.NUTS2.layer@data <- merge(EU.NUTS2.layer@data, country.int.codes, by=c("CNTR_CODE"),all.x=TRUE)
# save RData 
save(EU.NUTS2.layer, file=paste(data.dir, "rdata\\EU.NUTS2.layer.RData", sep=""))

# EU NUTS 3 RData
EU.NUTS3.layer      <- rgdal::readOGR(paste(data.dir, "input\\GIS\\NUTS_RG_01M_2021_4326_LEVL_3_reshaped.shp", sep=""), "NUTS_RG_01M_2021_4326_LEVL_3_reshaped", stringsAsFactors = FALSE, encoding = "UTF-8")
EU.NUTS3.layer      <- sp::spTransform(EU.NUTS3.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
Encoding(EU.NUTS3.layer@data$NAME_LATN) <- "UTF-8"
Encoding(EU.NUTS3.layer@data$NUTS_NAME) <- "UTF-8"
# add column with international country names
EU.NUTS3.layer@data <- merge(EU.NUTS3.layer@data, country.int.codes, by=c("CNTR_CODE"), all.x=TRUE)
# save RData 
save(EU.NUTS3.layer, file=paste(data.dir, "rdata\\EU.NUTS3.layer.RData", sep=""))

# Print table of EU NUTS administrative codes and names in the support info folder
EU.NUTS.table <- EU.NUTS3.layer@data
# remove not needed columns
EU.NUTS.table <- EU.NUTS.table[,-which(colnames(EU.NUTS.table) %in% c("MOUNT_TYPE", "URBN_TYPE", "COAST_TYPE", "LEVL_CODE", "id"))]
# modify names
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NUTS_ID")] <- "NUTS3_ID"
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NAME_LATN")] <- "NUTS3_NAME_LATN"

# add column for nuts2 code
EU.NUTS.table$NUTS_ID <- substring(EU.NUTS.table$NUTS3_ID, 1, nchar(EU.NUTS.table$NUTS3_ID)-1)
# add column for nuts2 names
EU.NUTS.table <- merge(EU.NUTS.table, EU.NUTS2.layer@data[,c("NUTS_ID", "NAME_LATN", "NUTS_NAME")], by=c("NUTS_ID"), x.all=TRUE)
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NUTS_ID")] <- "NUTS2_ID"
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NAME_LATN")] <- "NUTS2_NAME_LATN"

# add column for nuts0 names
EU.NUTS.table <- merge(EU.NUTS.table, EU.NUTS0.layer@data[,c("CNTR_CODE", "NAME_LATN", "NUTS_NAME")], by=c("CNTR_CODE"), x.all=TRUE)
colnames(EU.NUTS.table)[which(colnames(EU.NUTS.table) == "NAME_LATN")] <- "NUTS0_NAME_LATN"

# encode string column with correct encoding (UTF-8)
Encoding(EU.NUTS.table$NUTS0_NAME_LATN) <- "UTF-8"
Encoding(EU.NUTS.table$NUTS2_NAME_LATN) <- "UTF-8"
Encoding(EU.NUTS.table$NUTS3_NAME_LATN) <- "UTF-8"
# add English country name
#country.code <- read.csv(paste(data.dir, "support.info\\EU_NUTS_Country_code.csv", sep=""), header = TRUE, stringsAsFactors = FALSE, fileEncoding="UTF-8-BOM")
#EU.NUTS.table <- merge(EU.NUTS.table, country.code, by=c("CNTR_CODE"))
# reorder columns
EU.NUTS.table <- EU.NUTS.table[, c("CNTR_CODE", "NUTS0_NAME_INT","NUTS0_NAME_LATN", 
                                   "NUTS2_ID",  "NUTS2_NAME_LATN", 
                                   "NUTS3_ID",  "NUTS3_NAME_LATN")]
# write table
write.csv(EU.NUTS.table, file="Supporting_information\\EPPO Codes and names.csv", row.names = FALSE)
rm(EU.NUTS3.layer, EU.NUTS0.layer, EU.NUTS2.layer, EU.NUTS.table)

EU27.layer          <- rgdal::readOGR(paste(data.dir, "input\\GIS\\EU27_Eurostat_NUTS_RG_01M_2021_4326_reshaped.shp", sep=""), "EU27_Eurostat_NUTS_RG_01M_2021_4326_reshaped", stringsAsFactors = FALSE)
EU27.layer          <- sp::spTransform(EU27.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
save(EU27.layer, file=paste(data.dir, "rdata\\EU27.layer.RData", sep=""))
