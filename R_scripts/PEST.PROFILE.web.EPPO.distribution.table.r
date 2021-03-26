####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script connect to the EPPO REST-API to download pest host and distribution tables
# If a file is present in the REVIEW.Distribution table, then the file is used
####################################################################################################

# test if any file is present in the REVIEW.Distribution and in the REVIEW.Climates folder. If any file is present then connect to EPPO Global db

if(length(list.files(paste(review.dir,pest.name, "\\REVIEW.Distribution\\",sep="")))==0)
{
  # Connect to EPPO server and retrieve EPPO pest code
  path.eppo.code    <- "https://data.eppo.int/api/rest/1.0/tools/names2codes"
  response          <- httr::POST(path.eppo.code, body=list(authtoken=i.EPPO.thoken,intext=pest.name))
  pest.eppo.code    <- strsplit(httr::content(response)[[1]], ";")[[1]][2]
  
  ########### DISTRIBUTION ################
  # retrieve EPPO pest distribution table
  eppo.pest.distr.url <- RCurl::getURL(paste("https://gd.eppo.int/taxon/", pest.eppo.code,"/distribution", sep=""))#, .opts = list(ssl.verifypeer = FALSE))
  # tables <- XML::readHTMLTable(eppo.pest.distr.url) %>%
  #   rlist::list.clean(fun = is.null, recursive = FALSE)
  tables <- XML::readHTMLTable(eppo.pest.distr.url)
  tables <- rlist::list.clean(tables, fun = is.null, recursive = FALSE)
  
  # clean EPPO table
  # select according to Status
  # save full table from EPPO
  write.csv(tables$dttable, row.names = FALSE, paste(output.dir, pest.name, "\\Distribution\\Full.distribution.table_",actual.date,".csv", sep=""))
  # keep only records including only relevant EPPO pest status 
  pest.kg.table     <- tables$dttable[which(tables$dttable$Status %in% i.pest.status),]
  pest.kg.table     <- data.frame(lapply(pest.kg.table, as.character), stringsAsFactors=FALSE)[,1:4]
  
  # add supporting column for countries/states
  pest.kg.table$Observation                               <- pest.kg.table$State
  pest.kg.table$Observation[which(pest.kg.table$Observation=="")] <- pest.kg.table$Country[which(pest.kg.table$Observation=="")]
  
  # filter info according to states of big countries
  big.countries <- c("United States of America", "Brazil", "Russia", "China", "India", "Canada", "Australia")
  if(any(big.countries %in% pest.kg.table$Observation))
  {
    pest.kg.table     <- pest.kg.table[-which(pest.kg.table$Observation %in% big.countries),]
  }
  
  # add columns including administrative boundary source and level. This is needed especially in the phase of review of climates
  pest.kg.table$admin.level  <- "0"
  pest.kg.table$admin.source <- "EPPO"
  pest.kg.table$admin.code   <- NA
  pest.kg.table$lat          <- NA
  pest.kg.table$long         <- NA
  
  # save table including list of filtered distribution
  write.csv(pest.kg.table, row.names = FALSE, paste(output.dir, pest.name, "\\Distribution\\Filtered.distribution.table_",actual.date,".csv", sep=""))
  
  rm(path.eppo.code, response, eppo.pest.distr.url, tables, big.countries)
  
}else
{
  # if table with reviewed distribution is available it is loaded
  rev.distr      <- list.files(paste(review.dir,pest.name, "\\REVIEW.Distribution\\",sep=""))
  pest.kg.table  <- read.csv(paste(review.dir,pest.name, "\\REVIEW.Distribution\\", rev.distr, sep=""), stringsAsFactors = FALSE, na.strings = c("na", "NA", ""))
 rm(rev.distr)
}


