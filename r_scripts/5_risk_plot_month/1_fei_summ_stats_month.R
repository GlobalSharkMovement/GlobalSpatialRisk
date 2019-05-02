# OPTIONS #

# Set working directory #
setwd('C:/Users/Marisa/Documents/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/3. Fig4/')

# Analyses type 'Eff_median' or 'Ov_median'
analyses <- 'Ov_median'

# PACKAGES #
library(GSMP)

# FUNCTIONS #
#source('FUNCTION_Overall.R')
#source('FUNCTION_SppRegion.R')


#### READ DATA ####

# Read shark data
tbl <- read.csv('SharkData_monthly.csv')

  colnames(tbl)

#### Calculate overall mean and median ####

# Options: dta = Data;
# reg = colnames of region;
# anty = colnames of analyses type ['Eff_mean' or 'Ov_mean']

overallTbl <- overallFun(dta = tbl, reg = 'Region', anty = analyses, agFac = tbl$Spp)
  colnames(overallTbl)[ncol(overallTbl)] <- 'Spp'


# Save overall data
write.csv(overallTbl, paste0('Overall_',analyses,'.csv'), row.names = FALSE)


#### Calculate Species mean and median ####

# Options: dta = Data;
# reg = colnames of region;
# sp = colnames of species;
# anty = colnames of analyses type ['Eff_mean' or 'Ov_mean']

spReg <- sppFun(dta = tbl,
                anty = analyses, reg = 'Region', sp = 'Spp',
                agFac = tbl$month)

  colnames(spReg)[ncol(spReg)] <- 'month'

# Save species data
write.csv(spReg, paste0('SppReg_',analyses,'.csv'), row.names = FALSE)
