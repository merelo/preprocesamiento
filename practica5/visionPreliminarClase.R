source("practica5/lecturaDatos.R")

instancias<-nrow(datos)
variables<-ncol(datos)

head(datos)
tail(datos)
names(datos)
summary(datos)
summary(datos[,1:3])
fix(iris)

library(Hmisc)
Hmisc::describe(datos[1])
Hmisc::describe(datos[51])

library(fBasics)
info<-fBasics::basicStats(datos[1])

#imputacion datos perdidos
# tecnicas robustas frente a datos perdidos (arboles)
# eliminacion de instancias: na.omit
# imputacion
#  asignacion valor fijo
#  asignacion valor referencia
#  tecnicas mas sofisticadas