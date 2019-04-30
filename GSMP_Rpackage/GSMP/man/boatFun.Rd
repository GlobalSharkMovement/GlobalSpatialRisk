\name{boatFun}
\alias{boatFun}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to create monthly rasters from original Global Fishing Watch (GFW) data
}
\description{
This function creates a raster stack of year-month total fishing days from original Global Fishing Watch hourly data, in csv.
}
\usage{
boatFun(orgLs, yrMon, type = NULL, impRes = 0.01, ncores = 1, res = 1,
        ext =  matrix(c(-180, 90,180, 90,180, -90,-180, -90), ncol = 2, byrow = TRUE))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{orgLs}{
Vector of path to original GFW daily csv files
}
  \item{yrMon}{
Vector of year-mon, with the same length as orgLs
}
  \item{type}{
Character of gear type to analyse. Defaults to NULL, equals to all fishing vessels. Other options can be "drifting_longlines", "purse_seines"
}
  \item{impRes}{
Numeric, in decimal degrees.  Resolution of imput data. Defaults to 0.01 degree.
}
  \item{ncores}{
Numeric. Number of cores to use for function to run in parallel processing. Defaults to 1 core (no parallel).
}
  \item{res}{
Numeric, in decimal degrees.  Resolution of export data. Defaults to 1 degree.
}
  \item{ext}{
Matrix of extent of output raster, in decimal degrees. Defaults to c(-180,180,-90,90)
}

}
\details{
This function can be time-consuming and requires high memory capacity. We advice to use up to 75 percent of available cores and/or break data into chunks whenever possible.
Further vessel types can be found on the original GFW data, and can also be used with this function.
}
\value{
Returns a raster stack comprised by each year-month raster
}
\references{
https://globalfishingwatch.org/;

KROODSMA, David A., et al. Tracking the global footprint of fisheries. Science, 2018, 359.6378: 904-908.
}
\author{
Marisa Vedor, Ivo da Costa, Nuno Queiroz
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{

import <- '~/r_scripts/1b_boats/examples/'

# List daily 0.01 degree data
orgLs <- list.files(import, '.csv', full.names = TRUE)


# Get year and month of data
yrMonLs <- lapply(strsplit(basename(orgLs), '-'), '[', c(1,2))
yrMonLs <- lapply(yrMonLs, paste, collapse = '-')
yrMonLs <- unlist(yrMonLs)

# Create a raster with sum of boats in each year-month
rstStk <- boatFun(orgLs = orgLs,
                  yrMon = yrMonLs)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
