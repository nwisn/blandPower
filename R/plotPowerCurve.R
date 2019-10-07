#' Plot sample size vs power for Bland-Altman limits of agreement test
#'
#' @param powerCurve an object produced by estimatePowerCurve
#' @return a ggplot2 object
plotPowerCurve <- function(powerCurve,...){
  library(ggplot2)
  ggplot(powerCurve) +
    aes(x = CI.n, y = power.power) +
    geom_line() +
    xlab("sample size") +
    ylab("power") +
    ggtitle("Power curve")
}
