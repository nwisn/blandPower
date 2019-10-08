

#' Estimate Type II error for Bland-Altman limits of agreement test
#'
#' @param CI an object created by estimateConfidenceIntervals
#' @param delta pre-determined clinical agreement level goal
#' @param approx whether to use the normal or student's t approximations
#' @return a blandaltman object
estimateTypeIIerror <- function(CI, delta, approx = "t"){

  # get from CI object
  if(!"CI" %in% class(CI)) stop("input CI must include a CI object produced by estimateConfidenceIntervals")
  if(!"LOA" %in% class(CI)) stop("input CI must include a LOA object produced by estimateLimitsOfAgreement")
  mu = CI$LOA$mu
  SD = CI$LOA$SD
  zgamma = CI$LOA$zgamma
  n = CI$CI$n
  se = CI$CI$se
  alpha = CI$CI$alpha
  talpha = CI$CI$talpha
  upperLOA = CI$CI$upperLOA
  lowerLOA = CI$CI$lowerLOA

  # estimate type-II error beta using Gaussian distribution
  if(approx == "normal"){
    beta1 = stats::pnorm(( upperLOA - delta)/se - stats::qnorm(alpha/2, lower.tail = T))
    beta2 = stats::pnorm((-lowerLOA - delta)/se - stats::qnorm(alpha/2, lower.tail = T))
  }
  # estimate type-II error using non-central t-distribution
  if(approx == "t"){
    tau1 = (delta - mu - zgamma * SD)/se # non-centrality parameter
    tau2 = (delta + mu - zgamma * SD)/se # non-centrality parameter
    beta1 = 1 - stats::pt(talpha, df = n - 1, ncp = tau1, lower.tail = FALSE) # Lu eq 3
    beta2 = 1 - stats::pt(talpha, df = n - 1, ncp = tau2, lower.tail = FALSE) # Lu eq 4
  }

  result <- list(
    delta = delta,
    approx = approx,
    beta1 = beta1,
    beta2 = beta2
  )
  class(result) <- "beta"

  joined <- list(LOA = CI$LOA, CI = CI$CI, beta = result)
  class(joined) <- list("LOA", "CI", "beta")
  return(joined)
}
