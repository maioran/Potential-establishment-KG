extract.climate.fun <- function(r, obs.layer)
{#TEST: r <- r;obs.layer <- actual.layer.select$layer
  # From global KG map extract raster with relevant countries
  KG.map.observed.countries <- raster::extract(x=r, y=obs.layer)
  # extract list of climates for the specific organism
  pest.climates.list        <- levels(r)[[1]]$climate[unique(unlist(KG.map.observed.countries))]
  
}
