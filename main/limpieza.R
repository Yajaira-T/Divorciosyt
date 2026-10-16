library(fpp3)
library(here)

datos_2018 <- read.csv(
  here("Data", "EDV 2018.csv"), #Se corrige la ruta porque el archivo CSV está dentro de la carpeta Data
 # here("EDV 2018.csv"),
  sep = ";"
)

divorcios_2018 <- datos_2018 %>%
  mutate(
    fecha_insc = as.Date(fecha_insc, format = "%m/%d/%Y"),
    Mes = yearmonth(fecha_insc)
  ) %>%
  dplyr::filter(year(Mes) == 2018) %>% # Se utiliza dplyr:: para asegurar que se ejecute filter() del paquete dplyr
  count(Mes, prov_insc, cant_insc, parr_insc,
        name = "Observaciones") %>%
 # as_tibble( 
as_tsibble( # Se reemplaza as_tibble() por as_tsibble() para crear la serie temporal 
    index = Mes,
    key = c(prov_insc, cant_insc, parr_insc)
  )

divorcios_2018
