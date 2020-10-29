#####################################################################################################
#####################################################################################################
############## EFSA Köppen–Geiger approach for climate suitability of pests #########################
#####################################################################################################
#####################################################################################################
# Developed by Andrea Maiorano, EFSA, ALPHA Unit, PLH Team
# This version developed in 2020
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
# Setup Köppen–Geiger raster file (load raster and setup color palette for climates)
source("R_scripts\\PEST.PROFILE.KG.map.setup.R")
# Load EU27 Climate list
source("R_scripts\\PEST.PROFILE.EU27.Climate.list.R")

for(pest.name in i.pest.list)
{#TEST: pest.name <- i.pest.list[1]
  
  # create and check directories
  source("R_scripts\\PEST.PROFILE.check.pest.directories.r")
  
  # download EPPO distribution tables
  source("R_scripts\\PEST.PROFILE.web.EPPO.distribution.table.r")
  
  # download EPPO host list table (if selected in configuration file)
  if(i.eppo.host.table=="yes") 
  {
    source("R_scripts\\PEST.PROFILE.web.EPPO.host.table.r")
  }
  
  # Extract the list of climates relevant for the pest
  source("R_scripts\\PEST.PROFILE.extract.list.pest.climates.r")
  
  # load GIS layers
  source("R_scripts\\PEST.PROFILE.load.admin.boundary.layers.r")
  
  # KG pest ap
  source("R_scripts\\PEST.PROFILE.KG.pest.map.R")
  
}
