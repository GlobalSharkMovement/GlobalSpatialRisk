setwd("~/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/GSMP/")
devtools::use_data_raw()
SharkData <-
  read.csv('C:/Users/Marisa/Documents/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/r_scripts/4_fig3/SharkData.csv')
devtools::use_data(SharkData,  overwrite = TRUE)
data('SharkData')
head(SharkData)
