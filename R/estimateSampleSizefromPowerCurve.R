#' Estimate sample size for Bland-Altman limits of agreement test
#'
#' @param powerCurve an object produced by estimatePowerCurve
#' @param power the pre-determined power
#' @param tolerance how close the nearest estimated power must be to the pre-determined power
#' @return a list
#' @export
estimateSampleSizeFromPowerCurve <- function(powerCurve, power = 0.8, tolerance = 0.01){
  if(!"powerCurve" %in% class(powerCurve)) warning("input is not a powerCurve object")
  if(min(abs(powerCurve$power.power-power))>tolerance) warning("did not converge within tolerance -- try a smaller stepsize or larger nMax")
  powerCurve$CI.n[which.min(abs(powerCurve$power.power - power))]
}
