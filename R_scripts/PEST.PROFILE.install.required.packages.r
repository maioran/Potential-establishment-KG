####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script check if needed R packages are installed and install if needed
# The dplyr package is loaded anyway
####################################################################################################

if (!require("httr"))          install.packages("httr")
if (!require("knitr"))         install.packages("knitr")
if (!require("latticeExtra"))  install.packages("latticeExtra")
if (!require("rmarkdown"))     install.packages("rmarkdown")
if (!require("markdown"))      install.packages("markdown")
if (!require("raster"))        install.packages("raster")
if (!require("rasterVis"))     install.packages("rasterVis")
if (!require("readxl"))        install.packages("readxl")
if (!require("RCurl"))         install.packages("RCurl")
if (!require("sp"))            install.packages("sp")
if (!require("rlist"))         install.packages("rlist")
if (!require("XML"))           install.packages("XML")