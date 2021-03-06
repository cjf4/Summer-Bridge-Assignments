## Chris Fenton Week 4 R Assignment

Here, I'm looking at Alabama unemployment from 1970 through 1986.

The source data can be downloaded [here](http://vincentarelbundock.github.io/Rdatasets/csv/plm/Produc.csv)

```r
produc <- read.csv("produc.csv")

bama <- subset(produc, state=='ALABAMA')
hist(bama$unemp)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png) 

```r
plot(bama$year, bama$unemp)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-2.png) 

```r
boxplot(bama$unemp)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-3.png) 

The most dramatic thing I learned is how consistently and high unemployment rose, even past the stagflation era into the 70s. Indicates that Alabama's economy had problems that went beyond the macro US climate at the time.
