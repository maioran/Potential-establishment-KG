####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script extract the list of climates from the Koppen-Geiger raster using the filtered
# EPPO admin layer as a mask
####################################################################################################

# generate layers for observed distribution according to admin source and level present in the distribution table
# Admin source can be: EPPO (only level 0), EU.NUTS (levels 0,2,3), FAO.GAUL (levels 0, 1 ,2)
# extract climates only if climate review is not available

layer.list <- list()

for(admin.source in unique(pest.kg.table$admin.source))
{# TEST: admin.source <- "EPPO"
  # filter on admin source
  pest.kg.table.source.fltr <- pest.kg.table[which(pest.kg.table$admin.source == admin.source),]
  
  for(admin.level in unique(pest.kg.table.filtered$admin.level))
  {# TEST: admin.level <- 0
    pest.kg.table.level.fltr <- pest.kg.table.source.fltr[which(pest.kg.table.source.fltr$admin.level == admin.level),]
    
    # load actual layer
    actual.layer <- get(load(paste(data.dir, "rdata\\", admin.source, admin.level,".layer.RData",sep="")))
    
    # create a layer including only the relevant administrative units
    actual.layer.select <- admin.layer.fun(actual.layer, admin.level, admin.source, pest.kg.table.level.fltr)
    
    
    
    if(length(list.files(paste("Data\\processed\\", pest.name, "REVIEW.Climates",sep="")))==0)
    {
      FUNCTION:extract climate
    }
    
  }
  
}


admin.layer.fun <- function(admin.layer, admin.level, admin.source, fltrd.distr.table)
{#TEST: admin.layer <- actual.layer; fltrd.distr.table <- pest.kg.table.level.fltr
  
  if(admin.source == "EPPO")
  {
    name.field <- "EPPO_ADM"
    id.field   <- "ADM1_CODE"
  }
  if(admin.source == "FAO.GAUL")
  {
    name.field <- paste("ADM", admin.level, "_NAME", sep="")
    id.field   <- paste("ADM", admin.level, "_CODE", sep="")
  }
  if(admin.source == "EU.NUTS")
  {
    name.field <- "NUTS_NAME"
    id.field   <- "NUTS_ID"
  }
  
  # check if any admin unit name is not present in the map layer (due to spelling mistakes, different names, different encoding, etc...)
  if(any(!(fltrd.distr.table$KG.EPPO %in% as.character(admin.layer@data[,name.field]))))
  {
    # takes the position in the distribution table of the administrative units not present in layer
    na.admin.units <- which((!(fltrd.distr.table$KG.EPPO %in% as.character(admin.layer@data[,name.field]))))
    
    # list of admin units for which also the admin code is not available 
    adnim.units.not.available <- fltrd.distr.table$KG.EPPO[which(is.na(fltrd.distr.table$admin.code[na.admin.units]))]
    
    # for the admin units for which there is an admin code, substitute the admin name with the one in the map layer
    #TEST: fltrd.distr.table$admin.code[which(fltrd.distr.table$KG.EPPO == "Jilin")] <- "915"
    #TEST: fltrd.distr.table$admin.code[which(fltrd.distr.table$KG.EPPO == "Jiangsu")] <- "913"
    if(length(which(!is.na(fltrd.distr.table$admin.code[na.admin.units])))!=0)
    {
      for(admin.index in which(!is.na(fltrd.distr.table$admin.code[na.admin.units])))
      {# table.index <- 3
        fltrd.distr.table$KG.EPPO[admin.index] <- as.character(admin.layer@data[,name.field][which(admin.layer@data[,id.field] == fltrd.distr.table$admin.code[admin.index])])
      }
      
    }
      
    
  }
  
  actual.layer.select <- subset(admin.layer, EPPO_ADM %in% fltrd.distr.table$KG.EPPO)
  actual.layer.select <- admin.layer[admin.layer@data[,name.field] %in% fltrd.distr.table$KG.EPPO,]
  plot(actual.layer.select)
}



if(length(list.files(paste("Data\\processed\\", pest.name, "REVIEW.Climates",sep="")))==0)
{
  
  
  
  
  
  
  # From EPPO country layer, extract only countries present in the EPPO distribution table
  EPPO.world.select         <- subset(EPPO.admin.layer, EPPO_ADM %in% pest.kg.table$KG.EPPO)
  # From global KG map extract raster with relevant countries
  KG.map.observed.countries <- extract(x=r, y=world.select)
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
