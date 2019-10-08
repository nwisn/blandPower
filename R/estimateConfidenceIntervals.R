
#' Estimate confidence intervals for Bland-Altman limits of agreement
#'
#' @param LOA an object created by estimateLimitsOfAgreement
#' @param n sample size
#' @param alpha alpha level for calculating limits of agreement
#' @return a blandaltman object
estimateConfidenceIntervals <- function(LOA, n, alpha = 0.05){

  # get from LOA object
  if(!"LOA" %in% class(LOA)) stop("input must be an LOA object produced by estimateLimitsOfAgreement")
  lowerLOA <- LOA$lowerLOA
  upperLOA <- LOA$upperLOA
  zgamma <- LOA$zgamma
  SD <- LOA$SD
  mu <- LOA$mu

  # compute standard error on LOA
  se = SD * sqrt( (1/n) + (zgamma^2)/(2*(n - 1)) )

  # compute quantiles of t-distribution
  talpha = stats::qt(1 - alpha/2, df = n - 1, lower.tail = TRUE)

  # compute CI of mean
  mu_upperCI <- mu + talpha * SD * sqrt(1/n)
  mu_lowerCI <- mu - talpha * SD * sqrt(1/n)

  # CI on lower LOA (Lu eq 1)
  lowerLOA_upperCI = lowerLOA + talpha * se
  lowerLOA_lowerCI = lowerLOA - talpha * se

  # CI on upper LOA (Lu eq 2)
  upperLOA_lowerCI = upperLOA - talpha * se
  upperLOA_upperCI = upperLOA + talpha * se

  result <- list(
    n = n,
    se = se,
    alpha = alpha,
    talpha = talpha,
    mu_upperCI = mu_upperCI,
    mu_lowerCI = mu_lowerCI,
    lowerLOA_upperCI = lowerLOA_upperCI,
    lowerLOA_lowerCI = lowerLOA_lowerCI,
    upperLOA_lowerCI = upperLOA_lowerCI,
    upperLOA_upperCI = upperLOA_upperCI
  )
  class(result) <- "CI"

  joined <- list(LOA = LOA, CI = result)
  class(joined) <- list("LOA", "CI")
  return(joined)

}

