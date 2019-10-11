# blandPower
Tools for estimation of power and sample size in Bland-Altman analysis

## Introduction

Whenever a new measurement technique is developed, it must be compared to an established technique in order to assess agreement, repeatability, or replicability. The most popular way to assess agreement in biomedical applications is the [Bland-Altman method](https://www.ncbi.nlm.nih.gov/pubmed/2868172), which was first proposed in response to widespread misuse of methods like comparison of means, correlation, and ordinary least-squares regression. What is desired most in a good comparison method is a simple way to quantify agreement when both measurements have error, and a simple way to identify constant and non-constant bias over the range of measurements. Bland-Altman analysis offers an intuitive approach to both these goals.

The Bland-Altman method is based on what is known in other fields as the Tukey mean-difference, RA or MA plot -- the x-axis shows the average of the two measurements, and the y-axis shows the difference between them. Upper and lower limits of agreement (LOA) are defined by quantiles of the differences between measurements, generally such that they contain 95% of the differences. A null hypothesis of disagreement is rejected if the 95% confidence intervals of these quantiles lie within predefined clinical agreement limits. A null hypothesis of unbiasedness is rejected if the 95% confidence interval of the mean difference does not include zero.

While this method is seemingly straightforward, there is a dearth of literature discussing the statistical power of this test, and thus little guidance on how to estimate sample size outside of Monte Carlo simulation. An exact solution is not known. Guidance provided by Martin Bland on his [webpage](https://www-users.york.ac.uk/~mb55/meas/sizemeth.htm) suggests the sample size can be determined by the expected width of the confidence interval, but this fails to explicitly consider the Type-II error, and will recommend sample sizes that are too small. Most recently, [Lu et al. (2016)](https://www.degruyter.com/view/j/ijb.2016.12.issue-2/ijb-2015-0039/ijb-2015-0039.xml) proposed a method that tries to account for the Type-II error, which performs reasonably well for typical sample size calculations at 80% power. However, their publication did not include corresponding code. 

As a result, it is a challenge to estimate the sample size required to adequately power a method comparison experiment without having to write the code from scratch. In their origninal statistical manuscript, Altman and Bland identified many reasons for the perpetuation of inappropriate methods mentioned above, and argued that "more statisticians should be aware of this problem, and should use their influence to similarly increase the awareness of their non-statistical colleagues of the fallacies behind many common methods." They suggested that the biggest reason for bad methodology was that "the majority of medical method comparison studies are carried out without the benefit of professional statistical expertise...the non-statistician will search in vain for a description of how to proceed with studies of this nature...as a consequence, textbooks are scanned for the most similar-looking problem, which is undoubtedly correlation." In the present time, perhaps the biggest reason is the lack of free software that fully supports the Bland-Altman method, particularly the ability to design adequately powered experiments. We are aware of only two statistical software packages that implement corresponding power and sample size estimators -- [MedCalc](https://www.medcalc.org/) and [PASS](https://www.ncss.com/software/pass/), which are neither open-source nor free. The `blandPower` package presented in this article is meant to provide open-source access to the method of Lu et al. in the R language, so that it can be more widely used, discussed, and improved.


## Installation
This package can be installed from GitHub using the `devtools` package.

```
library(devtools)
install_github("nwisn/blandPower")
library(blandPower)
```

## Help
Help files can be found by typing `?<functionname>`, or `??blandPower`.


## Usage

### Power and sample size
We estimate the power curve by evaluating the power at many different sample sizes. This is done by `estimatePowerCurve`, which produces an object that several other functions in this package are defined to process.

```
powerCurve <- estimatePowerCurve(nMin = 10, 
                                 nMax = 200, 
                                 stepsize = 1, 
                                 mu = 0, 
                                 SD = 3.3, 
                                 delta = 8)
```

We estimate sample size by finding the nearest point on the power curve to a pre-specified power.

```
estimateSampleSizeFromPowerCurve(powerCurve, power = 0.8)
```

We estimate power by finding the nearest point on the power curve to a pre-specified sample size.

```
estimatePowerFromPowerCurve(powerCurve, n = 100)
```

We plot the power curve, and alternatively a plot of the limits of agreement and how their confidence intervals change with increasing sample size. All plots produced by this package use `ggplot2`.

```
plotPowerCurve(powerCurve)
plotConfidenceIntervalCurve(powerCurve)
```


### Bland-Altman plot
Finally, with two vectors of measurement data (here mocked by `rnorm`), we can produce the standard Bland-Altman plot.

```
plotBlandAltman(rnorm(100), rnorm(100))
```
