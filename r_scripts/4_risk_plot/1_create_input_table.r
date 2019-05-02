#### Create input table for risk plot, all species within one region ####

##### PACKAGES ####
library(ggplot2)
library(reshape2)
library(data.table)

#### OPTIONS ####

# Select region to create table # 'Overall' 'ATL_N'   'AUSTRL'  'IND_SW'  'PAC_NE'
rg <- 'PAC_NE'

# Mean or Median
md <- 'Mean'

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
setwd('~/4_risk_plot/')


##### Output files from script in "~/3_summ_table/1_create_summ_table.r" #####

# Overall effort path
overallEff <- 'Overall_mean&median_effort_02-17.csv'

# Overall overlap path
overallOv <- 'Overall_mean&median_overlap_02-17.csv'

# Species-Region effort path
SpRgEff <- 'Spp_mean&median_effort_02-17.csv'

# Species-Region overlap path
SpRgOv <- 'Spp_mean&median_overlap_02-17.csv'

#### Main script ####

# READ OVERALL DATA
overLs <- lapply(c(overallEff, overallOv), read.csv)

# Assign filetype (effort or overlap)
overLs <- mapply(cbind, overLs, "type"= c('effort', 'overlap'), SIMPLIFY=F)

# Join effort and overlap in an overall table
overTbl <- do.call(rbind, overLs)

# Effort and overlap thresholds to define risk
effBk <- overTbl[(overTbl$type == 'effort') & (overTbl$Region == rg), tolower(md)]
ovBk <- overTbl[(overTbl$type == 'overlap') & (overTbl$Region == rg), tolower(md)]

v <- data.frame('effort' = effBk, 'overlap' = ovBk)

# Save overall risk threshold
write.csv(v, paste0(md,'_RiskThr_', rg, '.csv'), row.names = FALSE)




#### READ Species per Region DATA ####

# Read effort and overlap
SpRgLs <- lapply(c(SpRgEff, SpRgOv), read.csv)

# Assign filetype (effort or overlap)
SpRgLs <- mapply(cbind, SpRgLs, "type"=c('effort', 'overlap'), SIMPLIFY=F)

# Join both tables
tbl <- do.call(rbind, SpRgLs)

# Select region in table
tblReg <- tbl[tbl$Region == rg,]

# Upper sd
tblReg$upSD <- tblReg[, tolower(md)] + tblReg$sd

# Lower sd
tblReg$lowSD <- tblReg[, tolower(md)] - tblReg$sd
# Minimum SD
tblReg$lowSD[tblReg$lowSD  < 0] <- 0

# Organize data to plot
dta <- data.table::dcast(setDT(tblReg), Spp ~ type, value.var = c(tolower(md), 'upSD', 'lowSD'))
dta <- as.data.frame(dta)

# Maximum overlap SD
dta$upSD_overlap[dta$upSD_overlap > 100] <- 100

# Order species as in paper (References)
dta$Spp <- factor(dta$Spp, levels = spNam)
dta <- dta[order(dta$Spp),]

# Save table
write.csv(dta, paste0(md, '_Input_', rg, '.csv'), row.names = FALSE)

