#### Calculate overall mean and median ####

# Options: dta = Data;
# reg = colnames of region;
# anty = colnames of analyses type ['Eff_mean' or 'Ov_mean']

overallFun <- function(dta, reg = 'Region', anty, agFac = agFun(...),...)
{
  # Overall summary stats
  ovTbl <- agFun(dta = dta,  anty = anty, rep(1, nrow(dta)))
  colnames(ovTbl)[1] <- 'Region'
  ovTbl$Region <- 'Overall'

  # Region summary stats
  regTbl <- agFun(dta = dta, anty = anty, dta[,reg], agFac)
  colnames(regTbl)[1] <- 'Region'

  # Join overall and Region
  tblSave <- plyr::rbind.fill(ovTbl, regTbl)

  return(tblSave)
}
