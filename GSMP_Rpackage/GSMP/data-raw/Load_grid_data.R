setwd("~/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/GSMP/")
devtools::use_data_raw()
grid_data <-
  read.csv('C:/Users/Marisa/Documents/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/Grid_data.csv')
devtools::use_data(grid_data,  overwrite = TRUE)
data('grid_data')
head(grid_data)
