# Chris Fenton Week 2 Assignment

## Factorial Function


```r
fenton_factorial <- function(x) {
  factorialized <- 1
  
  if (x == 0) {
    return(1)
  } else if ( x < 0 || round(x) != x)  {
    return("Factorials must be non negative integers")
  }
  
  for (i in 1:x) {
    factorialized <- i * factorialized
  }
  return(factorialized)
}
```
Custom function for calculating factorials.

Notes:
* x must be a non negative integer.
* 0 returns 1.

### Examples

```r
fenton_factorial(5)
```

```
## [1] 120
```

```r
fenton_factorial(10)
```

```
## [1] 3628800
```

```r
fenton_factorial(0)
```

```
## [1] 1
```

```r
fenton_factorial(-3)
```

```
## [1] "Factorials must be non negative integers"
```

```r
fenton_factorial(2.5)
```

```
## [1] "Factorials must be non negative integers"
```
## Choose Function

```r
fenton_choose <- function(n,r) {
  return(fenton_factorial(n) / (fenton_factorial(n - r) * fenton_factorial(r)))
}
```
Uses the fenton_factorial function to build a function that implements the
k-combination formula.

## Examples

```r
fenton_choose(10,3)
```

```
## [1] 120
```

```r
fenton_choose(5,4)
```

```
## [1] 5
```
