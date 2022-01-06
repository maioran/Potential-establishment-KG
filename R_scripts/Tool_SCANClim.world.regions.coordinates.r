rm(list=ls())
gc()
coordinate.table <- as.data.frame(matrix(data=NA, nrow = 0, ncol=12))

#Region	        Region         x1 	 x2	   y1	  y2	xat	 yat  cex.leg  print.w   print.h  efsa.x  efsa.y
Global     <- c("Global"    ,-180,	180,  -60,  90,	 20,	10,     0.7,      30,       15,   -175,    -50)
America    <- c("America"   ,-180,	-20,  -60,  90,   5,	 5,     0.4,      15,       15,   -175,    -50)
Asia	     <- c("Asia"      ,  30,	180,  -25,  90,  20,  10,     0.7,      30,       15,   -175,    -50)
Australia	 <- c("Australia" ,  80,	180,  -50,  20,   5,   5,     0.7,      30,       15,   -175,    -50)
Caribbean	 <- c("Caribbean" , -90,	-70,	 15,	25,	  5,	 5,     0.7,      30,       15,   -175,    -50)
Europe	   <- c("Europe"    , -30,	 50,	 35,	75,	  5,	 5,     0.5,      18,       15,    -23,     33)
Oceania	   <- c("Oceania"   , 110,	180,	-55,	 5,	  5,	 5,     0.7,      30,       15,   -175,    -50)
USA	       <- c("USA"       ,-130,	-50,	 20,	65,	  5,	 5,     0.7,      30,       15,   -175,    -50)
Peru	     <- c("Peru"      , -85,	-65,	-20,	 5,	  5,	 5,     0.7,      30,       15,   -175,    -50)
Asia_SE    <- c("Asia_SE"   ,  90,	160,	-25,	35,	  5,   5,     0.5,      16,       15,    -23,     33)
China      <- c("China"     ,  70,	140,   10,	55, 	5,	 5,     0.5,      18,       13,    -23,     33)
China_SE   <- c("China_SE"  ,  70,	130, 	  5,	40,	  5, 	 5,     0.6,      21,       15,   -175,    -50)
California <- c("California",-125, -110,   30,  42,   5,   2,     0.7,      24,       20,   -124,     31)

regions <- list(Global, America, Asia,Australia,Caribbean, Europe, Oceania, USA, Peru, Asia_SE, China, China_SE, California  )

for(region in 1:length(regions))
{# region <- regions[[1]]
  coordinate.table <- rbind(coordinate.table, as.list(regions[[region]]))
}
colnames(coordinate.table) <- c("Region","x1", "x2", "y1", "y2", "xat", "yat", "cex.legend", "print.width", "print.heigth", "efsa.x", "efsa.y")
coordinate.table[,2:12] <- sapply(coordinate.table[,2:12],as.numeric)

save(coordinate.table, file="Data\\rdata\\Coordinates.table.RData")

rm(list=ls())
gc()