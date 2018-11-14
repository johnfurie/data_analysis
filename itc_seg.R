##- required packages
require(uavRst)
require(link2GI)
require(raster)
require(sp)
require(maptools)
require(rgeos)
##- read chm data
chmR<- raster::raster("C:/Users/Anonymouse/Desktop/Bachelor-data/Geodata/Start/CHM/CHM.tif")

memory.limit()
##- segmentation
crownsITC<- chmseg_ITC(chm = chmR,
                         EPSG =2154,
                         movingWin = 3,
                         TRESHSeed = 0.45,
                         TRESHCrown = 0.55,
                         minTreeAlt = 0.7,
                         maxCrownArea = 150)
  
##- visualisation
mapview::mapview(crownsITC,zcol="Height_m")
