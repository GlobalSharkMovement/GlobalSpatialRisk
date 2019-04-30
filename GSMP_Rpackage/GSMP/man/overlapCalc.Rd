\name{overlapCalc}
\alias{overlapCalc}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to calculate overlap and Fishing Effort Index
}
\description{
This function calculates the monthly overlap and fishing effort index of each individual in gridded data
}
\usage{
overlapCalc(mon = c('01','02','03','04','05','06','07','08','09','10','11','12'),
                        sp, boatPath, shkPath, analyse = 'overlap', ncores = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mon}{
Character vector of months to calculate overlap, with double digits. Eg: January is '01'. Defaults to c('01','02','03','04','05','06','07','08','09','10','11','12')
}
  \item{sp}{
Character of unique species to analyse
}
  \item{boatPath}{
Path to boat files of monthly rasters
}
  \item{shkPath}{
  Path to individual dit (density of tracking data) files
}
  \item{analyse}{
  Analysis type: 'effort' or 'overlap'. Defaults to 'overlap'
}
  \item{ncores}{
  Number of cores to use in parallel. Defaults to 1 (no parallel run).
}


}
\details{
This function can be time-consuming and requires high memory capacity. We advice to use up to 75 percent of available cores and/or break data into chunks whenever possible.
}
\value{
Returns a list of data.frames, where each level is a different month within a species
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Marisa Vedor, Ivo da Costa, Nuno Queiroz
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{boatFun}}
\code{\link{ditFun}}
}
\examples{

fld <- '~/r_scripts/2_fei/examples/'

# Shark raster path
shkPath <- list.files(fld,'.tif', recursive = TRUE, full.names = TRUE)

  # Species names
  spp <- basename(dirname(shkPath))

  # Exclude other rasters
  shkPath <- shkPath[!is.na(spp)]
  spp <- spp[!is.na(spp)]


# Boat file path
boatFiles <- list.files(boatFld, '.tif', full.names = TRUE)

# Calculate species overlap or effort for each month
spOverLs <- overlapCalc(mon = c('01', '02'), sp = 'bk',
                   boatPath = boatFiles,
                   shkPath = shkPath[grepl(paste0('^',sp, '_'), basename(shkPath))],
                   analyse)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
