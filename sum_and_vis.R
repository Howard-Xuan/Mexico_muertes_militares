library(tidyverse)
library(ICplots)


fallecidos<-read_csv("cleaned_Mexico_Personal_Fallecidos.csv")
fallecidos_firearms<-read_csv("cleaned_Mexico_Personal_Fallecidos_AF.csv")

sum_fallecidos<-fallecidos%>%group_by(YEAR)%>%
  summarise(instances=n())
sum_fallecidos_firearms<-fallecidos_firearms%>%group_by(YEAR)%>%
  summarise(instances=n())

plot<-ggplot(filter(sum_fallecidos,YEAR!=2006))+
  geom_line(aes(x=YEAR,y=instances,color="Todas causas"),linewidth=2)+
  geom_line(data=sum_fallecidos_firearms,aes(x=YEAR,y=instances,color="Sólo armas de fuego"),linewidth=2)+
  labs(title="Muertes de militares en la campaña \n contra narcotráfico (2007-2023)", x="Año",
       y="Número fallecidos")+
  scale_color_manual(
    name="Causa de muerte",
    breaks=c("Todas causas","Sólo armas de fuego"),
    values=c("Todas causas"="brown","Sólo armas de fuego"="red")
  )+
  scale_x_continuous(breaks=seq(2001,2023,1))+
  theme_ic()

plot

sum_fallecidos_states<-fallecidos%>%group_by(YEAR,ESTADO)%>%
  summarise(instances=n())%>%spread(ESTADO,instances)

sum_fallecidos_firearms_states<-fallecidos_firearms%>%group_by(YEAR,ESTADO)%>%
  summarise(instances=n())%>%spread(ESTADO,instances)

sum_fallecidos_months<-fallecidos%>%group_by(YEAR,MONTH)%>%
  summarise(instances=n())%>%spread(MONTH,instances)

sum_fallecidos_firearms_months<-fallecidos_firearms%>%group_by(YEAR,MONTH)%>%
  summarise(instances=n())%>%spread(MONTH,instances)

sum_fallecidos<-sum_fallecidos%>%mutate(
  ROC=(instances-lag(instances)))

finalise_plot(plot,
              source_name="Source: SEDENA\n",
              save_filepath = "Mexico_graph.png")
