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
sd(data_limpia$estacionID)        #Necesita correción
IQR(data_limpia$estacionID)       #Necesita correción





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

# Convertir las variables date.ini y date.fin a formato de fecha
date_ini <- as.Date(date.ini)
date_fin <- as.Date(date.fin)

# Extraer los datos diarios, mensuales y anuales
datos_diarios <- extract(data_limpia, from = date_ini, to = date_fin)
datos_mensuales <- mip(datos_diarios)
datos_anuales <- yip(datos_diarios)

# Calcular las métricas utilizando las funciones dip, mip y yip
metricas_diarias <- dip(datos_diarios)
metricas_mensuales <- mip(datos_mensuales)
metricas_anuales <- yip(datos_anuales)

# Estadísticas descriptivas de las secuencias temporales
stats_diarias <- summary(datos_diarios)
stats_mensuales <- summary(datos_mensuales)
stats_anuales <- summary(datos_anuales)
