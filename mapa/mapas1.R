#vamos a formar un conjunto de datos de los tres años
#Primero juntamos todas las filas de 2019 y 2020
data_19_21 <- full_join(data_2019_long, data_2020_long, by = NULL)
#A este dataset le unimos las filas de 2021
data_19_21 <- full_join(data_19_21, data_2021_long, by = NULL)

#https://www.aemet.es/es/datos_abiertos/estadisticas/balance_hidrico
#https://centrodedescargas.cnig.es/CentroDescargas/catalogo.do?Serie=CAANE

#rgdal y maptools van a desaparecer, trabajaremos con
library(sf)
library(stars)
library(terra)

#tenemos archivo shapefile
# es importante especificar la capoa que queremos leer para la posterior manipulación de los datos

library(sf)
capas <- st_layers(  "/Users/josepblascodominguez/Desktop/R/Balance_hidro/lineas_limite/SHP_ETRS89/recintos_provinciales_inspire_peninbal_etrs89/recintos_provinciales_inspire_peninbal_etrs89.shp")
capas

datos_sf <- st_read(
  "/Users/josepblascodominguez/Desktop/R/Balance_hidro/lineas_limite/SHP_ETRS89/recintos_provinciales_inspire_peninbal_etrs89/recintos_provinciales_inspire_peninbal_etrs89.shp", layer ="recintos_provinciales_inspire_peninbal_etrs89")

#dubujamos nustro mapa
plot(datos_sf["geometry"], pch = 16, col = "black", cex = 0.5, main = "Mapa de puntos")


#eliminaremos: Islas Canarias, Ceuta y Melilla
#con la libreria sf

# 1. Leer el archivo shp y llevarlo a un objeto.
# 2. Con subset eliminar las provincias
datos_sf <- subset(datos_sf, Provincia != "Ceuta")



datos_mapa <-  select(datos_mapa, "NAMEUNIT","geometry")

write_sf(datos_mapa, "/Users/josepblascodominguez/Documents/GitHub/kaggle_balance_h-drico/mapa/datos_mapa.shp")

write_csv(datos_mapa, "/Users/josepblascodominguez/Documents/GitHub/kaggle_balance_h-drico/mapa/datos_mapa.csv")



capas <- st_layers(  "/Users/josepblascodominguez/Desktop/R/Balance_hidro/lineas_limite/SHP_ETRS89/ll_provinciales_inspire_peninbal_etrs89/ll_provinciales_inspire_peninbal_etrs89.shp")
capas

datos_sf <- st_read(
  "/Users/josepblascodominguez/Desktop/R/Balance_hidro/lineas_limite/SHP_ETRS89/ll_provinciales_inspire_peninbal_etrs89/ll_provinciales_inspire_peninbal_etrs89.shp", layer ="ll_provinciales_inspire_peninbal_etrs89")



ggplot(datos_sf)+
  geom_sf()
  

