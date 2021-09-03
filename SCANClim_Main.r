#####################################################################################################
#####################################################################################################
########################################## SCANCLim #################################################
############## Supporting Climate suitAbility aNalysis based on Climate Classifications #############
#####################################################################################################
#####################################################################################################
#####################################################################################################
# Developer: Andrea MAIORANO (ALPHA-PLH)
# 
# EFSA, ALPHA Unit, PLH Team
# This version distributed in September 2021
#####################################################################################################

# remove comment to install needed packages
# source("R_scripts\\Tool_update_R_packages")

# Clean environment
rm(list=ls())
gc()
# load raster and sp packages
library(raster)
library(sp)
# Setting TRUE will produce an html report
report.kg <- TRUE
actual.date <- Sys.Date()
start <- Sys.time()

# set main directories
source("R_scripts\\SCANClim.main.directories.r")

# load inputs from configuration file 
source("R_scripts\\SCANClim.load.input.from.configuration.file.r")
# Load Köppen–Geiger raster file (load raster and setup color palette for climates)
load(paste(data.dir, "rdata\\r_KG_raster.RData",sep=""))
# Load region coordinates for plotting map
load(paste(data.dir, "rdata\\Coordinates.table.RData", sep=""))
# Load GAUL codes
load(paste(data.dir, "rdata\\FAO_GAUL_Codes.RData", sep=""))
# Load EU27 Climate list
source("R_scripts\\SCANClim.EU27.Climate.list.R")
# load EPPO admin layer
load(paste(data.dir, "rdata\\EPPO0.layer.RData",sep=""))

for(pest.name in i.pest.list)
{#TEST: pest.name <- i.pest.list[1]  OR  pest.name <- "Amyelois transitella"
  # create and check directories
  source("R_scripts\\SCANClim.check.pest.directories.r", local = knitr::knit_global())
  # download EPPO distribution tables or load reviewed distribution table
  source("R_scripts\\SCANClim.pest.distribution.table.r", local = knitr::knit_global())
  
  # check if distribution table or climate list are available
  if(distr.table == TRUE || climate.available ==TRUE)
  {
    if(report.kg==TRUE)
    {
      # launch rmarkdown to produce html report
      rmarkdown::render("SCANClim_Report.Rmd", params = list(
      pest.name = pest.name,
      author.list = i.authors),
      output_file = paste0(output.dir, "\\Report-", pest.name, ".html"))
    }else
    {
      source("SCANClim_basic.r")
    }
    
  }else
  {
    print(paste0("****** WARNING: COULD NOT CREATE MAP FOR ", pest.name ))
  }
  
}
# clean environment
# rm(list=ls())
# gc()
end <- Sys.time()
lag <- end-start