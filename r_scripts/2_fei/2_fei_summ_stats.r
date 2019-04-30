# PACKAGES #
library(reshape2)
library(plotrix)
library(lattice)
library(zoo)
library(GSMP)

# OPTIONS #

# shark analyses c('effort', 'overlap')
analyse <- 'overlap'

# FOLDERS #
setwd('C:/Users/Marisa/Documents/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/2. Overlap/Overlap/')


#### MAIN ####


# Read shark metadata
meta <- read.csv('Metadata.csv')

  # Join species and id for complete name
  meta$ID <- paste0(meta$ScientificName, '_', meta$ID)

# List overlap files
fileLs <- list.files(getwd(),tolower(analyse), full.names = TRUE)
fileLs <- fileLs[grepl('_all_',basename(fileLs))]

# Remove individual tables of species that were aggregated (Sphyrna and Isurus)
fileLs <- fileLs[!grepl(paste(c('lmk', 'mk', "hsl", "hsm", "hsz" ), collapse = '|'), basename(fileLs))]

tbl <- lapply(fileLs, read.csv)

  
  # Read data
  overlap <- do.call(rbind, tbl)

  # Break names to obtain IDs and Months
  spl <- strsplit(as.character(overlap$id), '_')
  
  # Extract IDs
  splOv <- lapply(spl,'[',c(1,2))
  ids <- lapply(splOv, paste, collapse = '_')
  
  # Extract months
  splMon <- lapply(spl,'[',4)
  
  # Add separate IDs and Months to main table
  overlap$shkID <- unlist(ids)
  overlap$month <- unlist(splMon)
  
  overlap <- overlap[,colnames(overlap) != 'id']
  
  
  # Join overlap with shark metadata
  mergTbl <- merge(meta[,c("ID","ScientificName", "REGION")], 
                   overlap, by.x = 'ID', by.y = 'shkID', all.x = TRUE)
  
  
  #### Adapt table ####
  

    mergTbl$ScientificName <- as.character(mergTbl$ScientificName)  
  
    # Join all mako species
    mergTbl$ScientificName[grepl('Isurus', mergTbl$ScientificName)] <- 'Isurus sp.'
    
    # Join all sphyrna species
    mergTbl$ScientificName[grepl('Sphyrna*', mergTbl$ScientificName)] <- 'Sphyrna sp.'
    
    
    
    # Remove "Other" ocean
    #mergTbl <- mergTbl[mergTbl$REGION != 'OTHER',]
    
    mergTbl$REGION <- as.character(mergTbl$REGION)
    
    
    # Add zero to no overlap IDs
    mergTbl[,tolower(analyse)][is.na(mergTbl[,tolower(analyse)])] <- 0
    
  
  
  #### SUMMARY TABLE ####
    
  # Select VIP species and IDs where there are overlap
  vipTbl <- mergTbl#[tolower(mergTbl$ScientificName) %in% c(vis, is),]
    
    if(nrow(vipTbl) == 0)
    {next}
    
      vipTbl$month <- factor(as.numeric(vipTbl$month), levels = 1:12)

    vipTbl$REGION <- factor(vipTbl$REGION, levels = c("ATL_N","AUSTRL", "IND_SW", "PAC_NE"))
  
  # Min, Max, Mean overlap per species and sex all oceans 
  summTotal <- agFun(dta = vipTbl, anty = analyse, vipTbl$ID)
    colnames(summTotal)[1] <- c('ID')

    
  summTotal <- merge(meta[,c("ID","Spp","ScientificName", "REGION")], 
    summTotal, by = 'ID')
    
    
  # Save Species table
  write.csv(summTotal, paste0('SharkData_',analyse,'.csv'), row.names = FALSE )

  
  ###### PART 2 : (RUN AFTER OVERLAP AND EFFORT FILES ARE CREATED) #######
  
  ##### Read data #####
  
  # Read ID data
  fileLs <- list.files(export, 'SharkData_', recursive = FALSE, full.names = TRUE)
  tblLs <- lapply(fileLs, read.csv)
  
  iEff <- grep('effort', basename(fileLs))
  iOv <- grep('overlap', basename(fileLs))
  
  
  colnames(tblLs[[iEff]])[7:ncol(tblLs[[iEff]])] <- paste0('Eff_',colnames(tblLs[[iEff]])[7:ncol(tblLs[[iEff]])])
  
  colnames(tblLs[[iOv]])[7:ncol(tblLs[[iOv]])] <- paste0('Ov_',colnames(tblLs[[iOv]])[7:ncol(tblLs[[iOv]])])
  
  
  
  tbl <- Reduce(function(dtf1, dtf2) merge(dtf1, dtf2, 
                                           by = c("ID","Spp","ScientificName",
                                                  "Region","TAG_TYPE"), all.x = TRUE),tblLs)
  
  write.csv(tbl, paste0(export, 'SharkData.csv'), row.names = FALSE)
  
  
  
  
  