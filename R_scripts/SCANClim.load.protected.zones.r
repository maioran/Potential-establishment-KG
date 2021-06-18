####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script load the protected zones list
#
# OUTPUT of the script: 
# - i.protected.zones
protected.zone.file   <- list.files(paste("Data\\processed\\", pest.name, "\\Protected.zones\\",sep=""))

i.protected.zones     <- read.csv(paste(data.dir, "processed\\", pest.name, "\\Protected.zones\\",protected.zone.file, sep=""), header=TRUE, encoding="UTF-8", stringsAsFactors = FALSE)
