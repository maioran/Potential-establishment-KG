####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script extract the list of climates from the Koppen-Geiger raster using the filtered
# EPPO admin layer as a mask
####################################################################################################

# generate layers for observed distribution according to admin source and level present in the distribution table
# Admin source can be: EPPO (only level 0), EU.NUTS (levels 0,2,3), FAO.GAUL (levels 0, 1 ,2), location (in this case the coordinates should be indicated)
# extract climates only if climate review is not available

if(length(list.files(paste("Data\\processed\\", pest.name, "REVIEW.Climates",sep="")))==0)
{
  actual.climate.list <- extract.climate.fun(r, observed.layer.list, location.layer)
}




if(length(list.files(paste("Data\\processed\\", pest.name, "REVIEW.Climates",sep="")))==0)
{
  
    # From EPPO country layer, extract only countries present in the EPPO distribution table
  EPPO.world.select         <- subset(EPPO.admin.layer, EPPO_ADM %in% pest.kg.table$KG.EPPO)
  # From global KG map extract raster with relevant countries
  KG.map.observed.countries <- raster::extract(x=r, y=world.select)
  # extract list of climates for the specific organism
  pest.climates.list        <- rat$climate[unique(unlist(KG.map.observed.countries))]
  
  # remove climates not in EU
  if(i.remove.climates.not.in.EU == "yes")
  {
    pest.climates.list <- pest.climates.list[which(pest.climates.list %in% EU.climates)]
  }
  
  # put data in table to save csv file
  climates.list.print           <- as.data.frame(pest.climates.list)
  colnames(climates.list.print) <- c("climates")
  write.csv(climates.list.print, paste(output.dir, pest.name, "\\Koppen-Geiger\\climate.list.table_",actual.date,".csv", sep=""), row.names=FALSE)
  rm(KG.map.observed.countries, climates.list.print)

}else
{
  climate.file.name  <- list.files(paste("Data\\processed\\", pest.name, "\\REVIEW.Climates",sep=""))
  climate.file.dir   <- paste("Data\\processed\\", pest.name, "\\REVIEW.Climates\\",climate.file.name,sep="")
  pest.climates.list <- read.csv(climate.file.dir, header = TRUE, stringsAsFactors = FALSE)[[1]]
}
