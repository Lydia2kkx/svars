% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bootstrap_mb.R
\name{mb.boot}
\alias{mb.boot}
\title{Moving block bootstrap for IRFs of identified SVARs}
\usage{
mb.boot(x, b.length = 15, n.ahead = 20, nboot = 500, nc = 1,
  dd = NULL, signrest = NULL, itermax = 300, steptol = 200,
  iter2 = 50)
}
\arguments{
\item{x}{SVAR object of class "svars"}

\item{b.length}{Integer. Length of each block}

\item{n.ahead}{Integer specifying the steps}

\item{nboot}{Integer. Number of bootstrap iterations}

\item{nc}{Integer. Number of processor cores (Not available on windows machines)}

\item{dd}{Object of class 'indepTestDist'. A simulated independent sample of the same size as the data.
If not supplied, it will be calculated by the function}

\item{signrest}{A list with vectors containing 1 and -1, e.g. c(1,-1,1), indicating a sign pattern of specific shocks to be tested
with the help of the bootstrap samples.}

\item{itermax}{Integer. Maximum number of iterations for DEoptim}

\item{steptol}{Numeric. Tolerance for steps without improvement for DEoptim}

\item{iter2}{Integer. Number of iterations for the second optimization}
}
\value{
A list of class "sboot" with elements
\item{true}{Point estimate of impulse response functions}
\item{bootstrap}{List of length "nboot" holding bootstrap impulse response functions}
\item{SE}{Bootstraped standard errors of estimated covariance decomposition
(only if "x" has method "Cramer von-Mises", or "Distance covariances")}
\item{nboot}{Number of bootstrap iterations}
\item{b_length}{Length of each block}
\item{point_estimate}{Point estimate of covariance decomposition}
\item{boot_mean}{Mean of bootstrapped covariance decompositions}
\item{signrest}{Evaluated sign pattern}
\item{sign_complete}{Frequency of appearance of the complete sign pattern in all bootstrapped covariance decompositions}
\item{sign_part}{Frequency of bootstrapped covariance decompositions which conform the complete predetermined sign pattern. If signrest=NULL,
 the frequency of bootstrapped covariance decompositions that hold the same sign pattern as the point estimate is provided.}
\item{sign_part}{Frequency of single shocks in all bootstrapped covariance decompositions which accord to a specific predetermined sign pattern}
\item{cov_bs}{Covariance matrix of bootstrapped parameter in impact relations matrix}
\item{method}{Used bootstrap method}
}
\description{
Calculating confidence bands for impulse response via moving block bootstrap
}
\examples{
\donttest{
# data contains quarterly observations from 1965Q1 to 2008Q3
# x = output gap
# pi = inflation
# i = interest rates
set.seed(23211)
v1 <- vars::VAR(USA, lag.max = 10, ic = "AIC" )
x1 <- id.dc(v1)
summary(x1)

# impulse response analysis with confidence bands
# Checking how often theory based impact relations appear
signrest <- list(demand = c(1,1,1), supply = c(-1,1,1), money = c(-1,-1,1))
bb <- mb.boot(x1, b.length = 15, nboot = 500, n.ahead = 30, nc = 1, signrest = signrest)
summary(bb)
plot(bb, lowerq = 0.16, upperq = 0.84)
}

}
\references{
Brueggemann, R., Jentsch, C., and Trenkler, C. (2016). Inference in VARs with conditional heteroskedasticity of unknown form. Journal of Econometrics 191, 69-85.\cr
  Herwartz, H., 2017. Hodges Lehmann detection of structural shocks -
       An analysis of macroeconomic dynamics in the Euro Area, Oxford Bulletin of Economics and Statistics.
}
\seealso{
\code{\link{id.cvm}}, \code{\link{id.dc}}, \code{\link{id.ngml}}, \code{\link{id.cv}} or \code{\link{id.st}}
}
