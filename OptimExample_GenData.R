library(tidyverse)

setwd('') # set to local path

#Generate X/Y Data
xdat = runif(10000,1,50)
ydat = xdat^2 + rnorm(length(xdat))*300
plot(xdat,ydat)

#Generate ID Data
ID_Person = round(runif(length(xdat))*200) #200 Unique Individuals
ID_Group = round(runif(length(xdat))*100) #100 Unique Groups

#Create Table  
dat=tbl_df(data.frame(ID_Person = ID_Person,
                      ID_Group = ID_Group,
                      x=xdat, 
                      y=ydat))

#Save
saveRDS(dat, 'dat.rds')


