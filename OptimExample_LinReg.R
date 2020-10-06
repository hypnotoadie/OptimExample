library(tidyverse)

setwd('') # change for local path

#Function to find best fit line
min.RSS <- function(data, par) {
  with(data, sum((par[1] + par[2] * x - y)^2))
}

#Load data
dat = readRDS('dat.rds')

#Create a sample with 1 person per group, and 1 group per person, then create best fit line (This simulates independence-preserving subsampling)
nSamples = 1000
fit_parameters = matrix(NA,nSamples, 3) #store parameter fits and fit value for each sample
for (i in seq(1,nSamples)){
  
  #Create a single subsample of the data
  dat_sample = dat %>% group_by(ID_Person) %>% sample_n(1) %>% group_by(ID_Group) %>% sample_n(1) %>% ungroup()
  
  #Fit a line
  fit_sample = optim(par = c(0, 1), fn = min.RSS, data = dat_sample)
  
  #Store the slope, intercept, and fit value
  fit_parameters[i,] = c(fit_sample$par, fit_sample$value)
}

#Normalize fit value to [0,1]
fit_parameters[,3] = (fit_parameters[,3] - min(fit_parameters[,3])) / max(fit_parameters[,3] - min(fit_parameters[,3]))

#Plot the data and all the best fit lines (transparancy ~ fit)
plot(y ~ x, data = dat, main="Least square regression")

for (i in seq(1,nSamples)){
  abline(a = fit_parameters[i,1], b = fit_parameters[i,2], col=rgb(1,0,0,(fit_parameters[i,3])^8,maxColorValue=1) )
}

 
 
 