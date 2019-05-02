#### Risk plot, for all months of a species within one region ####


#### PACKAGES ####
library(fields)
library(GSMP)

#### OPTIONS ####

# Select species and region to plot # 'PGL_ATL_N' 'IOX_ATL_N'  'GCU_AUSTRL'  'CCA_IND_SW'  'CCA_PAC_NE'
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
setwd('~/5_risk_plot_month/')

# Path to files obtained from 2_create_input_table_month.r #

  # Overall risk threshold path
  overRisk <- paste0('RiskThr_', rg, '.csv')

  # Species-Region effort and overlap path
  SpRg <- paste0('Input_',rg,'.csv')



#### Main script ####

# Read Species - Region data
dta <- read.csv(SpRg)

  dta$month <- factor(dta$month, levels = 1:12)

  # Order months
  dta <- dta[order(as.numeric(dta$month)),]


# Read overall risk
v <- read.csv(overRisk)
  v <- as.numeric(v)

#### Save kobe plot ####
graphics.off()

print(kobePlot(dta = dta, xNam = 'mean_effort', yNam = 'mean_overlap', gp = 'month',
               xSdUp = "upSD_effort", xSdLow = "lowSD_effort",
               ySdUp = "upSD_overlap", ySdLow = "lowSD_effort",
               v = v, colPlt = tim.colors(12), gline = TRUE))

ggsave(paste0('Fig4_', rg,'.pdf'), paper = 'a4r',
       width = 250, height = 150, units = 'mm')

graphics.off()
