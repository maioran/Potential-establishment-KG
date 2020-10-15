
climate.colors.pest <- climate.colors
climate.colors.pest[which(!rat$climate %in% climates.list)] <- "#00000000"
rat$colors  <- climate.colors.pest

levels(r) <- rat



# map coordinate range (x1, x2, y1, y2) and grid extent (xat, yat)
x1  <- map.coord.reg$x1
x2  <- map.coord.reg$x2
y1  <- map.coord.reg$y1
y2  <- map.coord.reg$y2
xat <- map.coord.reg$xat
yat <- map.coord.reg$yat

r <- crop(r, extent(x1, x2, y1, y2))



