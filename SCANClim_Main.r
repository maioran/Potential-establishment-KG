#####################################################################################################
#####################################################################################################
########################################## SCAN-CLim ################################################
############## Supporting Climate suitAbility aNalysis based on Climate Classifications #############
#####################################################################################################
#####################################################################################################
#####################################################################################################
# Developer: Andrea MAIORANO (ALPHA-PLH) - andrea.maiorano@efsa.europa.eu
# 
# EFSA, ALPHA Unit, PLH Team
# January 2022
#####################################################################################################
# Clean environment
rm(list=ls())
gc()
# Install needed packages if not already installed
source("R_scripts\\SCANClim.install.required.packages.r")

# current date including time (format: YYYYMMDD h_m_s)
actual.date <- format(Sys.time(), "%Y%m%d %H_%M_%S")
# load raster and sp packages
library(raster)
library(sp)
# set main directories
source("R_scripts\\SCANClim.main.directories.r")
# load inputs from configuration file 
source("R_scripts\\SCANClim.load.input.from.configuration.file.r")
# Load Köppen–Geiger raster file (load raster and setup color palette for climates)
load(paste0(data.dir, "rdata\\r_KG_raster.RData"))
# Load region coordinates for plotting map
load(paste0(data.dir, "rdata\\Coordinates.table.RData"))
# Load GAUL codes
#load(paste0(data.dir, "rdata\\FAO_GAUL_Codes.RData"))
# Load EU27 Climate list
source("R_scripts\\SCANClim.EU27.Climate.list.R")
# load EPPO admin layer
load(paste0(data.dir, "rdata\\EPPO0.layer.RData"))

for(pest.name in i.pest.list)
{#TEST: pest.name <- i.pest.list[1]  OR  pest.name <- "Amyelois transitella"
  # create and check directories
  source("R_scripts\\SCANClim.check.pest.directories.r", local = knitr::knit_global())
  # download EPPO distribution tables or load reviewed distribution table
  source("R_scripts\\SCANClim.pest.distribution.table.r", local = knitr::knit_global())
  # correction for accent for Islas Canarias
  if("Spain-Islas Canárias" %in% pest.kg.table$Observation)
  {
    pest.kg.table$Observation[which(pest.kg.table$Observation == "Spain-Islas Canárias")] <- "Spain-Islas Canarias"
    
  }
  # check if distribution table or climate list are available
  if(distr.table == TRUE || climate.available ==TRUE)
  {
    if(i.report=="yes")
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

