\name{ditFun}
\alias{ditFun}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Calculate individual geolocation density
}
\description{
Weight tagging location effects on species spatial distribution and overlap by giving a lower weight to shorter tracks.
}
\usage{
ditFun(dta)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dta}{
data.frame with animal geolocations. Must be in the following format: ID,date,x,y
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns a data.frame cointaining original input data, plus a column with point density
}
\references{
Adapted from: BLOCK, Barbara A., et al. Tracking apex marine predator movements in a dynamic ocean. Nature, 2011, 475.7354: 86.
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

# Read Shark data
shkData <- data('trackPts')

ditData <- ditFun(dta = shkData)
head(ditData)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
