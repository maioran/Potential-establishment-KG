
extract.climate.fun <- function(r, obs.layer.list, loc.layer)
{#TEST: r <- r;obs.layer.list <- observed.layer.list; loc.layer <- points.layer
  
  climate.list <- c()
  
  for(actual.obs.layer in c(obs.layer.list, loc.layer))
  {# actual.obs.layer <- c(obs.layer.list, loc.layer)[1]
    # From global KG map extract raster with relevant countries
    KG.map.observed.countries <- raster::extract(x=r, y=actual.obs.layer)
    # extract list of climates for the specific organism
    climate.list        <- unique(c(climate.list, levels(r)[[1]]$climate[unique(unlist(KG.map.observed.countries))]))
  }
  
  return(climate.list)
  
}

