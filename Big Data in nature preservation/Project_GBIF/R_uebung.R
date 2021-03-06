##Install packages
install.packages(c("tidyverse", "rgbif", "sp", "countrycode", "CoordinateCleaner", "data.table", "rgdal", "rgeos"))

##Library
library(tidyverse)
library(rgbif)
library(sp)
library(countrycode)
library(CoordinateCleaner)
library(data.table)
library(rgdal)
library(rgeos)

objectdata<-occ_search(scientificName = "Ceiba pentandra",
                       return = "data")
##number of records
nrow(objectdata)
names(objectdata)
plot(objectdata$decimalLatitude~objectdata$decimalLongitude)


##taxon group
occ_count(tax_key,country = "BR")