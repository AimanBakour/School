
# function

gillespied=function (N, T=100, dt=1, ...)
{
        tt=0
	n=T%/%dt
        x=N$M
        S=t(N$Post-N$Pre)
        u=nrow(S)
        v=ncol(S)
        xmat=matrix(0,ncol=u,nrow=n)
	i=1
	target=0
	repeat {
                h=N$h(x, ...)
		h0=sum(h)
		if (h0<1e-10)
			tt=1e99
		else
	                tt=tt+rexp(1,h0)
		while (tt>=target) {
			xmat[i,]=x
			i=i+1
			target=target+dt
			if (i>n)
			        return(ts(xmat,start=0,deltat=dt))
		}
                j=sample(v,1,prob=h)
                x=x+S[,j]
        }
}


# example
#
#N=list()
#N$M=c(50,100)
#N$Pre=matrix(c(1,0,1,1,0,1),ncol=2,byrow=TRUE)
#N$Post=matrix(c(2,0,0,2,0,0),ncol=2,byrow=TRUE)
#N$h=function(x,th=c(1,0.005,0.6))
#{
# return(c(th[1]*x[1], th[2]*x[1]*x[2], th[3]*x[2] ))
#}
#
#plot(gillespied(N,T=100,dt=0.01))
#
# eof

