#debemos disponer de los nombres de provincias iguales en todos los datasets
#sacar el vector de provincias del archivo shp

provincias <-  datos_mapa$NAMEUNIT

print(provincias)


#asignamos id a una provincia.

datos_mapa$id <- c(1:49)

Provincia <- distinct(data_2019_long, region)
print(Provincia, n=49)

install.packages("DataEditR")
library(DataEditR)

codigos <- select(datos_mapa, "NAMEUNIT", "id")

#añadir id a provincias
library(tidyverse)

regiones <- Provincia %>%
  mutate(region = case_when(region =="A CORUNA" ~ "15",
                            region =="ALBACETE" ~ "2",
                            region =="ALICANTE" ~ "3",
                            region =="ALMERIA" ~ "4",
                            region =="ARABA" ~ "1",
                            region =="ASTURIAS" ~ "33",
                            region =="AVILA" ~ "5",
                            region =="BADAJOZ" ~ "6",
                            region =="ILLES BALEARS" ~ "7",
                            region =="BARCELONA" ~ "8",
                            region =="BIZKAIA" ~ "46",
                            region =="BURGOS" ~ "9",
                            region =="CACERES" ~ "10",
                            region =="CADIZ" ~ "11",
                            region =="CANTABRIA" ~ "37",
                            region =="CASTELLON" ~ "12",
                            region =="CIUDAD REAL" ~ "13",
                            region =="CORDOBA" ~ "14",
                            region =="CUENCA" ~ "16",
                            region =="GIPUZKOA" ~ "20",
                            region =="GIRONA" ~ "17",
                            region =="GRANADA" ~ "18",
                            region =="GUADALAJARA" ~ "19",
                            region =="HUELVA" ~ "21",
                            region =="HUESCA" ~ "22",
                            region =="JAEN" ~ "23",
                            region =="LA RIOJA" ~ "26",
                            region =="LEON" ~ "24",
                            region =="LLEIDA" ~ "25",
                            region =="LUGO" ~ "27",
                            region =="MADRID" ~ "28",
                            region =="MALAGA" ~ "29",
                            region =="MURCIA" ~ "30",
                            region =="NAVARRA" ~ "31",
                            region =="OURENSE" ~ "32",
                            region =="PALENCIA" ~ "34",
                            region =="PONTEVEDRA" ~ "35",
                            region =="SALAMANCA" ~ "36",
                            region =="SEGOVIA" ~ "38",
                            region =="SEVILLA" ~ "39",
                            region =="SORIA" ~ "40",
                            region =="TARRAGONA" ~ "41",
                            region =="TERUEL" ~ "42",
                            region =="TOLEDO" ~ "43",
                            region =="VALENCIA" ~ "44",
                            region =="VALLADOLID" ~ "45",
                            region =="ZAMORA" ~ "47",
                            region =="ZARAGOZA" ~ "48",
    
  ))

Provincia$id <- regiones$region

Provincia$id <- as.factor(Provincia$id)
codigos$id <- as.factor(codigos$id)

central <- full_join(Provincia, codigos, by = "id")


#ponemos estos codigos con su apropiado nombre en los dataset de precipitaciones; eliminamos CEUTA MELILLA CANARIAS
#2019
data_2019_long <- left_join(data_2019_long, central, by = "region")
data_2019_long <- select(data_2019_long, "mes", "precipitaciones", "id", "NAMEUNIT")

  #eliminar aquellas provincias que no
data_2019_long <- subset(data_2019_long, !is.na(NAMEUNIT))

write_csv(data_2019_long, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/Hidro_data/data_2019_long.csv")

#2020
data_2020_long <- left_join(data_2020_long, central, by = "region")
data_2020_long <- select(data_2020_long, "mes", "precipitaciones", "id", "NAMEUNIT")


data_2020_long <- subset(data_2020_long, !is.na(NAMEUNIT))

write_csv(data_2020_long, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/Hidro_data/data_2020_long.csv")

#2021
data_2021_long <- left_join(data_2021_long, central, by = "region")
data_2021_long <- select(data_2021_long, "mes", "precipitaciones", "id", "NAMEUNIT")


data_2021_long <- subset(data_2021_long, !is.na(NAMEUNIT))

write_csv(data_2021_long, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/Hidro_data/data_2021_long.csv")

#total tres años
data_1921_long <- full_join(data_2019_long, data_2020_long, by = NULL)
data_1921_long <- full_join(data_1921_long, data_2021_long, by = NULL)


write_csv(data_1921_long, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/Hidro_data/data_1921_long.csv")

#base; vamos a preparar nuestos datos base

data_base <- as.data.frame(PREC_1981_2010_Provincias)
  #id
data_base <- left_join(data_base, central, by = "region")
  #eliminar filas de datos de CEUTA, MELILLA, LAS PALMAS
data_base <- subset(data_base, !(region %in% c("CEUTA", "MELILLA", "LAS PALMAS", "SANTA CRUZ DE TENERIFE")))
  #nos quedamos con las columnas necesarias
data_base <- select(data_base, c(2, 4:18))

write_csv(data_base, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/Hidro_data/data_base.csv")

#formato long

data_base_long <- pivot_longer(data_base, cols = c(2:14), names_to = "meses", values_to = "precipitaciones")

write_csv(data_base_long, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/Hidro_data/data_base_long.csv")


#Nuevos dataset con el sumatorio de todo el año
  #2019
data_2019_long$NAMEUNIT <- as.factor(data_2019_long$NAMEUNIT)

anual_2019 <- data_2019_long%>%
  group_by(NAMEUNIT, id) %>% 
  summarise(total_2019 = sum(precipitaciones))

write_csv(anual_2019, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/Hidro_data/anual_2019.csv")

#2020
data_2020_long$NAMEUNIT <- as.factor(data_2020_long$NAMEUNIT)

anual_2020 <- data_2020_long%>%
  group_by(NAMEUNIT, id) %>% 
  summarise(total_2020 = sum(precipitaciones))

write_csv(anual_2020, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/Hidro_data/anual_2020.csv")


#2021
data_2021_long$NAMEUNIT <- as.factor(data_2021_long$NAMEUNIT)

anual_2021 <- data_2021_long%>%
  group_by(NAMEUNIT, id) %>% 
  summarise(total_2021 = sum(precipitaciones))

write_csv(anual_2021, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/Hidro_data/anual_2021.csv")







                                
[9] "Burgos"                                    
[10] "Cáceres"                                   
[11] "Cádiz"                                     
[12] "Castelló/Castellón"                        
[13] "Ciudad Real"                               
[14] "Córdoba"                                   
[15] "A Coruña"                                  
[16] "Cuenca"                                    
[17] "Girona"                                    
[18] "Granada"                                   
[19] "Guadalajara"                               
[20] "Gipuzkoa"                                  
[21] "Huelva"                                    
[22] "Huesca"                                    
[23] "Jaén"                                      
[24] "León"                                      
[25] "Lleida"                                    
[26] "La Rioja"                                  
[27] "Lugo"                                      
[28] "Madrid"                                    
[29] "Málaga"                                    
[30] "Murcia"                                    
[31] "Navarra"                                   
[32] "Ourense"                                   
[33] "Asturias"                                  
[34] "Palencia"                                  
[35] "Pontevedra"                                
[36] "Salamanca"                                 
[37] "Cantabria"                                 
[38] "Segovia"                                   
[39] "Sevilla"                                   
[40] "Soria"                                     
[41] "Tarragona"                                 
[42] "Teruel"                                    
[43] "Toledo"                                    
[44] "València/Valencia"                         
[45] "Valladolid"                                
[46] "Bizkaia"                                   
[47] "Zamora"                                    
[48] "Zaragoza"                                  
[49] "Territorio no asociado a ninguna provincia"