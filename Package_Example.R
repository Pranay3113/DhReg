rm(list = ls())
# install.packages("forecast")
# install.packages("stats")
# install.packages("future.apply")
library(forecast)
library(stats)
library(future.apply)

path = file.choose() ##dhReg_0.1.0.tar.gz package path
install.packages(path, repos = NULL, dependencies = TRUE) #used only tar.gz format
library(dhReg)
Data_1 <- read.csv(file.choose())
Datatrain <- Data_1[1:(length(Data_1$Datetime)-168),]
Datatest <- Data_1[(length(Data_1$Datetime)-168+1):length(Data_1$Datetime),]

a <- Sys.time()
Model <- dhr(Data = ts(Datatrain$usage_MW), XREG = Datatrain$Weekend.holiday, Range =  list(1:2,1:2,1), Frequency = c(24,168,8766), Criteria = "aicc")
Model
Sys.time() - a

##Value of K in Fourier series
fourier_K(Model)

##Forecast
Forecast <- fc(Frequency = c(24, 168, 8766), XREG_test  = Datatest$Weekend.holiday, h = 168, Fit = Model, Data = Datatrain$usage_MW)
plot(Forecast)

