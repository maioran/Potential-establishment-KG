####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script load input from configuration file
####################################################################################################

############################################################################################################################################################
# CONFIGURATION FILE
config.file <- paste0(config.dir,list.files(config.dir))
# list of authors
i.authors                        <- toString(readxl::read_xlsx(config.file, sheet = "Authors")[[1]]) 
# sheet: Pest_list
i.pest.list                      <- readxl::read_xlsx(config.file, sheet = "Pest_list")[[1]]
# sheet: Pest_status_to_be_included
i.pest.status                    <- readxl::read_xlsx(config.file, sheet = "Pest_status_to_be_included")[[1]]
# sheet: Other settings 
i.remove.climates.not.in.EU      <- readxl::read_xlsx(config.file, sheet = "Other settings")[[1,2]]
i.region.to.plot                 <- readxl::read_xlsx(config.file, sheet = "Other settings")[[2,2]]
i.recalculate.EU27.climate.list  <- readxl::read_xlsx(config.file, sheet = "Other settings")[[3,2]]
#i.eppo.host.table                <- readxl::read_xlsx(config.file, sheet = "Other settings")[[4,2]]
#i.include.protected.zones        <- readxl::read_xlsx(config.file, sheet = "Other settings")[[5,2]]
i.EPPO.token                     <- readxl::read_xlsx(config.file, sheet = "Other settings")[[5,2]]
i.report                         <- readxl::read_xlsx(config.file, sheet = "Other settings")[[6,2]]
# sheet: Climates_to_remove
i.climates.to.remove             <- readxl::read_xlsx(config.file, sheet = "Climates_to_be_removed")[[1]]
###########################################################################################################################################################
rm(config.file)

