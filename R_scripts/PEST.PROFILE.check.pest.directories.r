####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script create needed folder directory for input/output related to specific pest
# Note: if the folder already exists it does not overwrite it
####################################################################################################

dir.create(file.path(output.dir, pest.name))
dir.create(file.path(paste("Data\\processed\\", pest.name, sep="")))

dir.create(file.path(paste(output.dir, pest.name, sep=""), "Distribution"))
dir.create(file.path(paste(output.dir, pest.name, sep=""), "Hosts"))
dir.create(file.path(paste(output.dir, pest.name, sep=""), "Koppen-Geiger"))
dir.create(file.path(paste("Data\\processed\\", pest.name, sep=""), "REVIEW.Climates"))
dir.create(file.path(paste("Data\\processed\\", pest.name, sep=""), "REVIEW.Distribution"))

