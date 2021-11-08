rm(list=ls())
gc()
library("sp")

output.dir    <- "Output\\"
input.dir     <- "Data\\input\\"
data.dir      <- "Data\\"
kg.map.dir    <- paste(data.dir,"input\\GIS\\", sep="")

# open eppo shapefile
EPPO.admin.layer <- rgdal::readOGR("Data\\input\\GIS\\EPPOadm_simplified_v03.shp", use_iconv = TRUE, encoding = "UTF-8")
# head(EPPO.admin.layer)
# remove not useful fields
# eppo.field.remove <- c("ADM1_CODE", "ADM_CODE","STR1_YEAR", "EXP1_YEAR", "DISP_AREA", "ADM2_CODE", "ADM2_NAME", 
#                        "STR0_YEAR", "EXP0_YEAR", "layer", "path", "STR2_YEAR", "EXP2_YEAR", "Continent")
# EPPO.admin.layer@data <- EPPO.admin.layer@data[,-which(colnames(EPPO.admin.layer@data) %in% eppo.field.remove)]
# rename UK and US names
#EPPO.admin.layer@data$ADM0_NAME[which(EPPO.admin.layer$ADM0_NAME=="U.K. of Great Britain and Northern Ireland")] <- "United Kingdom"
#EPPO.admin.layer@data$ADM0_NAME[which(EPPO.admin.layer$ADM0_NAME=="United States of America")] <- "United States"

# EPPO.admin.layer@data$ADM_NAME[which(is.na(EPPO.admin.layer$ADM_NAME))] <- EPPO.admin.layer@data$ADM1_NAME[which(is.na(EPPO.admin.layer$ADM_NAME))]
# remove "Sheng" and "Shi" from Chinese state names
# EPPO.admin.layer@data$ADM_NAME <- gsub(" Sheng","",EPPO.admin.layer@data$ADM_NAME)
# EPPO.admin.layer@data$ADM_NAME <- gsub(" Shi","",EPPO.admin.layer@data$ADM_NAME)
# # countries to be adjusted - empty records (er) in EPPO_ADM

# for each 'big country' compose the name using "country-state" format
# big.countries <- c("Japan", 
#                    "Indonesia", 
#                    "Russian Federation", 
#                    "United States of America",
#                    "United Kingdom",
#                    "Malaysia",
#                    "Australia",
#                    "China",
#                    "India",
#                    "Brazil", 
#                    "Canada")
# # records with big countries: bg
# bg <- which(EPPO.admin.layer@data$ADM0_NAME %in% big.countries)
# EPPO.admin.layer@data$EPPO_ADM[bg] <- paste(EPPO.admin.layer@data$ADM0_NAME[bg],
#                                     EPPO.admin.layer@data$EPPO_ADM[bg],
#                                     sep="-")
# #EPPO.admin.layer@data$EPPO_ADM[-bg] <-EPPO.admin.layer@data$EPPO_ADM[-bg]

# modify apostrophe for Cote d'Ivoire
EPPO.admin.layer@data$EPPO_ADM[which(EPPO.admin.layer@data$EPPO_ADM == "Saint-Barthélemy")] <- "Saint-Barthélemy"

save(EPPO.admin.layer, file="Data\\rdata\\EPPO0.layer.RData")
rgdal::writeOGR(EPPO.admin.layer, "Data\\input\\GIS\\EPPOadm_simplified_v03.shp", driver="ESRI Shapefile",layer="EPPOadm_simplified_v02",encoding = "UTF-8")
# write table
EPPO.table <- EPPO.admin.layer@data
EPPO.table <- EPPO.table[,c("ADM0_NAME", "ADM0_CODE",
                            "EPPO_ADM",
                            "Shape_Area")]

write.csv(EPPO.table, file="Documentation\\EPPO_Codes_and_names.csv", row.names = FALSE)

rm(list=ls())
gc()
