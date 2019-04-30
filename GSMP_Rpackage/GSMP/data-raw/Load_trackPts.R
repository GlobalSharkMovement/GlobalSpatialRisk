setwd("~/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/GSMP_Rpackage/GSMP/")
devtools::use_data_raw()
trackPts <-
  read.csv('C:/Users/Marisa/Documents/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/1a. Dit/TrackPoints.csv')
devtools::use_data(trackPts)
data('trackPts')
head(trackPts)
