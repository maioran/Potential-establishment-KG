# open eppo shapefile
EPPO.admin.layer <- rgdal::readOGR("Data\\input\\GIS\\EPPOadm_simplified.shp", use_iconv = TRUE, encoding = "UTF-8")
# head(EPPO.admin.layer)
# remove not useful fields
eppo.field.remove <- c("STR1_YEAR", "EXP1_YEAR", "STATUS", "DISP_AREA", "Shape_Leng", 
                       "STR0_YEAR", "EXP0_YEAR", "layer", "path", "STR2_YEAR", "EXP2_YEAR")
EPPO.admin.layer@data <- EPPO.admin.layer@data[,-which(colnames(EPPO.admin.layer@data) %in% eppo.field.remove)]
# rename UK and US names
EPPO.admin.layer@data$ADM0_NAME[which(EPPO.admin.layer$ADM0_NAME=="U.K. of Great Britain and Northern Ireland")] <- "United Kingdom"
#EPPO.admin.layer@data$ADM0_NAME[which(EPPO.admin.layer$ADM0_NAME=="United States of America")] <- "United States"
EPPO.admin.layer@data$ADM_NAME[which(is.na(EPPO.admin.layer$ADM_NAME))] <- EPPO.admin.layer@data$ADM1_NAME[which(is.na(EPPO.admin.layer$ADM_NAME))]
# remove "Sheng" and "Shi" from Chinese state names
EPPO.admin.layer@data$ADM_NAME <- gsub(" Sheng","",EPPO.admin.layer@data$ADM_NAME)
EPPO.admin.layer@data$ADM_NAME <- gsub(" Shi","",EPPO.admin.layer@data$ADM_NAME)
# for each 'big country' compose the name using "country-state" format
big.countries <- c("Japan", 
                   "Indonesia", 
                   "Russian Federataion", 
                   "United States of America",
                   "United Kingdom",
                   "Malaysia",
                   "Australia",
                   "China",
                   "India",
                   "Brazil", 
                   "Canada")
# records with big countries: bg
bg <- which(EPPO.admin.layer@data$ADM0_NAME %in% big.countries)
EPPO.admin.layer@data$EPPO_ADM[bg] <- paste(EPPO.admin.layer@data$ADM0_NAME[bg],
                                    EPPO.admin.layer@data$ADM_NAME[bg],
                                    sep="-")
EPPO.admin.layer@data$EPPO_ADM[-bg] <-EPPO.admin.layer@data$ADM0_NAME[-bg]

# modify apostrophe for Cote d'Ivoire
EPPO.admin.layer@data$EPPO_ADM[which(EPPO.admin.layer@data$EPPO_ADM == "Cote d’Ivoire")] <- "Cote d'Ivoire"

save(EPPO.admin.layer, file="Data\\rdata\\EPPO0.layer.RData")

# # 
# bg <- which(EPPO.admin.layer@data$ADM0_NAME == "Canada")
# EPPO.admin.layer@data[91,]
# grep("Cote",EPPO.admin.layer@data$ADM0_NAME)
