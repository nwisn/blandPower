# blandaltman
Tools for Bland-Altman analysis

## Introduction
The [Bland-Altman method (1982)](https://www.ncbi.nlm.nih.gov/pubmed/2868172) of assessing agreement between two measurement techniques was proposed to replace the correlation coefficient with a more appropriate and interpretable method. The method consists of using a mean-difference plot to inspect agreement, computing 95% limits of agreement from the standard deviation of measurement differences, and computing 95% confidence intervals of the mean and limits of agreement. Agreement is statistically significant if both the 95% confidence intervals lie within some pre-determined clinical limits. This package uses the method of [Lu et al. (2016)](https://www.degruyter.com/view/j/ijb.2016.12.issue-2/ijb-2015-0039/ijb-2015-0039.xml) to compute power curves and estimate sample size.

## Install
This package can be installed from GitHub using the `devtools` package.

```
library(devtools)
install_github("nwisn/blandaltman")
```

## Help
Help files can be found by typing `?<functionname>`, or `??blandaltman`.


## Usage

### Power and sample size
We estimate the power curve by evaluating the power at many different sample sizes. This is done by `estimatePowerCurve`, which produces an object that several other functions in this package are defined to process.

```
powerCurve <- estimatePowerCurve(nMin = 10, 
                                 nMax = 200, 
                                 stepsize = 1, 
                                 mu = 0, 
                                 SD = 3.3, 
                                 delta = 8,
                                 gamma = 0.05,
                                 alpha = 0.05,
                                 approx = "t",
                                 method = "Lu")
```

We estimate sample size by finding the nearest point on the power curve to a pre-specified power.

```
estimateSampleSize(powerCurve, power = 0.8)
```

We can plot the power curve, and alternatively a plot of the limits of agreement and how their confidence intervals change with increasing sample size. All plots produced by this package use `ggplot2`.

```
plotPowerCurve(powerCurve)
plotConfidenceIntervalCurve(powerCurve)
```


### Bland-Altman plot
With two vectors of measurement data (here mocked by `rnorm`), we can produce the standard Bland-Altman plot.

```
plotBlandAltman(rnorm(100), rnorm(100))
```
