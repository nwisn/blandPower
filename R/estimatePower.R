
#' Estimate power for Bland-Altman limits of agreement test
#'
#' @param beta an object produced by estimateTypeIIerror
#' @param method whether to use the Lu or Wisniewski method for power
#' @return a list
estimatePower <- function(beta, method = "Lu"){

  # get from beta object
  if(!"beta" %in% class(beta)) stop("input beta must include a beta object produced by estimateTypeIIerror")
  if(!"CI" %in% class(beta)) stop("input beta must include a CI object produced by estimateConfidenceIntervals")
  if(!"LOA" %in% class(beta)) stop("input beta must include a LOA object produced by estimateLimitsOfAgreement")
  beta1 = beta$beta$beta1
  beta2 = beta$beta$beta2

  if(method == "Lu")          power = 1 - (beta1 + beta2) # Lu eq 5
  if(method == "Wisniewski")  power = (1 - beta1) * (1 - beta2)

  result <- list(
    power = power,
    method = method
  )
  class(result) <- "power"

  joined <- list(LOA = beta$LOA, CI = beta$CI, beta = beta$beta, power = result)
  class(joined) <- list("LOA", "CI", "beta", "power")
  return(joined)
}
