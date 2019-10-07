

#' Plot confidence interval curves for Bland-Altman limits of agreement test
#'
#' @param powerCurve an object produced by estimatePowerCurve
#' @return a ggplot2 object
plotConfidenceIntervalCurve <- function(powerCurve){
  require(tidyverse)
  require(stringr)
  features <- c("LOA.mu",
                "LOA.upperLOA",
                "LOA.lowerLOA",
                "CI.lowerLOA_upperCI",
                "CI.lowerLOA_lowerCI",
                "CI.upperLOA_lowerCI",
                "CI.upperLOA_upperCI")

  plotdf <- powerCurve %>%
    select(c(CI.n, beta.delta, features)) %>%
    pivot_longer(cols = features) %>%
    mutate(feature = sapply(str_split(name, "[.]"), function(x) x[1]))

  plotdf %>%
    ggplot() +
    aes(x = CI.n, y = value, color = feature, group = name) +
    geom_line() +
    geom_hline(yintercept = c(-plotdf$beta.delta, plotdf$beta.delta), lty = 2) +
    xlab("sample size") +
    theme_bw()
}
