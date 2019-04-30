setwd("~/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/GSMP/")
devtools::use_data_raw()
SharkData_monthly <-
  read.csv('C:/Users/Marisa/Documents/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/r_scripts/5_fig4/SharkData_monthly.csv')
devtools::use_data(SharkData_monthly,  overwrite = TRUE)
data('SharkData_monthly')
head(SharkData_monthly)
