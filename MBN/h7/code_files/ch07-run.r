# example
#
N=list()
N$M=c(50,100)
N$Pre=matrix(c(1,0,1,1,0,1),ncol=2,byrow=TRUE)
N$Post=matrix(c(2,0,0,2,0,0),ncol=2,byrow=TRUE)
N$h=function(x,th=c(1,0.005,0.6))
{
 return(c(th[1]*x[1], th[2]*x[1]*x[2], th[3]*x[2] ))
}

plot(gillespied(N,T=100,dt=0.01))

