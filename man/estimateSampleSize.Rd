% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimateSampleSize.R
\name{estimateSampleSize}
\alias{estimateSampleSize}
\title{Estimate sample size for Bland-Altman limits of agreement test}
\usage{
estimateSampleSize(mu, SD, delta, power = 0.8, gamma = 0.05,
  alpha = 0.05, iterMax = 100, tolerance = 0.001, approx = "t",
  method = "Lu", debug = FALSE, parallel = TRUE, ncores = NULL)
}
\arguments{
\item{mu}{mean of differences}

\item{SD}{standard deviation of differences}

\item{delta}{pre-determined clinical agreement interval}

\item{power}{the pre-determined power}

\item{gamma}{alpha level of Bland-Altman LOA}

\item{alpha}{alpha level of LOA confidence intervals}

\item{iterMax}{maximum number of iterations}

\item{tolerance}{tolerance for how close the power estimate should be to the input}

\item{approx}{normal or t distribution}

\item{method}{whether to use the Lu or Wisniewski method for power}

\item{debug}{logical}

\item{parallel}{logical}

\item{ncores}{number of cores to use for parallel computation}
}
\value{
a list
}
\description{
Estimate sample size for Bland-Altman limits of agreement test
}
