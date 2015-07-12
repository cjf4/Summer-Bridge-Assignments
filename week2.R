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

fenton_choose <- function(n,r) {
  return(fenton_factorial(n) / (fenton_factorial(n - r) * fenton_factorial(r)))
}