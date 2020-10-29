####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script connect to the EPPO REST-API to download pest host and distribution tables
# If a file is present in the REVIEW.Distribution table, then the file is used
####################################################################################################

# test if any file is present in the REVIEW.distribution folder. If any file is present then connect to EPPO Global db
if(length(list.files(paste("Data\\processed\\", pest.name, "REVIEW.Distribution",sep="")))==0 | 
  length(list.files(paste("Data\\processed\\", pest.name, "REVIEW.Climates",sep="")))==0)
{
  # Connect to EPPO server and retrieve EPPO pest code
  path.eppo.code    <- "https://data.eppo.int/api/rest/1.0/tools/names2codes"
  response          <- httr::POST(path.eppo.code, body=list(authtoken="61b2d7f23653e1f2e9815f14ef7bfd80",intext=pest.name))
  pest.eppo.code    <- strsplit(httr::content(response)[[1]], ";")[[1]][2]
  
  ########### DISTRIBUTION ################
  # retrieve EPPO pest distribution table
  eppo.pest.distr.url <- RCurl::getURL(paste("https://gd.eppo.int/taxon/", pest.eppo.code,"/distribution", sep=""))#, .opts = list(ssl.verifypeer = FALSE))
  tables <- XML::readHTMLTable(eppo.pest.distr.url) %>%
    rlist::list.clean( fun = is.null, recursive = FALSE)
  
  # clean EPPO table
  # select according to Status
  # save full table from EPPO
  write.csv(tables$dttable, row.names = FALSE, paste(output.dir, pest.name, "\\Distribution\\Full.distribution.table_",actual.date,".csv", sep=""))
  # keep only records including only relevant EPPO pest status 
  pest.kg.table     <- tables$dttable[which(tables$dttable$Status %in% i.pest.status),]
  pest.kg.table     <- data.frame(lapply(pest.kg.table, as.character), stringsAsFactors=FALSE)[,1:4]
  
  # add supporting column for countries/states
  pest.kg.table$KG.EPPO                                   <- pest.kg.table$State
  pest.kg.table$KG.EPPO[which(pest.kg.table$KG.EPPO=="")] <- pest.kg.table$Country[which(pest.kg.table$KG.EPPO=="")]
  
  # filter info according to states of big countries
  big.countries <- c("United States of America", "Brazil", "Russia", "China", "India", "Canada", "Australia")
  if(any(big.countries %in% pest.kg.table$KG.EPPO))
  {
    pest.kg.table     <- pest.kg.table[-which(pest.kg.table$KG.EPPO %in% big.countries),]
  }
  
  # add columns including administrative boundary source and level. This is needed especially in the phase of review of climates
  pest.kg.table$admin.level  <- "0"
  pest.kg.table$admin.source <- "eppo"
  
  # save table including list of filtered distribution
  write.csv(pest.kg.table, row.names = FALSE, paste(output.dir, pest.name, "\\Distribution\\Filtered.distribution.table_",actual.date,".csv", sep=""))
  
  rm(path.eppo.code, response, eppo.pest.distr.url, tables, big.countries)
  
}else
{
  # if table with reviewed distribution is available then use table
  pest.kg.table <- read.csv(paste(output.dir, pest.name,"\\REVIEW.Distribution\\Filtered.distribution.table_Reviewed.csv", sep=""))
}


