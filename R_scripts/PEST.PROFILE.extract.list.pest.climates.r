####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script extract the list of climates from the Koppen-Geiger raster using the filtered
# EPPO admin layer as a mask
####################################################################################################

if(length(list.files(paste("Data\\processed\\", pest.name, "REVIEW.Climates",sep="")))==0)
{
  # From EPPO country layer, extract only countries present in the EPPO distribution table
  world.select              <- subset(EPPO.admin.layer, EPPO_ADM %in% pest.kg.table$KG.EPPO)
  # From global KG map extract raster with relevant countries
  KG.map.observed.countries <- extract(x=r, y=world.select)
  # extract list of climates for the specific organism
  pest.climates.list        <- rat$climate[unique(unlist(KG.map.observed.countries))]
  
  # remove climates not in EU
  if(i.remove.climates.not.in.EU == "yes")
  {
    pest.climates.list <- pest.climates.list[which(pest.climates.list %in% EU.climates)]
  }
  
  climates.list.print           <- as.data.frame(pest.climates.list)
  colnames(climates.list.print) <- c("climates")
  
  write.csv(climates.list.print, paste(output.dir, pest.name, "\\Koppen-Geiger\\climate.list.table_",actual.date,".csv", sep=""), row.names=FALSE)
  rm(KG.map.observed.countries, climates.list.print)

}else
{
  climate.file.name <- list.files(paste("Data\\processed\\", pest.name, "\\REVIEW.Climates",sep=""))
  climate.file.dir  <- paste("Data\\processed\\", pest.name, "\\REVIEW.Climates\\",climate.file.name,sep="")
  pest.climates.list <- read.csv(climate.file.dir, header = TRUE, stringsAsFactors = FALSE)[[1]]
}
