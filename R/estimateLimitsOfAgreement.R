
#' Estimate Bland-Altman limits of agreement
#'
#' @param mu mean of the pairwise differences
#' @param SD standard deviation of the pairwise differences
#' @param n number of samples
#' @param gamma alpha level for calculating limits of agreement
#' @return a list
estimateLimitsOfAgreement <- function(mu, SD, gamma = 0.05){

  # compute limits of agreement
  zgamma = qnorm(1 - gamma/2, lower.tail = TRUE)
  upperLOA = mu + zgamma * SD
  lowerLOA = mu - zgamma * SD

  result <- list(mu = mu,
       SD = SD,
       gamma = gamma,
       zgamma = zgamma,
       upperLOA = upperLOA,
       lowerLOA = lowerLOA)

  class(result) <- "LOA"
  return(result)
}
