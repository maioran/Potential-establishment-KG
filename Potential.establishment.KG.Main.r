#####################################################################################################
#####################################################################################################
############## EFSA Köppen–Geiger approach for climate suitability of pests #########################
#####################################################################################################
#####################################################################################################
# Developed by Andrea MAIORANO (ALPHA-PLH)
# with the support of the EFSA Agricultural insect Pest Categorization working group: 
# Virág Kertész, Franz Streissl. Alan MacLeod, Josep Jaques, Lucia Zappalà
# 
# EFSA, ALPHA Unit, PLH Team
# This version developed in November 2020
#####################################################################################################


#####################################################################################################
# INSTRUCTIONS:
# 1) fill-in the configuration file (excel) and save it in the project folder
# 2) launch the script by clicking on the "source" button
#####################################################################################################

# ------------------
# Clean environment
# ------------------
rm(list=ls())
gc()

actual.date       <- format(Sys.time(), "%Y-%m-%d")
# install packages if needed
source("R_scripts\\PEST.PROFILE.install.required.packages.r")
# load inputs from configuration file 
source("R_scripts\\PEST.PROFILE.load.input.from.configuration.file.r")
# set main directories
source("R_scripts\\PEST.PROFILE.main.directories.r")
# Load Köppen–Geiger raster file (load raster and setup color palette for climates)
# source("R_scripts\\_PEST.PROFILE.KG.map.setup.R")
load(paste(data.dir, "rdata\\r_KG_raster.RData",sep=""))

# Load EU27 Climate list
source("R_scripts\\PEST.PROFILE.EU27.Climate.list.R")

for(pest.name in i.pest.list)
{#TEST: pest.name <- i.pest.list[1]
  
  # create and check directories
  source("R_scripts\\PEST.PROFILE.check.pest.directories.r")
  
  # download EPPO distribution tables or load reviewed distribution table
  source("R_scripts\\PEST.PROFILE.web.EPPO.distribution.table.r")
  
  # download EPPO host list table (if selected in configuration file)
  if(i.eppo.host.table=="yes") 
  {
    source("R_scripts\\PEST.PROFILE.web.EPPO.host.table.r")
  }
  
  # load list of protected zones
  if(i.include.protected.zones == "yes")
  {
    source("R_scripts\\PEST.PROFILE.load.protected.zones.r")
  }
 
  # Function to create administrative units layers: 
  # - create layers including administrative units where pest was observed
  # - list of administrative units that were not found due to spelling mistakes, different naming conventions, different enconding, ...
  source("R_scripts\\_PEST.PROFILE.admin.layer.fun.r")
  
  # Function to extract climates from complete Koppen-Geiger map for the administrative units or points where pest was observed
  source("_PEST.PROFILE.extract.climate.fun.r")
  
  # load GIS layers
  source("R_scripts\\PEST.PROFILE.generate.observations.layers.r")
  
  # Extract the list of climates relevant for the pest
  source("R_scripts\\PEST.PROFILE.extract.list.pest.climates.r")
  
  # KG pest ap
  source("R_scripts\\PEST.PROFILE.KG.pest.map.R")
  
}
