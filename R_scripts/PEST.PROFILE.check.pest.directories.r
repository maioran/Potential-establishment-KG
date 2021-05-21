####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script create needed folder directory for input/output related to specific pest
# Note: if the folder already exists it does not overwrite it
####################################################################################################
dir.create(file.path(pest.dir, pest.name))
dir.create(file.path(pest.dir, pest.name, "\\Output"))
dir.create(file.path(pest.dir, pest.name, "\\Review"))
output.dir    <-  paste0(pest.dir, pest.name, "\\Output\\")
review.dir    <- paste0(pest.dir, pest.name, "\\Review\\")

#dir.create(file.path(paste(data.dir, "processed\\", pest.name, sep="")))

dir.create(file.path(paste0(output.dir, "Distribution")))
#dir.create(file.path(paste(output.dir, pest.name, sep=""), "Hosts"))
dir.create(file.path(paste0(output.dir, "Koppen-Geiger")))
dir.create(file.path(paste0(review.dir, "REVIEW.Climates")))
dir.create(file.path(paste0(review.dir, "REVIEW.Distribution")))

#check if files including admin names to check already exists and remove it (if needed it will be built again)
if(file.exists(paste(output.dir, "\\Admin.names.to.check.csv", sep="")))
{
  file.remove(paste(output.dir, "\\Admin.names.to.check.csv", sep=""))
}
  
