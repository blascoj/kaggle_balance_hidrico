#vamos a formar un conjunto de datos de los tres años
#Primero juntamos todas las filas de 2019 y 2020
data_19_21 <- full_join(data_2019_long, data_2020_long, by = NULL)
#A este dataset le unimos las filas de 2021
data_19_21 <- full_join(data_19_21, data_2021_long, by = NULL)

#https://www.aemet.es/es/datos_abiertos/estadisticas/balance_hidrico
#https://centrodedescargas.cnig.es/CentroDescargas/catalogo.do?Serie=CAANE

#rgdal y maptools van a desaparecer, trabajaremos con
library(tidyverse)

library(sf)
library(stars)
library(terra)

#tenemos archivo shapefile
# es importante especificar la capoa que queremos leer para la posterior manipulación de los datos


capas <- st_layers(  "/Users/josepblascodominguez/Desktop/R/Balance_hidro/lineas_limite/SHP_ETRS89/recintos_provinciales_inspire_peninbal_etrs89/recintos_provinciales_inspire_peninbal_etrs89.shp")
capas

datos_sf <- st_read(
  "/Users/josepblascodominguez/Desktop/R/Balance_hidro/lineas_limite/SHP_ETRS89/recintos_provinciales_inspire_peninbal_etrs89/recintos_provinciales_inspire_peninbal_etrs89.shp", layer ="recintos_provinciales_inspire_peninbal_etrs89")


#eliminaremos: Islas Canarias, Ceuta y Melilla
#con la libreria sf

# 1. Leer el archivo shp y llevarlo a un objeto.
# 2. Con subset eliminar las provincias
datos_sf <- subset(datos_sf, NAMEUNIT != "Melilla")
datos_sf <- subset(datos_sf, NAMEUNIT != "Ceuta")
datos_sf <- subset(datos_sf, NAMEUNIT != "Territorio no asociado a ninguna provincia")


#intento deshacerme de metadata

datos_mapa <- select(datos_sf, NAMEUNIT, geometry)

st_write(datos_sf, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/mapa/datos_sf.shp")
st_write(datos_mapa, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/mapa/datos_mapa.shp")






