library(tidyverse)
data_2019 <- as.data.frame(PREC_2019_Provincias)
#vamos a modificar el nombre de las columnas a una fecha

data_2019 <- as.data.frame(PREC_2019_Provincias)

data_2019$"15/01/2019" <- data_2019$enero
data_2019$"15/02/2019" <- data_2019$febrero
data_2019$"15/03/2019" <- data_2019$marzo
data_2019$"15/04/2019" <- data_2019$abril
data_2019$"15/05/2019" <- data_2019$mayo
data_2019$"15/06/2019" <- data_2019$junio
data_2019$"15/07/2019" <- data_2019$julio
data_2019$"15/08/2019" <- data_2019$agosto
data_2019$"15/09/2019" <- data_2019$septiembre
data_2019$"15/10/2019" <- data_2019$octubre
data_2019$"15/11/2019" <- data_2019$noviembre
data_2019$"15/12/2019" <- data_2019$diciembre


data_2019 <- select(data_2019,"region","15/01/2019", "15/02/2019","15/03/2019","15/04/2019","15/05/2019",
                    "15/06/2019","15/07/2019","15/08/2019","15/09/2019","15/10/2019","15/11/2019",
                    "15/12/2019" )

# a continuación vamos a transformar el archivo a "long"

data_2019_long <- data_2019 %>%
 pivot_longer(cols = c("15/01/2019", "15/02/2019","15/03/2019","15/04/2019","15/05/2019",
                       "15/06/2019","15/07/2019","15/08/2019","15/09/2019","15/10/2019","15/11/2019",
                       "15/12/2019" ),
    names_to = "mes", values_to = "precipitaciones" )

#vamos a codificar nuestra columna de mes como fechas
str(data_2019_long)
data_2019_long <- data_2019_long %>% 
  mutate(mes = as.Date(mes, format = "%d/%m/%Y"))

#
data_2019_long %>%
ggplot( aes(x = mes, y = precipitaciones))+
  geom_line() +
  facet_wrap(~region)
  
write_csv(data_2019, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/data_2019.csv")
write_csv(data_2019_long, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/data_2019_long.csv")






