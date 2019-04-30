# PACKAGES #
library(data.table)
library(GSMP)


# GENERAL OPTIONS #

# Spot only?
spotOnly <- FALSE

# Tracks of 2012 - 2016 only?
sel_12_16 <- FALSE

# Raster resolution
resolution <- 1

# Resolution name to save files (remove point from the number)
res <- gsub('\\.','',as.character(resolution))


# Polygon of extent
ext = matrix(c(-180, 90,
               180, 90,
               180, -90,
               -180, -90), 
             ncol = 2, byrow = TRUE)



# Weight threshold (%) (As Block 2011)
wthr <- 85


# FOLDERS #
setwd('C:/Users/Marisa/Documents/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/1. Dit/')


######## MAIN #######

# Read Shark data
shkData <- fread('TrackPoints.csv')

  # Select spot only for grid_size_test
  if(spotOnly)
  {
    shkData <- shkData[shkData$tagtype == 'SPOT',]
  }
  

  # Select IDs which track exists in the period 2012 - 2016
  if(sel_12_16)
  {
    # Select sharks of 2012-2016
    yr <- format(as.Date(shkData$date), '%Y')
    
    # Find IDs that pass in 2012 - 2016
    ids2012 <- unique(shkData$ID[yr %in% 2012:2016])
    
    shkData <- shkData[shkData$ID %in% ids2012, ]
  }
  
 
  head(shkData)
  
shkData <- ditFun(dta = shkData)


##### SAVE DIT TABLE ####
fwrite(shkData, paste0('dit',res,'.csv'), row.names = FALSE)


#### RASTERS ####
#### 5: Sum all relative densities for each cell ####

# Total Raster for all species #
nPts <- rstFun(dta = shkData[, c('x', 'y', 'dit')], res = resolution, ext = ext, sum)
plot(nPts)

# Save raster data
writeRaster(nPts, paste0('Dit_', res,'.tif'),  format="GTiff", overwrite = TRUE)
  


# Raster for each species #
for(j in unique(shkData$species)) # Loop for each species
{
# j <-   unique(shkData$species)[2]
  
  nPts <- rstFun(dta = shkData[shkData$species == j, c('x', 'y', 'dit')], 
                 res = resolution, ext = ext, sum)
  
#  plot(nPts)
  
  # Save raster data
  writeRaster(nPts, paste0('Dit_',j,'_', res,'.tif'),  format="GTiff", overwrite = TRUE)
  
} # End Loop for each species

