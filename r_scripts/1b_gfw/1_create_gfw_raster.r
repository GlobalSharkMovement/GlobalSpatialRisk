#### Create monthly raster of GFW, and average between years ####

# PACKAGES #
library(GSMP)
library(data.table)
library(foreach)

# FOLDERS #
setwd('~/r_scripts/1b_gfw/')

import <- 'examples/'
exportData <- 'monthly_csv/'
exportRst <- 'monthly_rst/'

# OPTIONS #

# boat type for all = NULL; "drifting_longlines"; "purse_seines"
type <- "drifting_longlines"


# Import resolution
impRes <- 0.01

# Export resolution
resolution <- 1

# Raster Extent
ext = matrix(c(-180, 90,
               180, 90,
               180, -90,
               -180, -90),
             ncol = 2, byrow = TRUE)


# Number of cores to run in parallel
ncores <- ceiling(parallel::detectCores())


#### MAIN ####

# List daily 0.01 degree data
orgLs <- list.files(import, '.csv', full.names = TRUE)


# Get year and month of data
yrMonLs <- lapply(strsplit(basename(orgLs), '-'), '[', c(1,2))
yrMonLs <- lapply(yrMonLs, paste, collapse = '-')
yrMonLs <- unlist(yrMonLs)

# Create a raster with sum of boats in each year-month
rstStk <- boatFun(orgLs = orgLs,
                  yrMon = yrMonLs)


##### Average months of all years #####

mn <- lapply(strsplit(names(rstStk), '\\.'), '[', 2)
mn <- unlist(mn)

mnStk <- stackApply(rstStk, indices = mn, mean, na.rm = TRUE)


# Save monthly raster
for(rst in 1:(dim(mnStk)[3]))
{
  rstNam <- gsub('index_', '', names(mnStk)[rst])
  raster::writeRaster(mnStk[[rst]], filename = paste0(type,'_', rstNam, '.tif'), overwrite = TRUE)
}
