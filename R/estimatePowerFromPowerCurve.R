#' Estimate power for Bland-Altman limits of agreement test
#'
#' @param powerCurve an object produced by estimatePowerCurve
#' @param n the pre-determined sample size
#' @return a list
#' @export
estimatePowerFromPowerCurve <- function(powerCurve, n){
  if(!"powerCurve" %in% class(powerCurve)) warning("input is not a powerCurve object")
  if(!n %in% powerCurve$CI.n) warning("The specified n was not evaluated -- finding nearest n")
  powerCurve$power.power[which.min(abs(powerCurve$CI.n - n))]
}
