# PACKAGES #
library(GSMP)


# OPTIONS #

# Boat Data type c(VMS05, VMS09, AIS)
type <- 'GFW_ll'

# FOLDERS #
setwd('C:/Users/Marisa/Documents/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/r_scripts/')

overFld <- '2_fei/examples/output/'
sharkFld <- '2_fei/examples/'

export <- '5_risk_plot_month/'

#### MAIN ####

# Read shark metadata
meta <- get('egMeta')

# Empty list to hold data
tblLs <- list()

# Loop for both FEI and overlap calculations
for(anty in c('Effort', 'overlap'))
{
  # List overlap files (Obtained from script ~/2_fei/1_fei_calc.r)
  fileLs <- list.files(overFld, tolower(anty), full.names = TRUE)
  fileLs <- fileLs[grepl('_all_',basename(fileLs))]
  
  tbl <- lapply(fileLs, read.csv)

  # Read overlap / FEI data
  overlap <- do.call(rbind, tbl)
  
  # Break names to obtain IDs and Months
  spl <- strsplit(as.character(overlap$id), '_')
  
  # Extract IDs
  ids <- lapply(spl,'[', 3) 
  
  # Extract months
  splMon <- lapply(spl,'[',4)
  
  # Add separate IDs and Months to main table
  overlap$shkID <- unlist(ids)
  overlap$month <- unlist(splMon)
  
  # Remove duplicated column
  overlap <- overlap[,colnames(overlap) != 'id']

  # Replace ID column
  overlap$ID <- overlap$shkID
  
  # Summary statistics of overlap/FEI per ID and month
  summTotal <- agFun(dta = overlap, anty = tolower(anty), overlap$ID, overlap$month)
    colnames(summTotal)[1:2] <- c('ID', 'month')
    
    summTotal <- summTotal[!is.na(summTotal$mean),]
  
  
  # Join overlap/FEI with shark metadata
  mergTbl <- merge(meta[,c("ID","ScientificName", "REGION")],
                   summTotal, by = 'ID', all = TRUE)
  
    colnames(mergTbl)[colnames(mergTbl) %in% c('mean', 'sd')] <- paste0(anty, '_', colnames(mergTbl)[colnames(mergTbl) %in% c('mean', 'sd')])
  
  
  # Add table to list to merge
  tblLs[[which(c('Effort', 'overlap') == anty)]] <- mergTbl[, !(colnames(mergTbl) %in% c('median', 'se'))]
  
} # End loop for each analyses method

# Merge effort and overlap
saveTbl <- Reduce(function(x, y) merge(x, y, by = c("ID","ScientificName", "REGION", 'month'), all=TRUE), 
       tblLs)

# Save data
write.csv(saveTbl, paste0(export, 'eg_shark_data_month.csv'), row.names = FALSE )