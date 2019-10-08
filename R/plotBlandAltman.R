
#' Bland-Altman plot
#'
#' @param x measurement vector from device 1
#' @param y measurement vector from device 2
#' @param gamma alpha level for calculating limits of agreement
#' @param alpha alpha level for calculating limits of agreement confidence intervals
#' @param sigfigs number of significant digits to display
#' @return a ggplot2 object
plotBlandAltman <- function(x, y, gamma = 0.05, alpha = 0.05, sigfigs = 2){
  means <- (x + y)/2
  differences <- (x - y)

  n = length(x)
  mu <- mean(differences)
  SD <- sd(differences)

  CI <- estimateLimitsOfAgreement(mu = mu, SD = SD, gamma = gamma) %>%
    estimateConfidenceIntervals(n = n, alpha = alpha)

  df <- data.frame(mean = means, difference = differences)
  df %>%
    ggplot() +
    aes(x = mean, y = difference) +
    geom_point() +

    # zero
    geom_hline(yintercept = 0,
               lty = 3, col = "black") +

    # mean
    geom_hline(yintercept = c(CI$LOA$mu),
               lty = 1, col = "blue") +
    geom_hline(yintercept = c(CI$CI$mu_lowerCI, CI$CI$mu_upperCI),
               lty = 2, col = "blue") +

    # upper LOA
    geom_hline(yintercept = c(CI$LOA$upperLOA),
               lty = 1, col = "red") +
    geom_hline(yintercept = c(CI$CI$upperLOA_lowerCI, CI$CI$upperLOA_upperCI),
               lty = 2, col = "red") +

    # lower LOA
    geom_hline(yintercept = c(CI$LOA$lowerLOA),
               lty = 1, col = "green3") +
    geom_hline(yintercept = c(CI$CI$lowerLOA_upperCI, CI$CI$lowerLOA_lowerCI),
               lty = 2, col = "green3") +

    scale_y_continuous(breaks = signif(c(CI$LOA$mu, CI$CI$mu_lowerCI, CI$CI$mu_upperCI,
                                  CI$LOA$upperLOA, CI$LOA$lowerLOA,
                                  CI$CI$lowerLOA_upperCI, CI$CI$upperLOA_lowerCI,
                                  CI$CI$lowerLOA_lowerCI, CI$CI$upperLOA_upperCI), sigfigs)) +
    ggtitle("Bland-Altman plot") +
    theme_classic()
}
