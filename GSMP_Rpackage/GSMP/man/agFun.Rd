\name{agFun}
\alias{agFun}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Aggregation Function
}
\description{
Function to create summary tables: Aggregated mean, median, sd and se
}
\usage{
agFun(dta, anty, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dta}{ Input data, in the data.frame format }
  \item{anty}{ Name of column with type of analyses to be done }
  \item{...}{ Further arguments to be passed to the aggregation function. Vector of aggregation factor. }
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
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

# Read shark data
tbl <- data('SharkData')

agFun(dta = tbl, anty = 'Ov_mean', tbl$Spp)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
