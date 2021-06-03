unlink("C:/Program Files/R/R-4.0.5/library/00LOCK", recursive = TRUE)
unlink("C:/apps/mylibs", recursive = TRUE)
update.packages(ask = FALSE, checkBuilt = TRUE)

pkg <- c("cellranger",
         "httr",
         "jpeg",
         "knitr",
         "lattice",
         "latticeExtra",
         "markdown",
         "raster",
         "rasterVis",
         "RCurl",
         "readxl",
         "RColorBrewer",
         "rlist",
         "rmarkdown",
         "sp",
         "stringr",
         "utf8",
         "viridisLite",
         "XML")

for(current.pkg in pkg)
{
  if (!require(current.pkg))    install.packages(current.pkg,   dependencies = TRUE) #, INSTALL_opts = '--no-lock')
}