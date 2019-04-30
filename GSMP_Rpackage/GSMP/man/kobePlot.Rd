\name{kobePlot}
\alias{kobePlot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to do Kobe Plots
}
\description{
Plot 4 areas of risk in relation to a given overall threshold
}
\usage{
kobePlot(dta, xNam = 'mean_effort', yNam = 'mean_overlap', gp = 'Spp',
                     xSdUp = 0, xSdLow = 0, ySdUp = 0, ySdLow = 0,
                     v, colPlt = colScale, gline = FALSE,
                     cutPlt = xxmax, xBks = seq(0,cutPlt, length.out = 10),
                     cutY = 100, yBks = seq(0,cutY, length.out = 5),...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dta}{data.frame containing factor to be plotted, mean x and y risk values and standard deviation or standard error (optional) }
  \item{xNam}{name of column containing information of x axis to be plotted. Defaults to 'mean_effort'}
  \item{yNam}{name of column containing information of y axis to be plotted. Defaults to 'mean_effort'}
  \item{gp}{grouping factor. Defaults to 'Spp'}
  \item{xSdUp}{name of column containing information of SD or SE upper value of x axis to be plotted as an errorbar. Defaults to 0}
  \item{xSdLow}{name of column containing information of SD or SE lower value of x axis to be plotted as an errorbar. Defaults to 0}
  \item{ySdUp}{name of column containing information of SD or SE upper value of y axis to be plotted as an errorbar. Defaults to 0}
  \item{ySdLow}{name of column containing information of SD or SE lower value of y axis to be plotted as an errorbar. Defaults to 0}
  \item{v}{vector(x,y) of risk threshold. x: x axis threshold; y: yaxis threshold}
  \item{colPlt}{Colour vector to colour geom_points. Defaults to Species colour as in paper (See References). NULL returns automatically coloured points}
  \item{gline}{Logical. Connect points by a line? TRUE draws a geom_path connecting the plotted points. Default to FALSE.}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Kobe plot with 4 risk areas: green: Low effort and overlap risk; yellow: either overlap or effort with high risk, but low for the other variable. red: high effort and overlap risk
}
\references{
Adapted from https://gist.github.com/jcquiroz/2695825
}
\author{
Marisa Vedor, Ivo da Costa, Nuno Queiroz
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{overallFun}}
\code{\link{sppFun}}
}
\examples{

# Read Species data

dta <- data.frame('Spp' = factor(c('PGL', 'IOX', 'CCA', 'GCU')),
'mean_effort' = c(1e-5, 0.5e-5, 0.8e-5, 0.1e-5),
'mean_overlap' = c(70,65,50,10),
"upSD_effort" = c(1e-5, 0.5e-5, 0.8e-5, 0.1e-5) + 0.1e-5
"lowSD_effort" = c(1e-5, 0.5e-5, 0.8e-5, 0.1e-5) - 0.1e-5
"upSD_overlap" = c(70,65,50,10) + 10
"lowSD_effort" = c(70,65,50,10) - 10
)


# Read overall risk
v <- c(mean(dta$mean_effort), mean(dta$mean_overlap))

#### Save kobe plot ####
print(kobePlot(dta = dta, xNam = 'mean_effort', yNam = 'mean_overlap', gp = 'Spp',
               xSdUp = "upSD_effort", xSdLow = "lowSD_effort",
               ySdUp = "upSD_overlap", ySdLow = "lowSD_effort",
               v = v))

ggsave(paste0('Fig3_', rg,'.pdf'), paper = 'a4r',
       width = 250, height = 150, units = 'mm')
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
