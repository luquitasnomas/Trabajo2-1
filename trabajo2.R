#Trabajo Práctico Dos

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
data<-paste0(wdirectory,"/cr2_prDaily_2018.csv")
dataraw<-read.csv(fname)
ls()





data<- read_csv(file.choose(), col_names = TRUE)
