# Pacotes ------------------------------------------------------------------
# install.packages("devtools")
#devtools::install_github("56north/spotifycharts")

library(spotifycharts)
library(lubridate)
library(dplyr)
library(purrr)


# Função de importação ------------------------------------------------------------------

import_spotify<-function(month,year,region= "br"){
  if(is.numeric(month) == F) {
    stop ("O mês deve ser informado pelo seu numeral")}
  if(nchar(year) != 4) {
    stop ("O ano deve ser informado com 4 dígitos")}
  
  chart_daily() %>% 
    filter(month(days) == month & year(days) == year) ->days
  
  dias<-rev(days$days)
  
  df<-data.frame()
  n<-length(dias)
  
  for( i in 1:n){
    cat(100*round(i/(n*length(month)),2),"% ",sep = "")
    aux<-chart_top200_daily(region = region, days = dias[i])
    aux$date<-rep(dias[i],200)
    df<-rbind(df,aux)
  }
  name<-paste0("top200_",month.abb[month],"_",year,".Rds")
  saveRDS(df,name)
}
