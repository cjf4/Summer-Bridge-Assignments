# 1.

a <- matrix(data=c(1,2,-1,2,1,1,-3,-3,0), nrow=3, ncol=3)
b <- matrix(data=c(5,13,-8), byrow=FALSE)

solve(a,b)

#Results in:
#Error in solve.default(a, b) : 
#  Lapack routine dgesv: system is exactly singular: U[3,3] = 0

#This means there are infinitely many solutions
 
# 2. 
a <- matrix(data=c(4,-3,0,-3,5,1), nrow=3, ncol=2)
b <- matrix(data=c(1,3,4,-2), nrow=2, ncol=2)

#Error in a * b : non-conformable arrays
#rows of matrix a != cols of matrix b