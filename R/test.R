results <- estimateLimitsOfAgreement(mu = 0, SD = 1, gamma = 0.05) %>%
  estimateConfidenceIntervals(n = 100, alpha = 0.05) %>%
  estimateTypeIIerror(delta = 2, approx = "t") %>%
  estimatePower(method = "Lu")

powerCurve <- estimatePowerCurve(nMin = 10, nMax = 200, stepsize = 1, mu = 0, SD = 3.3, delta = 8)
powerCurve %>% estimateSampleSize(power = 0.8)
powerCurve %>% plotPowerCurve() +
  ggplot2::geom_vline(xintercept = powerCurve %>% estimateSampleSize(power = 0.8), lty = 3)
powerCurve %>% plotConfidenceIntervalCurve() +
  ggplot2::geom_vline(xintercept = powerCurve %>% estimateSampleSize(power = 0.8), lty = 3)


