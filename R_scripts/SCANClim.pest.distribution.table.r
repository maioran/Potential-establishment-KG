####################################################################################################
# EFSA SCAN-Clim tool
# This script connect to the EPPO REST-API to download pest host and distribution tables
# If a file is present in the REVIEW.Distribution folder, then this file is used 
####################################################################################################
# test if any file is present in the REVIEW.Climates folder
if(length(list.files(paste(review.dir,"REVIEW.Climate\\",sep="")))!=0)
{
  climate.available <- TRUE
}else
{
  climate.available <- FALSE
}

# check if any file present in Distribution folder. Otherwise it connects to EPPO
if(length(list.files(paste(review.dir,"\\REVIEW.Distribution\\",sep="")))==0)
{
  # Connect to EPPO server and retrieve EPPO pest code.
  # EPPO token is needed and need to be saved in the configuration file
  path.eppo.code    <- "https://data.eppo.int/api/rest/1.0/tools/names2codes"
  response          <- httr::POST(path.eppo.code, body=list(authtoken=i.EPPO.token,intext=pest.name))
  pest.eppo.code    <- strsplit(httr::content(response)[[1]], ";")[[1]][2]
  
  if(pest.eppo.code == "****NOT FOUND*****")
  {
    print("****** WARNING: PEST NAME NOT FOUND IN THE EPPO DATABASE ******")
    distr.table <- FALSE
  }else
  {
    ########### DISTRIBUTION ################
    # retrieve EPPO pest distribution table
    # http GET request on the EPPO URL
    eppo.distr.url   <- paste0("https://gd.eppo.int/taxon/", pest.eppo.code,"/distribution")
    eppo.get.request <- httr::GET(eppo.distr.url,
                                  query = list(
                                    apikey=i.EPPO.token,
                                    details = "true"
                                  ))
    # parse results
    table_content    <- httr::content(eppo.get.request, as = 'text')
    # get table and clean list
    tables           <- XML::readHTMLTable(table_content)
    tables           <- rlist::list.clean(tables, fun = is.null, recursive = FALSE)
    
    if(length(tables) != 0)
    {
      # save full table from EPPO
      write.csv(tables$dttable, row.names = FALSE, paste(output.dir, "\\Distribution\\Full.distribution.table_",actual.date,".csv", sep=""))
      # keep only records including only relevant EPPO pest status 
      pest.kg.table     <- tables$dttable[which(tables$dttable$Status %in% i.pest.status),]
      pest.kg.table     <- pest.kg.table[order(pest.kg.table$Country),]
      # In the case of big countries (e.g. US, Canada, Australia, China...), if many entries exist 
      # with further indication of states (e.g. Alabama in US) remove the first record
      # which includes only the name of the country 
      record.remove <- c()
      for(i in 2:nrow(pest.kg.table))
      {#i=8
        if(pest.kg.table$Country[i] == pest.kg.table$Country[i-1] &
           pest.kg.table$State[i-1]=="")
        {
          record.remove <- c(record.remove, i-1)
        }
        
      }
      # remove records (see above)
      if(!is.null(record.remove))
      {
        pest.kg.table <- pest.kg.table[-record.remove,]
      }
      # make sure that columns are type "character"
      pest.kg.table     <- data.frame(lapply(pest.kg.table, as.character), stringsAsFactors=FALSE)[,1:4]
      pest.kg.table$Observation <- NA
      pest.kg.table[which(pest.kg.table$State!=""),"Observation"] <- paste(pest.kg.table$Country[which(pest.kg.table$State!="")],
                                                                            pest.kg.table$State[which(pest.kg.table$State!="")],
                                                                            sep="-")
      pest.kg.table[which(pest.kg.table$State==""),"Observation"] <- pest.kg.table$Country[which(pest.kg.table$State=="")]
      
      # Add columns including administrative boundary source and level. 
      # They are needed in the review phase (if done)
      pest.kg.table$admin.source <- "EPPO"
      pest.kg.table$admin.level <- 0
      pest.kg.table$admin.code   <- NA
      pest.kg.table$lat          <- NA
      pest.kg.table$long         <- NA
      
      # save table including list of filtered distribution
      write.csv(pest.kg.table, row.names = FALSE, paste(output.dir, "\\Distribution\\Filtered.distribution.table_",actual.date,".csv", sep=""))
      # remove not needed variables
      rm(path.eppo.code, response, eppo.pest.distr.url, tables, record.remove)
      distr.table <- TRUE
    }else
    {
      # warning in the case distribution table is not present in the EPPO database
      print(paste0("****** WARNING: Distribution table for ", pest.name, " not available in the EPPO database"))
      distr.table <- FALSE
    }
    
  }
  
  
}else
{
  
 # if table with reviewed distribution is available it is loaded
  rev.distr      <- list.files(paste(review.dir,"\\REVIEW.Distribution\\",sep=""))
  pest.kg.table  <- read.csv(paste(review.dir,"\\REVIEW.Distribution\\", rev.distr, sep=""), stringsAsFactors = FALSE, na.strings = c("na", "NA", ""))
  
  if("Uncertain" %in% colnames(pest.kg.table))
  {
    if(any(pest.kg.table$Uncertain == "x"))
    {
      uncertain.records <- which(pest.kg.table$Uncertain == "x")
      uncertain.table   <- pest.kg.table[uncertain.records,]
      pest.kg.table     <- pest.kg.table[-uncertain.records,]
    }
  }
  
  
  if(any(grepl('ï..', colnames(pest.kg.table), fixed = TRUE)))
  {
   colnames(pest.kg.table) <- gsub('ï..', '', colnames(pest.kg.table))
  }
  distr.table <- TRUE
   
  pest.kg.table$admin.level <- NA
  
  
 
  if(any(pest.kg.table$admin.source == "EPPO", na.rm=TRUE))
  {
    eppo.records <- which(pest.kg.table$admin.source == "EPPO")
    pest.kg.table$admin.level[eppo.records] <- 0
    rm(eppo.records)
  }
  if(any(pest.kg.table$admin.source == "FAO.GAUL", na.rm=TRUE))
  {
    fao.records <- which(pest.kg.table$admin.source == "FAO.GAUL")
    pest.kg.table$admin.level[fao.records] <- gaul.level.table$GAUL_level[match(pest.kg.table$admin.code[fao.records], gaul.level.table$GAUL_code)]
  }
 
  rm(rev.distr)
}


