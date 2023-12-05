library(tidyverse)

fallecidos<-read_csv("tabula-Mexico_Personal_Fallecidos.csv")%>%
  filter(`TIPO DE EVENTO`!="TIPO DE EVENTO")
colnames(fallecidos)[c(1,9)]<-c("ID","EVENTO")
fallecidos$FECHA<-dmy(fallecidos$FECHA)
fallecidos$YEAR<-year(fallecidos$FECHA)
fallecidos$MONTH<-month(fallecidos$FECHA)

levels(as.factor(d$EVENTO))
rel_evento<-c("AGRESIONCONARMADE\rFUEGO.","AGRESIONCONARMAD\rFUEGO.")

fallecidos_firearms<-filter(fallecidos,EVENTO%in%rel_evento)

write_csv(fallecidos,"cleaned_Mexico_Personal_Fallecidos.csv")
write_csv(fallecidos_firearms,"cleaned_Mexico_Personal_Fallecidos_AF.csv")

