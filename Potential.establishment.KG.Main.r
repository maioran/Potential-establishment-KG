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
start_time <- Sys.time()
r.script.dir  <- "R_scripts\\" 
# install packages if needed
source(paste(r.script.dir,"PEST.PROFILE.install.required.packages.r", sep=""))
# load inputs from configuration file
source(paste(r.script.dir,"PEST.PROFILE.load.input.from.configuration.file.r", sep=""))
# set main directories
source(paste(r.script.dir,"PEST.PROFILE.main.directories.r", sep=""))
# Setup Köppen–Geiger raster file (including climates and related colors)
source(paste(r.script.dir,"PEST.PROFILE.KG.map.setup.R", sep=""))
# Load EU27 Climate list
source(paste(r.script.dir,"PEST.PROFILE.EU27.Climate.list.R", sep=""))

for(pest.name in pest.list)
{#TEST: pest.name <- pest.list[1]
  
  # create and check directories
  source(paste(r.script.dir,"PEST.PROFILE.check.pest.directories.r", sep=""))
  
  # load GIS layers
  source(paste(r.script.dir,"PEST.PROFILE.load.admin.boundary.layers.r", sep=""))
  
  # download EPPO tables
  source(paste(r.script.dir,"PEST.PROFILE.web.EPPO.tables.r", sep=""))
  
  # Extract the list of climates relevant for the pest
  source(paste(r.script.dir,"PEST.PROFILE.extract.list.pest.climates.r", sep=""))
  
  # KG pest ap
  source(paste(r.script.dir,"PEST.PROFILE.KG.pest.map.R", sep=""))
  
}

end_time <- Sys.time()
time.script <- end_time - start_time