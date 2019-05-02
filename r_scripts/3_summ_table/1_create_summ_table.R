#### Summary statistics per Species and Region ####

#### PACKAGES ####
library(GSMP)

#### OPTIONS ####

# Set working directory #
setwd('~/3_summ_table/')

# Analyses type 'Eff_mean' or 'Ov_mean'
analyses <- 'Eff_mean'



#### READ DATA ####

# Read shark data
tbl <- get('SharkData')


#### Calculate overall mean and median ####

# Options: dta = Data;
# reg = colnames of region;
# anty = colnames of analyses type ['Eff_mean' or 'Ov_mean']

overallTbl <- overallFun(dta = tbl, reg = 'Region', anty = analyses, agFac = rep(1,nrow(tbl)))

# Save overall data
write.csv(overallTbl, paste0('Overall_',analyses,'.csv'), row.names = FALSE)



# Exclude CFA_ATL_N from analyses (Unique individual)
nocfa <- tbl[!((tbl$Region == 'ATL_N') & (tbl$Spp == 'CFA')),]

overNoCFA <- overallFun(dta = nocfa, reg = 'Region', anty = analyses, agFac = rep(1,nrow(nocfa)))

# Save overall data
write.csv(overNoCFA, paste0('Overall_NoCFA_',analyses,'.csv'), row.names = FALSE)




#### Calculate Species mean and median ####

# Options: dta = Data;
# reg = colnames of region;
# sp = colnames of species;
# anty = colnames of analyses type ['Eff_mean' or 'Ov_mean']

spReg <- sppFun(dta = nocfa, reg = 'Region', sp = 'Spp', anty = analyses, agFac = rep(1,nrow(nocfa)))

# Save species data
write.csv(spReg, paste0('SppReg_',analyses,'.csv'), row.names = FALSE)
