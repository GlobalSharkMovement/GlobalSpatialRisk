setwd("~/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/GSMP/")
devtools::use_data_raw()
egMeta <-
  read.csv('C:/Users/Marisa/Documents/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/2. Overlap/Overlap/Metadata.csv')
devtools::use_data(egMeta, overwrite = TRUE)
data('egMeta')
head(egMeta)
