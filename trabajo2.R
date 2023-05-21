#Trabajo Práctico Dos
library(readr)
getwd()
wdirectory<-("C:/Users/Flavio/Documents/Programacion aplicada/Trabajo2")
setwd(wdirectory)

# Definir el nombre del archivo
archivo_zip <- "cr2_prDaily_2018.zip"

# Definir la url de descarga
url <- "https://www.cr2.cl/download/cr2_prdaily_2018-zip/?wpdmdl=15135"

# Comprobar si el archivo existe
if (!require(archivo_zip)) {
  # Si no existe, descargarlo
  download.file(url,archivo_zip)
}
# Descomprimir el archivo zip
unzip(archivo_zip)
# Verificar si el archivo existe
file.exists("/cr2_prDaily_2018/cr2_prDaily_2018.csv")

dataraw<- read_csv(file.choose(), col_names = TRUE)
#ruta al archivo csv
ls()
head(data_raw)
str(data_raw)
ncol(data_raw)
nrow(data_raw)

# Leer el código de identificación de la estación pluviométrica
estacionID <- readline(prompt = "Ingrese el código de identificación de la estación pluviométrica: ")
#crear dos vectores
infoestacionID<-data_raw[1:14,1]
datoestacion<-dataraw[1:14, estacionID]

# Mostrar el data frame
data.frame(infoestacionID, datoestacion)


####### EDA########
####################





