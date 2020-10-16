pest.list                      <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Pest_list")[[1]]
pest.status                    <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Pest_status_to_be_included")[[1]]
host.remove                    <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Host_status_to_be_removed")[[1]]
region.to.plot                 <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Other settings")[[2,2]]
recalculate.EU27.climate.list  <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Other settings")[[3,2]]
map.coord.table                <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "tech", range = "A1:G50")[]
protected.zones                <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Protected_zones", range = "A1:E100")[]
climates.to.remove             <- readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Climates_to_remove")[[1]]

map.coord.reg                  <- map.coord.table[which(map.coord.table$Region==region.to.plot),]

if(readxl::read_xlsx("Potential.establishment.KG_Configuration.xlsx", sheet = "Other settings")[[1,2]] == "yes")
{
  remove.climates.not.in.EU <- TRUE
}else
{
  remove.climates.not.in.EU <- FALSE
}