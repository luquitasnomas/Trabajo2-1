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

# Definir las fechas de inicio y fin
date_ini <- as.Date(date.ini, format = "%Y-%m-%d")
date_fin <- as.Date(date.fin, format = "%Y-%m-%d")

# Filtrar los datos dentro del rango de fechas
datos_diarios <- data_limpia[date_limpia$date >= date_ini & date_limpia$date <= date_fin, ]

# Calcular las métricas diarias
dip_diarios <- dip(datos_diarios)
mip_diarios <- mip(datos_diarios)
yip_diarios <- yip(datos_diarios)

# Convertir los datos a datos mensuales y anuales
datos_mensuales <- aggregate(datos_diarios, by = "month")
datos_anuales <- aggregate(datos_diarios, by = "year")

# Calcular las métricas mensuales y anuales
dip_mensuales <- mip(datos_mensuales)
mip_mensuales <- mip(datos_mensuales)
yip_mensuales <- yip(datos_mensuales)

dip_anuales <- mip(datos_anuales)
mip_anuales <- mip(datos_anuales)
yip_anuales <- yip(datos_anuales)

# Realizar estadísticas descriptivas
desc_diarios <- describe(datos_diarios)
desc_mensuales <- describe(datos_mensuales)
desc_anuales <- describe(datos_anuales)

# Imprimir los resultados
print(dip_diarios)
print(mip_diarios)
print(yip_diarios)
print(dip_mensuales)
print(mip_mensuales)
print(yip_mensuales)
print(dip_anuales)
print(mip_anuales)
print(yip_anuales)
print(desc_diarios)
print(desc_mensuales)
print(desc_anuales)
