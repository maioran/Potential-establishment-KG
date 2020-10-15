#################################################################################################################


# directories
# main.dir <- "C:\\Users\\maioran\\Documents\\"
# data.dir <- paste(main.dir,"Data\\", sep="")
# r.dir    <- paste(main.dir, "Rscripts\\", sep="")
kg.country.eppo.table <- read.csv(paste(input.dir, "kg.country.table.eppo.csv", sep=""), stringsAsFactors = FALSE)

table.climate.list <- kg.country.eppo.table[which(kg.country.eppo.table$State.eppo %in% pest.kg.table$KG.EPPO),]

climates.select <- table.climate.list %>%
  summarize_at(colnames(table.climate.list)[5:35], funs(sum))
climates.list <- colnames(climates.select)[which(climates.select[1,] > 0)]



if(remove.climates.not.in.EU == TRUE)
{
  kg.country.eppo.table.eu <- kg.country.eppo.table[which(!is.na(kg.country.eppo.table$EU)),]
  
  climates.select.eu <- kg.country.eppo.table.eu %>%
    summarize_at(colnames(kg.country.eppo.table.eu)[5:35], funs(sum))
  climates.list.eu <- colnames(climates.select.eu)[which(climates.select.eu[1,] > 0)]
  climates.list <- climates.list[which(climates.list %in% climates.list.eu)]
}

climates.list.print <- as.data.frame(climates.list)
colnames(climates.list.print) <- c("climates")

write.csv(climates.list.print, paste(output.dir, pest.name, "\\Koppen-Geiger\\climate.list.table_",actual.date,".csv", sep=""), row.names=FALSE)
