#' Estimate sample size for Bland-Altman limits of agreement test assuming zero mean
#'
#' @param SD standard deviation of differences
#' @param delta pre-determined clinical agreement interval
#' @param power the pre-determined power
#' @param gamma alpha level of Bland-Altman LOA
#' @param alpha alpha level of LOA confidence intervals
#' @param iterMax maximum number of iterations
#' @param tolerance tolerance for how close the power estimate should be to the input
#' @param method whether to use the Lu or Wisniewski method for power
#' @return a sample size
estimateSampleSize_mu0 <- function(SD, delta, power = 0.8, gamma = 0.05, alpha = 0.05, iterMax = 100, tolerance = 0.001, method = "Lu", debug = FALSE){
  zgamma = stats::qnorm(1 - gamma/2, lower.tail = TRUE)
  beta <- 1 - power
  numerator <- (2 + zgamma^2) * SD^2
  denominator <- 2 * (zgamma * SD - delta)^2
  fraction <- numerator/denominator

  # initial estimate
  zalpha <- stats::qnorm(1 - alpha/2, lower.tail = TRUE)
  if(method == "Lu") prob <- 1 - beta/2
  if(method == "Wisniewski") prob <- 1 - 7*beta/8

  tinv0 <- stats::qt(prob,  df = Inf, ncp = zalpha, lower.tail = TRUE)

  n0 <- fraction * tinv0^2

  # iterate until convergence
  n <- n0
  nPrev <- 0
  iter <- 1
  if(debug) nstore <- numeric()
  while(abs(n - nPrev) > tolerance){
    nPrev <- n
    talpha <- stats::qt(1 - alpha/2, df = n - 1, lower.tail = TRUE)
    tinv   <- stats::qt(prob,  df = n - 1, ncp = talpha, lower.tail = TRUE)
    n <- fraction * tinv^2
    if(debug) nstore[iter] <- n
    iter <- iter + 1
    if(iter > iterMax) {
      warning(paste0("did not converge after ", iterMax, " iterations"))
      break
    }
  }
  return(n)
}











#' Estimate sample size for Bland-Altman limits of agreement test
#'
#' @param mu mean of differences
#' @param SD standard deviation of differences
#' @param delta pre-determined clinical agreement interval
#' @param power the pre-determined power
#' @param gamma alpha level of Bland-Altman LOA
#' @param alpha alpha level of LOA confidence intervals
#' @param iterMax maximum number of iterations
#' @param tolerance tolerance for how close the power estimate should be to the input
#' @param approx normal or t distribution
#' @param method whether to use the Lu or Wisniewski method for power
#' @return a list
#' @export
estimateSampleSize <- function(mu, SD, delta, power = 0.8, gamma = 0.05, alpha = 0.05, iterMax = 100, tolerance = 0.001, approx = "t", method = "Lu", debug = FALSE){
  print(method)
  n1 <- floor(estimateSampleSize_mu0(SD, delta, power = power, gamma = gamma, alpha = alpha, iterMax = iterMax, tolerance = tolerance, method = method))
  this_power <- 0
  n <- n1 - 1
  iter <- 1
  while(this_power < power){
    n <- n + 1
    this_powerCurve <- estimatePowerCurve(nMin = n, nMax = n, stepsize = 1, mu, SD, delta, gamma, alpha, approx, method)
    this_power <- estimatePowerFromPowerCurve(this_powerCurve, n)

    iter <- iter + 1
    if(iter > iterMax) {
      warning(paste0("did not converge after ", iterMax, " iterations"))
      break
    }
  }
  return(list(n = as.integer(n), power = this_power))
}



