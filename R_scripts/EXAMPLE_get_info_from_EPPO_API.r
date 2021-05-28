i.EPPO.token <- "YOUR TOKEN"
pest.name    <- "PEST SCIENTIFIC NAME" # must coincide with scientific name in the EPPO db


########### PEST EPPO CODE ##############

# EPPO url ith list of pest codes
path.eppo.code    <- "https://data.eppo.int/api/rest/1.0/tools/names2codes"
# POST request on eppo database
response          <- httr::POST(path.eppo.code, body=list(authtoken=i.EPPO.token,intext=pest.name))
# get EPPO code
pest.eppo.code    <- strsplit(httr::content(response)[[1]], ";")[[1]][2]


########### PEST DISTRIBUTION TABLE ################

# EPPO URL to pest distribution
eppo.distr.url   <- paste0("https://gd.eppo.int/taxon/", pest.eppo.code,"/distribution")
# http GET request
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

# distribution table
distr.table <- tables$dttable
