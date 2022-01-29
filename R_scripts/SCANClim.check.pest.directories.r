####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script create needed folder directory for input/output related to specific organism
# Note: if the folder already exists it does not overwrite it
####################################################################################################
noquote("Creating/checking pest specific directories")
# create pest main folder
suppressWarnings(dir.create(file.path(pest.dir, pest.name)))
# create subfolder Output and Review
suppressWarnings(dir.create(file.path(pest.dir, pest.name, "\\Output")))
suppressWarnings(dir.create(file.path(pest.dir, pest.name, "\\Review")))
# assign variables to output and review directories
suppressWarnings(output.dir    <- paste0(pest.dir, pest.name, "\\Output\\"))
suppressWarnings(review.dir    <- paste0(pest.dir, pest.name, "\\Review\\"))
# create subfolder Distribution
suppressWarnings(dir.create(file.path(paste0(output.dir, "Distribution"))))
# create subfolder Koppen-Geiger
suppressWarnings(dir.create(file.path(paste0(output.dir, "Koppen-Geiger"))))
# create subfolder including GIS layers
suppressWarnings(dir.create(file.path(paste0(output.dir, "GIS"))))
# create subfolders Climates and Distribution in Review folder
suppressWarnings(dir.create(file.path(paste0(review.dir, "REVIEW.Climates"))))
suppressWarnings(dir.create(file.path(paste0(review.dir, "REVIEW.Distribution"))))
# check if warning file including admin names to check already exists and remove it (if needed it will be built again)
if(file.exists(paste0(output.dir, "\\Admin.names.to.check.csv")))
{
  file.remove(paste0(output.dir, "\\Admin.names.to.check.csv"))
}

