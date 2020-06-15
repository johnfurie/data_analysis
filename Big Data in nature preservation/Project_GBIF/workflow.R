install.packages(c("link2GI","ForestTools","sf","sp","rgeos","rgdal","mapview","doParallel","parallel","sf"))
install.packages(c("tidyverse", "rgbif", "sp", "countrycode", "CoordinateCleaner", "data.table", "rgdal", "rgeos"))
install.packages(c("tidyr","dplyr"))
require(raster)
require(link2GI)
require(ForestTools)
require(sf)
require(sp)
library(tidyverse)
library(rgbif)
library(countrycode)
library(CoordinateCleaner)
library(data.table)
library(rgdal)
library(rgeos)
require(mapview)
require(doParallel)
require(parallel)
require(tidyr)
require(dplyr)
require(aplot)
require(wellknown)
# load data
rgb <- raster::raster(file.path("C:/Users/Anonymouse/Desktop/data/rgb/RGB_wgs84_aoi.tif")) 
shp <- rgdal::readOGR(file.path("C:/Users/Anonymouse/Desktop/data/shp/study_area_gcs.shp")) 
shp <- rgdal::readOGR(file.path("C:/Users/Anonymouse/Desktop/data/shp/de.shp")) 

# check projection
crs(rgb) 
crs(shp) 

# transform projection
# shp <- spTransform(shp,"+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")

# plot data
plot(rgb) 
plot(shp)

##use the suggest function to get gbif taxon key, class = Phylum, key = 35
tax_key <- name_suggest(q="Bryophyta",rank="Phylum")
tax_key
tax_key <- name_suggest(q="Brachythecium rutabulum",rank="Species")
tax_key
tax_key <- name_suggest(q="Hypnum cupressiforme",rank="Species")
tax_key

##becaus there are different key numbers check how many entrys are availabe
lapply(tax_key$key,"occ_count")
##choose taxon key
tax_key <- tax_key$key[1]

##search for occurence records and explore data
objectdata<-occ_search(scientificName = "Brachythecium rutabulum",
                       return = "data", limit = 500, country = "DE")
objectdata<-occ_search(scientificName = "Hypnum cupressiforme",
                       return = "data", limit = 500, country = "DE")
objectdata<-occ_search(taxonKey = tax_key,
                       return = "data", limit = 500,geometry = study_area)
objectdata<-occ_search(scientificName ="Bryophyta",
                       return = "data", limit = 500,geometry = study_area)

##number of records
nrow(objectdata)
names(objectdata)
plot(objectdata$decimalLatitude~objectdata$decimalLongitude)

# add study area via WKS format. sequence is impertant: down left, down right, up right, up left
# add study area coordinates
# caldern
study_area <- "POLYGON((50.834 8.671, 50.834 8.690, 50.847 8.690, 50.847 8.671, 50.834 8.671))"
#mid america
study_area <- "POLYGON((-35 -4.5, -38.5 -4.5, -38.5 -7, -35 -7, -35 -4.5))"
#mid europe
study_area <- "POLYGON((40 3, 40 9, 55 9, 55 3, 40 3))"
#study_area <- wellknown::polygon(study_area)
# germany
study_area <- "POLYGON((47.9959 7.85222, 48.5665 13.43122, 54.08333 12.10881, 53.073635 8.806422, 47.9959 7.85222))"
de <- occ_count(tax_key,country = "DE")
# get entries for study area
datasa <-occ_search(phylumKey = 35, return = "data",hasCoordinate = TRUE, geometry = study_area)
datasa <-occ_search(taxonKey = tax_key, return = "data",hasCoordinate = TRUE, geometry = study_area)
datasa <-occ_search(phylumKey = 35, return = "data",hasCoordinate = TRUE, geometry = a)
datasa <-occ_search(taxonKey = tax_key, return = "data",hasCoordinate = TRUE, country = "DE")

a <- writeWKT(study_area)
