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
#' @param nsims number of simulations per sample size
#' @param parallel logical
#' @param ncores number of cores to use in parallel computation
#' @return a dataframe
#' @export
simulatePowerCurve <- function(nMin, nMax, stepsize, mu, SD, delta, gamma = 0.05, alpha = 0.05, nsims = 1000, parallel = TRUE, ncores = NULL){
  samplesizes <- seq(nMin, nMax, by = stepsize)
  if(!parallel){
    result <- sapply(samplesizes, function(n) simulatePower(mu = mu, SD = SD, delta = delta, n = n, nsims = nsims, gamma = gamma, alpha = alpha))
  } else {
    if(is.null(ncores)) ncores <- parallel::detectCores() - 1
    l <- parallel::mclapply(samplesizes, function(n) simulatePower(mu = mu, SD = SD, delta = delta, n = n, nsims = nsims, gamma = gamma, alpha = alpha),
                            mc.cores = ncores)
    result <- do.call(rbind, l)
  }
  return(data.frame(n = samplesizes, power = as.numeric(result)))
}



