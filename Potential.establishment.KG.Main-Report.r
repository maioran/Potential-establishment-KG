#####################################################################################################
#####################################################################################################
############## EFSA Köppen–Geiger approach for climate suitability of pests #########################
#####################################################################################################
#####################################################################################################
# Developer: Andrea MAIORANO (ALPHA-PLH)
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
actual.date <- Sys.Date()
start.time <- Sys.time()

# install packages if needed
source("R_scripts\\PEST.PROFILE.install.required.packages.r")
# set main directories
source("R_scripts\\PEST.PROFILE.main.directories.r")
# load inputs from configuration file 
source("R_scripts\\PEST.PROFILE.load.input.from.configuration.file.r")

# Load Köppen–Geiger raster file (load raster and setup color palette for climates)
# source("R_scripts\\_PEST.PROFILE.KG.map.setup.R")
load(paste(data.dir, "rdata\\r_KG_raster.RData",sep=""))

# Load EU27 Climate list
source("R_scripts\\PEST.PROFILE.EU27.Climate.list.R")

for(pest.name in i.pest.list)
{#TEST: pest.name <- i.pest.list[1]
  
  # create and check directories
  source("R_scripts\\PEST.PROFILE.check.pest.directories.r", local = knitr::knit_global())
  
  rmarkdown::render("KG-report.Rmd", params = list(
    pest.name = pest.name,
    author.list = i.authors),
    output_file = paste0(output.dir, pest.name,"\\Report-", pest.name, ".html")
  )
  
}
end.time <- Sys.time()
time.kg <- end.time - start.time