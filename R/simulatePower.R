#' Simulate power for Bland-Altman limits of agreement test
#'
#' @param mu mean of differences
#' @param SD standard deviation of differences
#' @param delta pre-determined clinical agreement interval
#' @param n sample size
#' @param nsims number of simulations
#' @param gamma alpha level of Bland-Altman LOA
#' @param alpha alpha level of LOA confidence intervals
#' @return a number expression the power
#' @importFrom magrittr "%>%"
#' @export
simulatePower <- function(mu,
                          SD,
                          delta,
                          n,
                          nsims = 1000,
                          gamma = 0.05,
                          alpha = 0.05){
  sims <- sapply(1:nsims, function(i){
    diffs <- stats::rnorm(n, mean = mu, sd = SD)
    CI <- estimateLimitsOfAgreement(mu = mean(diffs),
                                    SD = stats::sd(diffs),
                                    gamma = gamma) %>%
      estimateConfidenceIntervals(n = n, alpha = alpha)
    testUpper <- CI$CI$upperLOA_upperCI <=  delta
    testLower <- CI$CI$lowerLOA_lowerCI >= -delta
    ifelse(testUpper & testLower, TRUE, FALSE)
  })
  return(sum(sims)/length(sims))
}
