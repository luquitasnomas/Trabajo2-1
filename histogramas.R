getwd()
wdirectory <- ("E:/Desktop/DProyect/Data")
setwd("E:/Desktop/DProyect/Data")

data.drty <- paste0(wdirectory,"/Data")

gis.fname <- "Ej01-EbroPPgis.csv"

#if((require(RColorBrewer))install.packages("RColorBrewer")

setwd(data.drty)

gis <- read.csv(gis.fname)

elev <- gis[,"ELEVATION"]

gis["PCPannual"] <- rnorm(nrow(gis),mean = 700, sd = 200)

pcp <- gis[,"PCPannual"]

par(mfrow = c(3,2))

hist(gis[,"ELEVATION"], breaks = 6, main = "histograma con 6" , col = "blue")

hist(gis[,"ELEVATION"], breaks = "sturges", main = "histograma con sturges", col = "red")

hist(gis[,"ELEVATION"], breaks = 20, main = "histograma con 20", col = "green")

hist(gis[,"ELEVATION"], breaks = 50, main = "histograma con 50", col = "yellow")

hist(gis[,"ELEVATION"], breaks = 3, main = "histograma con 3", col = "orange")

hist(gis[,"ELEVATION"], breaks = 18, main = "histograma con 18", col = "black")

plot(gis[,"ELEVATION"], breaks = 6, main = "histograma con 6" , col = "blue")