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
####### EDA########
####################

#ahora se selecciona las mediciones de la base de datos para hacer EDA.

date.ini <-paste0("La fecha inicial de la estaciónID ingresada es: ", data_raw[11, estacionID]) #uso la variable com chr para elegir el [i] de la columna
date.fin <-paste0("La fecha final de la estaciónID ingresada es: ", data_raw[12, estacionID])
date.ini
date.fin

data_elegida<-data_raw[-c(1:14), c("codigo_estacion", estacionID)]#Descarta las primeras catorce filas
#y las fechas con los datos de la columna estacionID




#series temporales
#Ver si está el paquete instalado
if (!require(hydroTSM)) {
  install.packages("hydroTSM")
}
library(hydroTSM)
data_na<- replace(data_elegida, data_elegida == -9999, NA) #cambia los -9999 por NA
data_na
#Extraer los na de data_na
data_limpia <- na.omit(data_na)
class(data_limpia)
days<-dip(from=as.Date(date.ini),to=as.Date(date.fin),out.type="nmbr")
data_diaria <- extract(data_na, FUN = max, na.rm = 0)




















#################### Esto lo debo hacer con hydroTSM######################


range(data_na, na.rm = TRUE) #Rango de valores 
max(data_na, na.rm = TRUE)  #valor máximo
min(data_na, na.rm=TRUE) #valor mínimo
mean(data_na, na.rm = TRUE) #promedio 
median(data_na, na.rm = TRUE) #mediana
es.faltante <- is.na(data_na) 
sum(es.faltante) #datos faltantes
na.index <- which(es.faltante)
dates[na.index] #fechas de cuales son los datos faltantes
#número de datos válidos
datos_validos <- !is.na(es.faltante)
sum(datos_validos)
#Cuartiles
cuartiles <- quantile(data_na, na.rm = TRUE) cuartiles

#Rango intercuartil
rango_intercuartil <- cuartiles[4] - cuartiles[2] rango_intercuartil


#Fecha en que ocurre caudal máximo
max.dates.index <-apply((data_na), MARGIN = 2, FUN = which.max())

#Fecha caudal medio de data_elegida
fecha_media <- mean(data_elegida, na.rm = TRUE)

