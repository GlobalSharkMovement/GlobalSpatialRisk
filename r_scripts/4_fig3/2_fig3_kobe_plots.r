##### PACKAGES ####
library(GSMP)

#### OPTIONS ####

# Select region to plot # 'Overall' 'ATL_N'   'AUSTRL'  'IND_SW'  'PAC_NE'
rg <- 'PAC_NE'

# Mean or Median
md <- 'Median'

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
setwd('C:/Users/Marisa/Documents/PhD/Shark data/WorldSharks/Global Fishery Interactions/Revision2/CleanScripts/5. Fig3/'
)

  # Overall risk threshold path
  overRisk <- paste0(md,'_RiskThr_', rg, '.csv')

  # Species-Region effort and overlap path
  SpRg <- paste0(md, '_Input_',rg,'.csv')

#### FUNCTIONS ####

# Kobe plots
#source('FUNCTION_kobePlot.r')


#### Main script ####

# Read Species - Region data
dta <- read.csv(SpRg)

  # Order species as in paper (References)
  dta$Spp <- factor(dta$Spp, levels = spNam)
  dta <- dta[order(dta$Spp),]

# Read overall risk
v <- read.csv(overRisk)
  v <- as.numeric(v)
  
  
  
  


##### Define breaks #####
#### (Cut x axis by the rounded 5 closer to the max effort) ####

# X axis
effMax <- max(dta$median_effort, na.rm = TRUE)
effMax <- formatC(effMax, format = "e", digits = 3)

pwr <- as.numeric(strsplit(as.character(effMax),'e')[[1]][2])

upCut <- ceiling((as.numeric(effMax) * 10^(-pwr))/0.5)*0.5
cutPlt <- upCut * 10^(pwr)

xBks <- unique(c(0,seq(0,cutPlt,by = 5*10^(pwr-1)),cutPlt))



dta$upSD_effort[dta$upSD_effort > cutPlt] <- cutPlt 

  
  
#### Save kobe plot ####
graphics.off()

print(kobePlot(dta = dta, xNam = paste0(tolower(md),'_effort'), 
               yNam = paste0(tolower(md),'_overlap'), 
               gp = 'Spp',
               xSdUp = "upSD_effort", xSdLow = "lowSD_effort",
               ySdUp = "upSD_overlap", ySdLow = "lowSD_effort",
               v = v, cutPlt = cutPlt, xBks = xBks))

ggsave(paste0('Fig3_', rg,'.pdf'), paper = 'a4r',
       width = 250, height = 150, units = 'mm')

graphics.off()
