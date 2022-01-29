
extract.climate.fun <- function(r, obs.layer.list, loc.layer)
{#TEST: r <- r;obs.layer.list <- observed.layer.list; loc.layer <- points.layer
  
  climate.list <- c()
  
  for(actual.obs.layer in c(obs.layer.list, loc.layer))
  {# actual.obs.layer <- obs.layer.list
    # From global KG map extract raster with relevant countries
    KG.map.observed.countries <- raster::extract(x=r, y=actual.obs.layer)
    # actual.obs.layer@data$ID <- KG.map.observed.countries
    # test <- merge(actual.obs.layer@data, levels(r)[[1]], by = "ID", all.x = TRUE)
    # write.csv(test, file="02_Output\\Elasmopalpus lignosellus\\ELASI.clim.table.csv", row.names = FALSE)
    # levels(r)[[1]]
    
    # extract list of climates for the specific organism
    climate.list        <- unique(c(climate.list, raster::levels(r)[[1]]$climate[unique(unlist(KG.map.observed.countries))]))
  }
  
  return(climate.list)
  
}

