#' Plot sample size vs power for Bland-Altman limits of agreement test
#'
#' @param powerCurve an object produced by estimatePowerCurve
#' @return a ggplot2 object
#' @export
plotPowerCurve <- function(powerCurve){
  ggplot2::ggplot(powerCurve) +
    ggplot2::aes(x = powerCurve$CI.n, y = powerCurve$power.power) +
    ggplot2::geom_line() +
    ggplot2::xlab("sample size") +
    ggplot2::ylab("power") +
    ggplot2::ggtitle("Power curve")
}
