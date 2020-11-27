# Function to create administrative units layers: 
# - create layers including administrative units where pest was observed
# - list of administrative units that were not found due to spelling mistakes, different naming conventions, different enconding, ...

# INPUT:
# - admin.layer: a vector layer of administrative units
# - admin.level: the administrative unit level (EU NUTS 0, 1, 2, 3; FAO GAUL 0,1,2; EPPO 0)
# - admin.source: EU.NUTS, FAO.GAUL, EPPO
# - fltrs.distr.table: a table including the list of admin units to be inlcuded in the output layer

# OUTPUT:
# a list including a vector layer with the administrative units inlcuded in fltrd.distr.table
# a vector including the list of administrative units that were not recognised
admin.layer.fun <- function(admin.layer, admin.level, admin.source, fltrd.distr.table)
{#TEST: admin.layer <- actual.layer; fltrd.distr.table <- pest.kg.table.level.fltr; admin.source <- "EU.NUTS"
  admin.units.not.available <- c()
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
  if(length(fltrd.distr.table$KG.EPPO[!(fltrd.distr.table$KG.EPPO %in% admin.layer@data[,name.field])])>0)
  {
    # list of admin units not present in layer attribute table ......................................(for which also the admin code is not available)
    admin.name.not.available <- fltrd.distr.table$KG.EPPO[!(fltrd.distr.table$KG.EPPO %in% admin.layer@data[,name.field])]
    
    # for the admin units for which there is no record in layer attribute table, check if ID code is present in the observation table
    for(admin.name.na in admin.name.not.available)
    {#TEST: admin.name.na <- admin.name.not.available[1]
      
      admin.index <- which(admin.name.na %in% fltrd.distr.table$KG.EPPO)
      
      if(is.na(fltrd.distr.table$admin.code[admin.index]))
      { #if ID code 
        admin.units.not.available <- c(admin.units.not.available, admin.name.na)
      }else
      {
        fltrd.distr.table$KG.EPPO[admin.index] <- admin.layer@data[,name.field][which(admin.layer@data[,id.field] == fltrd.distr.table$admin.code[admin.index])]
      }
      
    }
    
  }
  
  # from the main layer, create a layer with only the administrative units where pest was observed
  actual.layer.select <- raster::subset(admin.layer, admin.layer@data[,name.field] %in% fltrd.distr.table$KG.EPPO)
  
  admin.layer.output <- list(layer = actual.layer.select, units.na = admin.units.not.available)
  
  return(admin.layer.output)
  
}