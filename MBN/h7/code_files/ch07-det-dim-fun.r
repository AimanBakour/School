#Function definition for protein dimerization used as an input in a first order Euler method.
source('ch06-euler.r')
dim <- function(x,k1=5e5,k2=0.2)
{
	c(2*k2*x[2]-2*k1*x[1]*x[1], k1*x[1]*x[1]-k2*x[2])
}

plot(euler(t=10,fun=dim,ic=c(5e-7,0)))