#### Calculate monthly Dit for each individual shark, in spatial grid ####

#### PACKAGES ####
library(data.table)
library(foreach)
library(GSMP)

#### GENERAL OPTIONS #####

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


# Number of cores to use in parallel
ncores <- ceiling(parallel::detectCores()*0.5)


#### FOLDERS ####
setwd('~/1a_dit/examples/')

# FILE PATH
ditPath <- paste0('dit',res, '.csv')



##### READ DIT TABLE ####

shkData <- fread(ditPath)
shkData <- as.data.frame(shkData)

# Extract year
yrLs <- format(as.Date(shkData$date), '%Y')

# Extract month
mnLs <- format(as.Date(shkData$date), '%m')


#### Create monthly raster ####

# CAN BE PARALLELIZED...
print('Processing in parallel... ')
cl = parallel::makeCluster(ncores)
doParallel::registerDoParallel(cl, cores = ncores)



# LOOP FOR EACH MONTH
for(mn in unique(mnLs))
{
#    mn <-  "01"

  # Select data
  selData <- (mnLs == mn)

  if(all(selData == FALSE))
  {next}

  # LOOP FOR EACH ID
  foreach::foreach(id = unique(shkData$ID[selData]),
                         .export= c('shkData', 'selData'),
                         .packages = (.packages())) %dopar%{

    # Raster for each species#
    nPts <- rstFun(shkData[selData & (shkData$ID == id),
                           c('x', 'y', 'dit')],
                   res = resolution, ext = ext, sum)

    # plot(nPts)

    sp <- unique(shkData$species[selData & (shkData$ID == id)])

    # Save raster data
    writeRaster(nPts, paste0('Dit_',sp,'_',id,'_',mn,'_', res,'.tif'),  format="GTiff", overwrite = TRUE)

  } # End loop for each shark

} # End loop for each month

# End parallel run
parallel::stopCluster(cl)
closeAllConnections()
