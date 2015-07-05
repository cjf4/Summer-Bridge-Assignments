# 1. Write a loop that calculates 12-factorial

twelve <- 1:12
x <- 1

for(i in twelve){
    x <- x * i
  }

print(x)

# 2. Show how to create a numeric vector that contains the sequence 20-50 by 5:

nvect <- seq(20,50,5)

# 3. Show how to take a trio of input numbers a, b, and c and implement the
#     quadratic equation:

quadratic_e <- function(a, b, c){
  root_of_d <- sqrt((b^2 - 4 * a * c))
  root_1 <- (-1 * b + root_of_d)/2*a
  root_2 <- (-1 * b - root_of_d)/2*a
  return(c(root_1,root_2))
}

