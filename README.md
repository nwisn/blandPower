# blandaltman
Tools for Bland-Altman analysis

## Introduction
The [Bland-Altman method (1982)](https://www.ncbi.nlm.nih.gov/pubmed/2868172) of assessing agreement between two measurement techniques was proposed to replace the correlation coefficient with a more appropriate and interpretable method. The method consists of using a mean-difference plot to inspect agreement, computing 95% limits of agreement from the standard deviation of measurement differences, and computing 95% confidence intervals of the mean and limits of agreement. Agreement is statistically significant if both the 95% confidence intervals lie within some pre-determined clinical limits.

## Power curves and sample size estimation
This package uses the method of [Lu et al. (2016)](https://www.degruyter.com/view/j/ijb.2016.12.issue-2/ijb-2015-0039/ijb-2015-0039.xml) to compute power curves and estimate sample size.

