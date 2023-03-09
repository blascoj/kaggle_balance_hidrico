library(tidyverse)
data_2020 <- as.data.frame(PREC_2020_Provincias)
#vamos a modificar el nombre de las columnas a una fecha

data_2020 <- as.data.frame(PREC_2020_Provincias)

data_2020$"15/01/2020" <- data_2020$enero
data_2020$"15/02/2020" <- data_2020$febrero
data_2020$"15/03/2020" <- data_2020$marzo
data_2020$"15/04/2020" <- data_2020$abril
data_2020$"15/05/2020" <- data_2020$mayo
data_2020$"15/06/2020" <- data_2020$junio
data_2020$"15/07/2020" <- data_2020$julio
data_2020$"15/08/2020" <- data_2020$agosto
data_2020$"15/09/2020" <- data_2020$septiembre
data_2020$"15/10/2020" <- data_2020$octubre
data_2020$"15/11/2020" <- data_2020$noviembre
data_2020$"15/12/2020" <- data_2020$diciembre


data_2020 <- select(data_2020,"region","15/01/2020", "15/02/2020","15/03/2020","15/04/2020","15/05/2020",
                    "15/06/2020","15/07/2020","15/08/2020","15/09/2020","15/10/2020","15/11/2020",
                    "15/12/2020" )

# a continuación vamos a transformar el archivo a "long"

data_2020_long <- data_2020 %>%
  pivot_longer(cols = c("15/01/2020", "15/02/2020","15/03/2020","15/04/2020","15/05/2020",
                        "15/06/2020","15/07/2020","15/08/2020","15/09/2020","15/10/2020","15/11/2020",
                        "15/12/2020" ),
               names_to = "mes", values_to = "precipitaciones" )

#vamos a codificar nuestra columna de mes como fechas
str(data_2020_long)
data_2020_long <- data_2020_long %>% 
  mutate(mes = as.Date(mes, format = "%d/%m/%Y"))

#
data_2020_long %>%
  ggplot( aes(x = mes, y = precipitaciones))+
  geom_line() +
  facet_wrap(~region)

write_csv(data_2020, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/data_2020.csv")
write_csv(data_2020_long, "/Users/josepblascodominguez/Desktop/R/Balance_hidro/data_2020_long.csv")






