#### PACKAGES ####
library(GSMP)
require(data.table)

#### OPTIONS ####

# shark analyses c('effort', 'overlap')
analyse <- 'overlap'

# Number of cores 
ncores <- 3


# FOLDERS #
setwd('C:/Users/Marisa/Documents/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/2. Overlap/')
  
  # Shark raster folder
  fld <- 'Monthly_ID/'
  
  # Boat raster folder
  boatFld <- paste0('GFW_ll_month/')
  
  # Export data folder
  export <- 'Overlap/'
  
  dir.create(export, recursive = TRUE)

  
  
#### CALCULATE EFFORT/OVERLAP FOR EACH ID ####

# Available months
mon <- basename(list.dirs(fld, recursive = FALSE))
  mon <- mon[mon != "STATS"]

# Shark raster path
shkPath <- list.files(fld,'.tif', recursive = TRUE, full.names = TRUE)
  
  # Species names
  spp <- basename(dirname(shkPath))
    
  # Exclude other rasters
  shkPath <- shkPath[!is.na(spp)]
  spp <- spp[!is.na(spp)]


# Boat file path
boatFiles <- list.files(boatFld, '.tif', full.names = TRUE)


# Loop for each species
for(sp in na.omit(unique(spp)))
{

  # Calculate species overlap or effort for each month
  spOverLs <- overlapCalc(mon, sp, 
                     boatPath = boatFiles, 
                     shkPath = shkPath[grepl(paste0('^',sp, '_'), basename(shkPath))],
                     analyse)
  
  
  # Save data for each species
  if(length(spOverLs) > 0)
  {
    # Join all Species and all sharks
    allOver <- do.call(rbind, spOverLs)
    
    # Save table with all sharks
    fwrite(allOver,paste0(export, sp,'_all_',analyse,'.csv'), row.names = FALSE )

  }
  
} # End loop for each species




############### PART 2 ###############
#### Aggregate isurus and sphyrna ####


# Shark files
shkPath <- list.files(export, paste0(analyse,'.csv'))

# Species name
spp <- strsplit(shkPath,'_')
spp <- lapply(spp,'[',1)
spp <- unlist(spp)

# Join tables of mako
imk <- spp %in% c('lmk', 'mk')
mkPath <- shkPath[imk]

if(length(mkPath) > 0)
{
  mkLs <- lapply(paste0(export,mkPath), fread)
  mkData <- do.call(rbind, mkLs)
  
  # Save isurus
  fwrite(mkData, paste0(export,'isurus_all_',analyse,'.csv'), row.names = FALSE)

}


# Join tables of sphyrna
isph <- spp %in% c("hsl", "hsm", "hsz" )
sphPath <- shkPath[isph]

if(length(sphPath) > 0)
{
  sphLs <- lapply(paste0(export,sphPath), fread)
  sphData <- do.call(rbind, sphLs)
  
  # Save sphyrna
  fwrite(sphData, paste0(export,'sphyrna_all_',analyse,'.csv'), row.names = FALSE)
}
