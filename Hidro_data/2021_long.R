library(tidyverse)
data_2021 <- as.data.frame(PREC_2021_Provincias)
#vamos a modificar el nombre de las columnas a una fecha

data_2021 <- as.data.frame(PREC_2021_Provincias)

data_2021$"15/01/2021" <- data_2021$enero
data_2021$"15/02/2021" <- data_2021$febrero
data_2021$"15/03/2021" <- data_2021$marzo
data_2021$"15/04/2021" <- data_2021$abril
data_2021$"15/05/2021" <- data_2021$mayo
data_2021$"15/06/2021" <- data_2021$junio
data_2021$"15/07/2021" <- data_2021$julio
data_2021$"15/08/2021" <- data_2021$agosto
data_2021$"15/09/2021" <- data_2021$septiembre
data_2021$"15/10/2021" <- data_2021$octubre
data_2021$"15/11/2021" <- data_2021$noviembre
data_2021$"15/12/2021" <- data_2021$diciembre


data_2021 <- select(data_2021,"region","15/01/2021", "15/02/2021","15/03/2021","15/04/2021","15/05/2021",
                    "15/06/2021","15/07/2021","15/08/2021","15/09/2021","15/10/2021","15/11/2021",
                    "15/12/2021" )

# a continuación vamos a transformar el archivo a "long"

data_2021_long <- data_2021 %>%
  pivot_longer(cols = c("15/01/2021", "15/02/2021","15/03/2021","15/04/2021","15/05/2021",
                        "15/06/2021","15/07/2021","15/08/2021","15/09/2021","15/10/2021","15/11/2021",
                        "15/12/2021" ),
               names_to = "mes", values_to = "precipitaciones" )

#vamos a codificar nuestra columna de mes como fechas
str(data_2021_long)
data_2021_long <- data_2021_long %>% 
  mutate(mes = as.Date(mes, format = "%d/%m/%Y"))

#
data_2021_long %>%
  ggplot( aes(x = mes, y = precipitaciones))+
  geom_line() +
  facet_wrap(~region)

write_csv(data_2021, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/data_2021.csv")
write_csv(data_2021_long, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/data_2021_long.csv")






