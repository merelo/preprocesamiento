library(ggplot2)
library(tidyverse)
?mpg

#datos que uso + caracteristicas del grafico(el + al final de una linea)
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ,y=hwy))

ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ,y=hwy, color=class))

#discriminar por tamaño de puntos
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ,y=hwy, size=class))

#discriminar por transparencia 
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ,y=hwy, alpha=class))

#discriminar por tipo de punto
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ,y=hwy, shape=class))


#agrupacion de puntos en graficos diferentes
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ,y=hwy, color=class)) +
  facet_wrap(~ class,nrow=2)

#agrupacion por varias variables
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ,y=hwy, color=class)) +
  facet_grid(drv ~ cyl)

#agregar linea de tendencia sobre los datos
ggplot(data=mpg,mapping = aes(x=displ,y=hwy)) +
  geom_smooth()+
  geom_point(mapping = aes(color=class))

#agregar linea de tendencia sobre los datos
#SE para quitar franja oscurita alrededor de la linea
ggplot(data=mpg,mapping = aes(x=displ,y=hwy)) +
  geom_smooth(se=FALSE)+
  geom_point(mapping = aes(color=class))


#filtrado para una clase
ggplot(data=mpg,mapping = aes(x=displ,y=hwy)) +
  geom_point(mapping = aes(color=class))+
  geom_smooth(data=filter(mpg, class=="subcompact"),se=FALSE)


?diamonds
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut))

#con proporciones
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut,y=..prop..,group=1))

ggplot(data=diamonds)+
  stat_summary(mapping = aes(x=cut,y=depth),fun.ymin = min,fun.ymax = max,fun.y = median)


#pequeña variacion para disminuir solapamientos
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ,y=hwy,color=class), position = "jitter")


ggplot(data=mpg,mapping=aes(x=class,y=hwy)) +
  geom_boxplot()+
  coord_flip()
