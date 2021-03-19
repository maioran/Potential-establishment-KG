####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script check if needed R packages are installed and install if needed
# The dplyr package is loaded anyway
####################################################################################################

if (!require("dplyr"))      install.packages("dplyr")
library("dplyr")
if (!require("httr"))       install.packages("httr")
if (!require("rlist"))      install.packages("rlist")
if (!require("XML"))        install.packages("XML")
if (!require("readxl"))     install.packages("readxl")
if (!require("rgdal"))      install.packages("rgdal")
if (!require("raster"))     install.packages("raster")
if (!require("rasterVis"))  install.packages("rasterVis")
if (!require("sp"))         install.packages("sp")
if (!require("RCurl"))      install.packages("rCurl")
if (!require("officedown")) install.packages("officedown")
if (!require("officer"))    install.packages("officer")
if (!require("knitr"))      install.packages("knitr")