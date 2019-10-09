
#' Estimate power curve for Bland-Altman limits of agreement test
#'
#' @param nMin minimum sample size
#' @param nMax maximum sample size
#' @param stepsize number of samples to step between nMin and nMax
#' @param mu mean of differences
#' @param SD standard deviation of differences
#' @param delta pre-determined clinical agreement interval
#' @param gamma alpha level of Bland-Altman LOA
#' @param alpha alpha level of LOA confidence intervals
#' @param approx normal or t distribution
#' @param method whether to use the Lu or Wisniewski method for power
#' @param parallel logical
#' @param ncores number of cores for parallel computation
#' @return a dataframe
#' @importFrom magrittr "%>%"
#' @export
estimatePowerCurve <- function(nMin = 10,
                               nMax = 100,
                               stepsize = 1,
                               mu,
                               SD,
                               delta,
                               gamma = 0.05,
                               alpha = 0.05,
                               approx = "t",
                               method = "Lu",
                               parallel = TRUE,
                               ncores = NULL){
  samplesizes <- seq(nMin, nMax, by = stepsize)
  LOA <- estimateLimitsOfAgreement(mu = mu, SD = SD, gamma = gamma)
  if(!parallel){
    df <- lapply(samplesizes, function(this_n){
      LOA %>%
        estimateConfidenceIntervals(n = this_n, alpha = alpha) %>%
        estimateTypeIIerror(delta = delta, approx = approx) %>%
        estimatePowerFromBeta(method = method) %>%
        unlist(recursive = FALSE) %>%
        as.data.frame()
    })
  } else {
    if(is.null(ncores)) ncores <- parallel::detectCores() - 1
    df <- parallel::mclapply(samplesizes, function(this_n){
      LOA %>%
        estimateConfidenceIntervals(n = this_n, alpha = alpha) %>%
        estimateTypeIIerror(delta = delta, approx = approx) %>%
        estimatePowerFromBeta(method = method) %>%
        unlist(recursive = FALSE) %>%
        as.data.frame()
    }, mc.cores = ncores)
  }

  result <- do.call(rbind, df)
  class(result) <- list("data.frame", "powerCurve")
  return(result)
}
