####################################################################################################
# EFSA Koppen-Geiger climate suitability tool
# This script connect to the EPPO REST-API to download EPPO host list tables
# Table is downloaded only if specified in the confirguration file
####################################################################################################

# Connect to EPPO server and retrieve EPPO pest code
path.eppo.code    <- "https://data.eppo.int/api/rest/1.0/tools/names2codes"
response          <- httr::POST(path.eppo.code, body=list(authtoken=i.EPPO.token,intext=pest.name))
pest.eppo.code    <- strsplit(httr::content(response)[[1]], ";")[[1]][2]
if(pest.eppo.code == "****NOT FOUND*****")
{
  print("****** WARNING: PEST NAME NOT FOUND IN THE EPPO DATABASE ******")
  
}else
{
  ########### Retrieve host table from EPPO db ################
  eppo.pest.host.url <- RCurl::getURL(paste("https://gd.eppo.int/taxon/", pest.eppo.code,"/hosts", sep=""))#, .opts = list(ssl.verifypeer = FALSE))
  tables.host <- XML::readHTMLTable(eppo.pest.host.url) %>%
    rlist::list.clean( fun = is.null, recursive = FALSE)
  # /taxon/{EPPOCODE}/hosts
  pest.hosts          <- tables.host$dttable[,2:3] 
  pest.hosts$Organism <- sub("\\(.*", "", pest.hosts$Organism)
  if(any(is.na(pest.hosts$Organism)))
  {
    pest.hosts <- pest.hosts[-which(is.na(pest.hosts$Organism)),]
  }
  pest.hosts <- pest.hosts[order(pest.hosts$Organism),]
  if(any !(pest.hosts$Type %in% i.host.status))
  {
    pest.hosts <- pest.hosts[which(pest.hosts$Type %in% i.host.status),]
  }
  write.csv(pest.hosts, row.names = FALSE, paste(output.dir, pest.name, "\\Hosts\\Host.table_",current.date,".csv", sep=""))
  rm(eppo.pest.host.url, tables.host)
  
}
  


  


