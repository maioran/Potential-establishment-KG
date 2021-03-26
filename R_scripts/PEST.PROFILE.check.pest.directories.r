####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script create needed folder directory for input/output related to specific pest
# Note: if the folder already exists it does not overwrite it
####################################################################################################

dir.create(file.path(output.dir, pest.name))
dir.create(file.path(review.dir, pest.name))
#dir.create(file.path(paste(data.dir, "processed\\", pest.name, sep="")))

dir.create(file.path(paste(output.dir, pest.name, sep=""), "Distribution"))
dir.create(file.path(paste(output.dir, pest.name, sep=""), "Hosts"))
dir.create(file.path(paste(output.dir, pest.name, sep=""), "Koppen-Geiger"))
dir.create(file.path(paste(review.dir, pest.name, sep=""), "REVIEW.Climates"))
dir.create(file.path(paste(review.dir, pest.name, sep=""), "REVIEW.Distribution"))

#check if files including admin names to check already exists and remove it (if needed it will be built again)
if(file.exists(paste(output.dir, pest.name, "\\Admin.names.to.check.csv", sep="")))
{
  file.remove(paste(output.dir, pest.name, "\\Admin.names.to.check.csv", sep=""))
}
  
