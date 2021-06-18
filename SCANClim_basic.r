# Function to create administrative units layers: 
# - create layers including administrative units where pest was observed
# - list of administrative units that were not found due to spelling mistakes, different naming conventions, different enconding, etc...
source("R_scripts\\_PEST.PROFILE.admin.layer.fun.r")
# Function to extract climates from complete Koppen-Geiger map for the administrative units or points where pest was observed
source("R_scripts\\_PEST.PROFILE.extract.climate.fun.r")
# load GIS layers
source("R_scripts\\PEST.PROFILE.generate.observations.layers.r")
# Extract the list of climates relevant for the pest (RESOURCE DEMANDING)
source("R_scripts\\PEST.PROFILE.extract.list.pest.climates.r")
kg.climate.list <- read.csv(paste0(support.info, "KG_climates.csv"), header = TRUE, stringsAsFactors = FALSE, fileEncoding="UTF-8-BOM")
# KG pest map (RESOURCE DEMANDING)
source("R_scripts\\PEST.PROFILE.KG.pest.map.R")
