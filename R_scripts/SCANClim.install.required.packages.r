####################################################################################################
# SCAN-Clim
# Check if needed R packages are already installed and install them if needed
####################################################################################################

#options("install.lock"=FALSE)
noquote("installing required packages")
pkg <- c(#"cellranger",
         "httr",
         #"jpeg",
         "knitr",
         "lattice",
         "latticeExtra",
         "markdown",
         "terra",
         "raster",
         "rasterVis",
         "rgdal",
         #"RCurl",
         "readxl",
         #"RColorBrewer",
         "rlist",
         "rmarkdown",
         "sp",
         #"stringr",
         #"utf8",
         #"viridisLite",
         "xfun",
         "XML")

for(current.pkg in pkg)
{
  if (!current.pkg %in% installed.packages())    
  {
    
    install.packages(current.pkg,   dependencies = TRUE) #, INSTALL_opts = '--no-lock')
    
    
  }
}

# Clean environment
rm(list=ls())
gc()