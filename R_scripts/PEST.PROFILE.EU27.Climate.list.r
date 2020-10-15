if(recalculate.EU27.climate.list == TRUE)
{
  # Extract KG raster of EU27
  EU.climates.extract <- extract(x=r, y=EU27.layer)
  # Extract list of EU climates
  EU.climates <- rat$climate[sort(unique(unlist(EU.climates.extract)))]
  # remove "ET" and "Ocean" climates
  EU.climates <- EU.climates[-which(EU.climates %in% c("ET", "Ocean"))]
  
  # write file
  write.table(EU.climates, paste(input.dir, "EU27.Climate.list.csv", sep=""), row.names=FALSE, col.names = c("EU27Clim"), sep=",")
}else
{
  EU.climates <- read.csv(paste(input.dir, "EU27.Climate.list.csv", sep=""), stringsAsFactors = FALSE, header = TRUE)[,1]
}