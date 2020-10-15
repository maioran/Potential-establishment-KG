
output.dir    <- "Output\\"
input.dir     <- "Data\\input\\"
data.dir      <- "Data\\"
kg.map.dir    <- paste(data.dir,"input\\GIS\\", sep="")

dir.create(file.path(output.dir, pest.name))
dir.create(file.path(paste(output.dir, pest.name, sep=""), "Distribution"))
dir.create(file.path(paste(output.dir, pest.name, sep=""), "Hosts"))
dir.create(file.path(paste(output.dir, pest.name, sep=""), "Koppen-Geiger"))
dir.create(file.path(paste(output.dir, pest.name, sep=""), "REVIEW.Distribution"))
dir.create(file.path(paste(output.dir, pest.name, sep=""), "REVIEW.Climates"))
