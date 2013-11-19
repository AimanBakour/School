N=list()
N$M=c(301,0)
N$Pre=matrix(c(2,0,0,1),ncol=2,byrow=TRUE)
N$Post=matrix(c(0,1,2,0),ncol=2,byrow=TRUE)
N$h=function(x,th=c(1.66e-3,runif(1,0.1,0.4))) {
        return( c( th[1]*x[1]*(x[1]-1)/2 ,
                th[2]*x[2] ) )
        }

