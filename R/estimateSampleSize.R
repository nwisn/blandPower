#' Estimate sample size for Bland-Altman limits of agreement test
#'
#' @param powerCurve an object produced by estimatePowerCurve
#' @param power the pre-determined power
#' @return a list
estimateSampleSize <- function(powerCurve, power = 0.8){
  powerCurve$CI.n[which.min(abs(powerCurve$power.power - power))]
}
