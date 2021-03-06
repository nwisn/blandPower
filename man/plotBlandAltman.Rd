% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotBlandAltman.R
\name{plotBlandAltman}
\alias{plotBlandAltman}
\title{Bland-Altman plot}
\usage{
plotBlandAltman(x, y, gamma = 0.05, alpha = 0.05, sigfigs = 2)
}
\arguments{
\item{x}{measurement vector from device 1}

\item{y}{measurement vector from device 2}

\item{gamma}{alpha level for calculating limits of agreement}

\item{alpha}{alpha level for calculating limits of agreement confidence intervals}

\item{sigfigs}{number of significant digits to display}
}
\value{
a ggplot2 object
}
\description{
Bland-Altman plot
}
\examples{
  plotBlandAltman(1:20, rnorm(20))
}
