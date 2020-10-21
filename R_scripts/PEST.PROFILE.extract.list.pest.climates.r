####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script extract the list of climates from the Koppen-Geiger raster using the filtered
# EPPO admin layer as a mask
####################################################################################################

# From EPPO country layer, extract only countries present in the EPPO distribution table
world.select <- subset(EPPO.admin.layer, EPPO_ADM %in% pest.kg.table$KG.EPPO)
# From global KG map extract raster with relevant countries
KG.map.observed.countries <- extract(x=r, y=world.select)
# extract list of climates for the specific organism
pest.climates.list <- rat$climate[unique(unlist(KG.map.observed.countries))]

# remove climates not in EU
if(remove.climates.not.in.EU == TRUE)
{
  
  pest.climates.list <- pest.climates.list[which(pest.climates.list %in% EU.climates)]
}

climates.list.print <- as.data.frame(pest.climates.list)
colnames(climates.list.print) <- c("climates")

write.csv(climates.list.print, paste(output.dir, pest.name, "\\Koppen-Geiger\\climate.list.table_",actual.date,".csv", sep=""), row.names=FALSE)
rm(KG.map.observed.countries, climates.list.print)
