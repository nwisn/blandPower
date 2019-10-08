#' Estimate power for Bland-Altman limits of agreement test
#'
#' @param powerCurve an object produced by estimatePowerCurve
#' @param power the pre-determined power
#' @return a list
#' @export
estimatePower <- function(powerCurve, n){
  if(!"powerCurve" %in% class(powerCurve)) warning("input is not a powerCurve object")
  if(!n %in% powerCurve$CI.n) warning("The specified n was not evaluated -- finding nearest n")
  powerCurve$power.power[which.min(abs(powerCurve$CI.n - n))]
}
