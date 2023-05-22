#Trabajo Práctico Dos

#Ver si está el paquete instalado
if (!require(readr)) {
  install.packages("readr")
}
library(readr)

#Establecer lugar de trabajo
getwd()
wdirectory <- ("C:/Users/Flavio/Documents/GitHub/Trabajo2")
setwd(wdirectory)

# Definir el nombre del archivo
archivo_zip <- "cr2_prDaily_2018.zip"

# Definir la url de descarga
url <-
  "https://www.cr2.cl/download/cr2_prdaily_2018-zip/?wpdmdl=15135"


# Comprobar si el archivo existe
if (!file.exists(archivo_zip)) {
  # Si no existe, descargarlo
  download.file(url, archivo_zip)
}
# Descomprimir el archivo zip
unzip(archivo_zip)
# Verificar si el archivo csv existe
file.exists("cr2_prDaily_2018/cr2_prDaily_2018.csv")


data_raw <- read_csv(file.choose(), col_names = TRUE)
#ruta al archivo csv y datos generales del csv
ls()
head(data_raw)

# Leer el código de identificación de la estación pluviométrica

estacionID<-readline(prompt = "Ingrese el código de identificación de la estación pluviométrica: ")
estacionID #Notar que ya lo guarda como " " 

#mostrar la informacion general de la Estación ID
descripcionID <- data_raw[1:14, c("codigo_estacion", estacionID)]

descripcionID
#ahora se selecciona las mediciones de la base de datos para hacer EDA.


data_elegida<-data_raw[-c(1:14), c("codigo_estacion", estacionID)]#Descarta las primeras catorce filas
#y las fechas con los datos de la columna estacionID
data_na<- replace(data_elegida, data_elegida == -9999, NA) #cambia los -9999 por NA
data_na
#Extraer los na de data_na
data_limpia <- na.omit(data_na)


#####EDA###########
################
es.faltante <- is.na(data_na) 
sum(es.faltante) #datos faltantes

#opcional
#na.index <- which(es.faltante)
#dates[na.index] #fechas de cuales son los datos faltantes

#número de datos válidos
datos_validos <- !is.na(es.faltante)
sum(datos_validos)
#summary, sd y IQR
summary(data_limpia)
sd(data_limpia$estacionID)
IQR(data_limpia$estacionID)





#series temporales
#Ver si está el paquete instalado
if (!require(hydroTSM)) {
  install.packages("hydroTSM")
}
library(hydroTSM)


date.ini <-paste0("La fecha inicial de la estaciónID ingresada es: ", data_limpia[1,"codigo_estacion"])  
date.fin <-paste0("La fecha final de la estaciónID ingresada es: ", data_limpia[nrow(data_limpia), "codigo_estacion"])
date.ini
date.fin

# Convierte las fechas a objetos de clase "Date"
data_na$estacionID <- as.Date(data_na$estacionID)

# Crea una serie temporal con los datos
serie_temporal <- as.timeSeries(data_na[, -1], dates = data_na$estacionID)


# Métricas diarias
daily_stats <- data.frame(
  "Cantidad de datos diarios" = as.vector(countObs(serie_temporal, FUN = "sum")),
  "Cantidad de datos faltantes diarios" = as.vector(countNA(serie_temporal, FUN = "sum"))
)

# Métricas mensuales
monthly_stats <- data.frame(
  "Cantidad de datos mensuales" = as.vector(countObs(serie_temporal, FUN = "month", FUN2 = "sum")),
  "Cantidad de datos faltantes mensuales" = as.vector(countNA(serie_temporal, FUN = "month", FUN2 = "sum"))
)

# Métricas estacionales
seasonal_stats <- data.frame(
  "Cantidad de datos estacionales" = as.vector(countObs(serie_temporal, FUN = "season", FUN2 = "sum")),
  "Cantidad de datos faltantes estacionales" = as.vector(countNA(serie_temporal, FUN = "season", FUN2 = "sum"))
)

# Métricas anuales
annual_stats <- data.frame(
  "Cantidad de datos anuales" = as.vector(countObs(serie_temporal, FUN = "year", FUN2 = "sum")),
  "Cantidad de datos faltantes anuales" = as.vector(countNA(serie_temporal, FUN = "year", FUN2 = "sum"))
)

# Estadísticas descriptivas
descriptive_stats <- data.frame(
  "Mínimo" = as.vector(minTS(serie_temporal)),
  "1er Cuartil" = as.vector(quantileTS(serie_temporal, probs = 0.25)),
  "Mediana" = as.vector(medianTS(serie_temporal)),
  "3er Cuartil" = as.vector(quantileTS(serie_temporal, probs = 0.75)),
  "Máximo" = as.vector(maxTS(serie_temporal)),
  "Desviación Estándar" = as.vector(sdTS(serie_temporal)),
  "Rango Intercuartil" = as.vector(IQRTS(serie_temporal))
)

