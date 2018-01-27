source("practica5/lecturaDatos.R")

#obtener el porcentaje de variables con datos perdidos en cada instancia
system.time(res<-apply(datos,1,function(x)sum(is.na(x))/ncol(x)*100))

#marcamos como instancias malas aquellas en que el porcentaje supera un umbral
mal<-(res>5)

filtrados<-datos[!mal,]

escrituraDatos("./data","datosFiltrados.csv",filtrados)

library(parallel)
cores<-detectCores()
cluster<-makeCluster(cores-2)
system.time(res2<-parRapply(cluster,datos,function(x)sum(is.na(x))/ncol(x)*100))
stopCluster(cluster)

library(mice)
datos<-airquality
patron<-mice::md.pattern(x=datos)
patron

library(VIM)
plot<-VIM::aggr(datos,col=c('blue','red'),numbers=TRUE,sortVars=TRUE,labels=names(data),cex.axis=.5,
                gap=1,ylab=c("Grafica de datos perdidos","Patron"))

VIM::marginplot(datos[,1:2]) #como son parecidos se puede pensar en patron aleatorio
