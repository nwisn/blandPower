

#' Plot confidence interval curves for Bland-Altman limits of agreement test
#'
#' @param powerCurve an object produced by estimatePowerCurve
#' @return a ggplot2 object
#' @importFrom magrittr "%>%"
#' @export
plotConfidenceIntervalCurve <- function(powerCurve){
  if(!"powerCurve" %in% class(powerCurve)) warning("input is not a powerCurve object")
  features <- c("LOA.mu",
                "LOA.upperLOA",
                "LOA.lowerLOA",
                "CI.lowerLOA_upperCI",
                "CI.lowerLOA_lowerCI",
                "CI.upperLOA_lowerCI",
                "CI.upperLOA_upperCI")

  class(powerCurve) <- "data.frame"
  plotdf <- powerCurve %>%
    dplyr::select(c("CI.n", "beta.delta", features)) %>%
    tidyr::pivot_longer(cols = features)

  plotdf <- plotdf %>%
    dplyr::mutate(feature = sapply(stringr::str_split(plotdf$name, "[.]"), function(x) x[1]))

  plotdf %>%
    ggplot2::ggplot() +
    ggplot2::aes(x = plotdf$CI.n,
                 y = plotdf$value,
                 color = plotdf$feature,
                 group = plotdf$name) +
    ggplot2::geom_line() +
    ggplot2::geom_hline(yintercept = c(-plotdf$beta.delta, plotdf$beta.delta), lty = 2) +
    ggplot2::xlab("sample size") +
    ggplot2::ylab("value") +
    ggplot2::labs(color = "") +
    ggplot2::ggtitle("Confidence intervals") +
    ggplot2::theme_bw()
}
