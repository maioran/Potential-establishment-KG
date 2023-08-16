rm(list=ls())
gc()
coordinate.table <- as.data.frame(matrix(data=NA, nrow = 0, ncol=12))

#Region	        Region               x1 	 x2	   y1	  y2	xat	 yat  cex.leg  print.w   print.h  efsa.x  efsa.y   legend.position
Global        <- c("Global"       ,-180,	180,  -60,  90,	 20,	10,     0.7,      30,       15,   -175,    -50,  "top")
America       <- c("America"      ,-180,	-20,  -60,  90,  10,	10,     0.6,      20,       18,   -175,    -50,  "right")
Asia	        <- c("Asia"         ,  30,	180,  -25,  90,  20,  10,     0.7,      28,       20,   -175,    -50,  "right")
Australia	    <- c("Australia"    , 105,	160,  -50,  -5,   5,   5,     0.7,      20,       16,   -175,    -50,  "right")
Caribbean	    <- c("Caribbean"    , -90,	-60,	 10,	25,	  5,	 5,     0.5,      20,       12,   -175,    -50,  "top")
Europe	      <- c("Europe"       , -30,	 50,	 30,	75,	 10,	 5,     0.5,      18,       15,    -28,     33,  "right")
USA_noAlaska	<- c("USA_noAlaska" ,-130,	-65,	 20,	55,	  5,	 5,     0.5,      21,       12,    -58,     23,  "right")
Peru	        <- c("Peru"         , -85,	-65,	-20,	 5,	  5,	 5,     0.7,      20,       24,    -83,    -18,  "right")
Asia_SE       <- c("Asia_SE"      ,  90,	160,	-25,	35,	  5,   5,     0.5,      18,       15,    -23,     33,  "right")
China         <- c("China"        ,  70,	140,   10,	55, 	5,	 5,     0.5,      18,       13,    -23,     33,  "top")
China_SE      <- c("China_SE"     ,  70,	130, 	  5,	40,	  5, 	 5,     0.6,      21,       15,   -175,    -50,  "top")
California    <- c("California"   ,-125, -110,   30,  42,   5,   2,     0.7,      24,       20,   -124,     31,  "right")
North_America <- c("North_America",-180,	-45,    0,  90,  10,	10,     0.6,      25,       16,   -175,    -50,  "right")
South_America <- c("South_America", -90,	-25,  -60,  20,  10,	10,     0.5,      13,       14,   -175,    -50,  "right")
EPPO_region   <- c("EPPO_region"  , -30,	180,	 25,	90,	 20,	10,     0.7,      35,       20,    -28,     33,  "right")

regions <- list(Global, America, Asia,Australia,Caribbean, Europe, USA_noAlaska, Peru, Asia_SE, China, China_SE, California, North_America, South_America, EPPO_region)

for(region in 1:length(regions))
{# region <- regions[[1]]
  coordinate.table <- rbind(coordinate.table, as.list(regions[[region]]))
}
colnames(coordinate.table) <- c("Region","x1", "x2", "y1", "y2", "xat", "yat", "cex.legend", "print.width", "print.heigth", "efsa.x", "efsa.y", "legend.pos")
coordinate.table[,2:12] <- sapply(coordinate.table[,2:12],as.numeric)

save(coordinate.table, file="Data\\rdata\\Coordinates.table.RData")

rm(list=ls())
gc()