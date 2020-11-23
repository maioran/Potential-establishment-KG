
extract.climate.fun <- function(r, obs.layer.list, loc.layer)
{#TEST: r <- r;obs.layer.list <- observed.layer.list; loc.layer <- location.layer
  
  climate.list <- c()
  
  for(actual.obs.layer in obs.layer.list)
  {# actual.obs.layer <- obs.layer.list[[1]]
    # From global KG map extract raster with relevant countries
    KG.map.observed.countries <- raster::extract(x=r, y=actual.obs.layer)
    # extract list of climates for the specific organism
    climate.list        <- c(climate.list, levels(r)[[1]]$climate[unique(unlist(KG.map.observed.countries))])
  }
  
  if(!is.na(loc.layer))
  
}













KG.map.observed.countries <- raster::extract(x=r, y=world.select)
# extract list of climates for the specific organism
pest.climates.list        <- rat$climate[unique(unlist(KG.map.observed.countries))]