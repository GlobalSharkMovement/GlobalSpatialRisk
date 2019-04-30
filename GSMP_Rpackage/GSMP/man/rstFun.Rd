\name{rstFun}
\alias{rstFun}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to create rasters from xyz dataframe
}
\description{
This function allows the conversion of a xyz data.frame with non-equally spaced data into a raster
}
\usage{
rstFun(dta, res = 1, ext = matrix(c(-180, 90,
                                     180, 90,
                                     180, -90,
                                     -180, -90),
                                   ncol = 2, byrow = TRUE), ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dta}{
xyz data.frame, with WGS 84 geographical coordinates.
x in decimal degrees +- 180º (West, East)
y in decimal degrees +- 90º (South, North)
}
  \item{res}{ Numeric. Resolution of output raster. Defaults to 1 x 1º
}
  \item{ext}{
Vector or 2x2 matrix of output raster extent. Defaults to c(-180, -90, 180, 90)
}
  \item{\dots}{
function to aggregate spatial data
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Returns a raster, with WGS 84 geographical projection
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
\code{\link{raster}}
\code{\link{rasterize}}
\code{\link{SpatialPointsDataFrame}}
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{


# Raster resolution
resolution <- 1

# Polygon of extent
ext = matrix(c(-180, 90,
               180, 90,
               180, -90,
               -180, -90),
             ncol = 2, byrow = TRUE)


# Read data #
tbl <- data('grid_data')

# Create raster of fishing days
rst <- rstFun(tbl[, c('x', 'y', 'nBoats')], mean, na.rm = TRUE,
              res = resolution, ext = ext)

  plot(rst)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
