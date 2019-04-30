# Summary tables function [options: dta = Data; ]
agFun <- function(dta, anty, ...)#x,y,z,mon)
{
  library(reshape2)

  # Mean
  meanTotal <- tapply(dta[,anty], list(...), mean, na.rm = TRUE)
  # Median
  medianTotal <- tapply(dta[,anty], list(...), median, na.rm = TRUE)
  # SD
  sdTotal <- tapply(dta[,anty], list(...), sd, na.rm = TRUE)
  # SE
  seTotal <- tapply(dta[,anty], list(...), std.error, na.rm = TRUE)

  # Convert table format
  mean1 <- melt(meanTotal)
  median1 <- melt(medianTotal)
  sd1 <- melt(sdTotal)
  se1 <- melt(seTotal)


  # Join all data in a table
  tbl <- data.frame(mean1[,grepl('Var', colnames(mean1))],
                    'mean' = mean1$value,'median' = median1$value ,
                    'sd' = sd1$value, 'se' = se1$value)
  return(tbl)
}
