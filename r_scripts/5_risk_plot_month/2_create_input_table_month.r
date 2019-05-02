##### PACKAGES ####
library(reshape2)
library(data.table)

#### OPTIONS ####

# Select region to create table # 'PGL_ATL_N' 'IOX_ATL_N'  'GCU_AUSTRL'  'CCA_IND_SW'  'CCA_PAC_NE'
rg <- 'PGL_ATL_N'

# species Name (in correct order)
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

#### FOLDERS ####

# Set working directory
setwd('C:/Users/Marisa/Documents/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/3. Fig4/'
)

# Overall effort path
overallEff <- 'Overall_Eff_median.csv'

# Overall overlap path
overallOv <- 'Overall_Ov_median.csv'

# Species-Region effort path
SpRgEff <- 'SppReg_Eff_median.csv'

# Species-Region overlap path
SpRgOv <- 'SppReg_Ov_median.csv'

#### Main script ####

# READ OVERALL DATA
overLs <- lapply(c(overallEff, overallOv), read.csv)

# Assign filetype (effort or overlap)
overLs <- mapply(cbind, overLs, "type"= c('effort', 'overlap'), SIMPLIFY=F)

# Join effort and overlap in an overall table
overTbl <- do.call(rbind, overLs)


# Group spp and region
overTbl$group <- paste0(overTbl$Spp, '_', overTbl$Region)


# Effort and overlap thresholds to define risk
effBk <- overTbl$mean[(overTbl$type == 'effort') & (overTbl$group == rg)]
ovBk <- overTbl$mean[(overTbl$type == 'overlap') & (overTbl$group == rg)]

v <- data.frame('effort' = effBk, 'overlap' = ovBk)

# Save overall risk threshold
write.csv(v, paste0('RiskThr_', rg, '.csv'), row.names = FALSE)




#### READ Species per Region DATA ####

# Read effort and overlap
SpRgLs <- lapply(c(SpRgEff, SpRgOv), read.csv)

# Assign filetype (effort or overlap)
SpRgLs <- mapply(cbind, SpRgLs, "type"=c('effort', 'overlap'), SIMPLIFY=F)

# Join both tables
tbl <- do.call(rbind, SpRgLs)

# Group spp and region
tbl$group <- paste0(tbl$Spp, '_', tbl$Region)


# Select region in table
tblReg <- tbl[tbl$group == rg,]


# Upper sd
tblReg$upSD <- tblReg$mean + tblReg$sd

# Lower sd
tblReg$lowSD <- tblReg$mean - tblReg$sd
# Minimum SD
tblReg$lowSD[tblReg$lowSD  < 0] <- 0

# Organize data to plot
dta <- data.table::dcast(setDT(tblReg), group + month ~ type, value.var = c('mean', 'upSD', 'lowSD'))
dta <- as.data.frame(dta)

# Maximum overlap SD
dta$upSD_overlap[dta$upSD_overlap > 100] <- 100

# Save table
write.csv(dta, paste0('Input_', rg, '.csv'), row.names = FALSE)

