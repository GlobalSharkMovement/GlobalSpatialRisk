\name{overallFun}
\alias{overallFun}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Overall tables
}
\description{
Calculate overall mean, median, sd and se of all species
}
\usage{
overallFun(dta, reg = 'Region', anty, agFac = agFun(...),...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dta}{ Data.frame. Input data, in the data.frame format }
  \item{reg}{ Character. Name of column with region information }
  \item{anty}{ Character. Name of column with type of analyses to be done }
  \item{agFac}{ Vector. Factor of aggregation for summary data}
}
\details{}
\value{
Returns a data.frame with mean,median,sd and se for each region. Organised as Table 4 extended (in references)
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
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
# Read data
tbl <- data('SharkData')
overallFun(dta = tbl, reg = 'Region', anty = 'Ov_mean', agFac = rep(1, nrow(tbl)))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
