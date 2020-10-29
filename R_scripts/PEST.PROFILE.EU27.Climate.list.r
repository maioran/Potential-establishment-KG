####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script extracts the list of KG climates present in Europe
# Information from the configuration file is used to remove specific climates from the analysis
####################################################################################################

if(i.recalculate.EU27.climate.list == "yes")
{
  EU27.layer          <- rgdal::readOGR(paste(data.dir, "input\\GIS\\EU27_Eurostat_NUTS_RG_01M_2021_4326_reshaped.shp", sep=""), "EU27_Eurostat_NUTS_RG_01M_2021_4326_reshaped")
  EU27.layer          <- sp::spTransform(EU27.layer, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
  
  # Extract KG raster of EU27
  EU.climates.extract <- extract(x=r, y=EU27.layer)
  # Extract list of EU climates
  EU.climates <- rat$climate[sort(unique(unlist(EU.climates.extract)))]
  # remove "ET" and "Ocean" climates
  EU.climates <- EU.climates[-which(EU.climates %in% i.climates.to.remove)]
  
  # write file
  write.table(EU.climates, paste(input.dir, "EU27.Climate.list.csv", sep=""), row.names=FALSE, col.names = c("EU27Clim"), sep=",")
  rm(EU27.layer, EU.climates.extract, i.recalculate.EU27.climate.list)
}else
{
  EU.climates <- read.csv(paste(input.dir, "EU27.Climate.list.csv", sep=""), stringsAsFactors = FALSE, header = TRUE)[,1]
}

