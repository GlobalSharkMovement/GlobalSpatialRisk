#### Calculate Species mean and median ####

# Options: dta = Data;
# reg = colnames of region;
# sp = colnames of species;
# anty = colnames of analyses type ['Eff_mean' or 'Ov_mean']

sppFun <- function(dta, reg = 'Region', sp = 'Spp', anty, agFac = agFun(...),...)
{
  # Packages
  #pck <- c('plotrix')
  #lapply(pck, require, character.only = TRUE)


  # Calculate species overall mean and median
  spMean <- GSMP::agFun(dta = dta, anty = anty,dta[,sp]) #dta[,sp]
    colnames(spMean)[1] <- c('Spp')

  spTbl <- data.frame('Region' = 'Overall', spMean)

  # Calculate species per Region mean and median
  spReg <- GSMP::agFun(dta = dta, anty = anty, dta[,reg], dta[,sp], agFac)#
  colnames(spReg)[1:2] <- c('Region','Spp')

  # Join overall and Region
  spSave <- plyr::rbind.fill(spTbl, spReg)

  # ORDER TABLE #

  # Region as factor (in correct order)
  spSave$Region <- factor(spSave$Region,
                             levels = c('Overall','ATL_N',  'AUSTRL', 'IND_SW', 'PAC_NE'))
  spSave <- spSave[!is.na(spSave$Region),]


  # Species order
  spNam <- c('PGL',
             'CLE',
             'IOX',
             'CLO',
             'LNA',
             'LDI',
             'CFA',
             'SPH',
             'GCU',
             'RTY',
             'CCA')

  # Species as factor (in correct order)
  spSave$Spp <- factor(spSave$Spp, levels = spNam)

  # Order Species and Region
  spSave <- spSave[order(spSave$Spp,  spSave$Region),]

  # Add NA to missing combinations
  overallMean <- tidyr::complete(spSave, Spp, Region, fill = list(mean = NA,
                                                              median = NA))

  overallMean <- overallMean[order(overallMean$Region),]

  return(overallMean)
}
