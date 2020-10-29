####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script load input from configuration file
####################################################################################################

i.pest.list                      <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Pest_list")[[1]]
i.pest.status                    <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Pest_status_to_be_included")[[1]]
i.host.remove                    <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Host_status_to_be_removed")[[1]]
i.region.to.plot                 <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Other settings")[[2,2]]
i.recalculate.EU27.climate.list  <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Other settings")[[3,2]]
i.map.coord.table                <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "tech", range = "A1:G50")[]
i.protected.zones                <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Protected_zones")[]
i.climates.to.remove             <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Climates_to_remove")[[1]]
i.eppo.host.table                <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Other settings")[[4,2]]

map.coord.reg                    <- i.map.coord.table[which(i.map.coord.table$Region==i.region.to.plot),]

if(readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Other settings")[[1,2]] == "yes")
{
  remove.climates.not.in.EU <- TRUE
}else
{
  remove.climates.not.in.EU <- FALSE
}