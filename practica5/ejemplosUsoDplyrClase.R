library(dplyr)
library(nycflights13)
library(ggplot2)

flights

system.time(unoEnero<-filter(flights,month==1,day==1))



retrasosLllegadasSalidas<-filter(flights,arr_delay>120&dep_delay>120)

#vuelos en enero febrero y marzo
eneroFebreroMarzo<-filter(flights,month %in% c(1,2,3))

#reordenar las filas
origenDestino<-arrange(flights,origin,dest)

#seleccion columnas
algunasColumnas<-select(flights,year,month,day,origin,dest)
seleccionRango<-select(flights,-(year:dest))
seleccionadas<-select(flights,starts_with("a")) #las columnas que empieza con a
seleccionadas<-select(flights,ends_with("a"))
seleccionadas<-select(flights,contains("_"))

#cambio de nombre de variables
conCambio<-rename(flights,tailnumber=tailnum) #cambia tailnum por tailnumber
names(conCambio)

# se agregan las nuevas variables mediante mutate
versionNueva <- mutate(flights, gain=arr_delay-dep_delay, speed=distance/air_time*60)

#agrupamiento de instancias
porDia<-group_by(flights,year,month,day)
resume<-summarize(porDia, delay=mean(dep_delay,na.rm=TRUE))

#encadenamiento mediante tuberias
#paso 1: agrupamiento por destino
porDestino<-group_by(flights,dest)
#paso 2: determinar retraso por destino
retraso<-summarize(porDestino,count=n(),dist=mean(distance,na.rm=TRUE),
                    delay=mean(arr_delay, na.rm=TRUE))
#paso 3: filtrado
filtrado<-filter(retraso,count>20,dest!="HNL")

#representacion de los datos
ggplot(data=filtrado, mapping=aes(x=dist,y=delay)) + 
  geom_point(aes(size=count), alpha=1/3) +
  geom_smooth(se=FALSE)

#Estas operaciones se puden encadenar mediante tuberias
resultado <- flights %>%
  group_by(dest) %>%
  summarize(count=n(), dist=mean(distance, na.rm=TRUE),
            delay=mean(arr_delay, na.rm=TRUE)) %>%
  filter(count > 20, dest != "HNL") %>% 
  ggplot(mapping=aes(x=dist,y=delay)) + 
  geom_point(aes(size=count), alpha=1/3) +
  geom_smooth(se=FALSE)


#conversion a tibble
datos<-as_tibble(iris)
datos
