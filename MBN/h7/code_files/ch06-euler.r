euler<-function (t=50, dt=0.001, fun=f, ic=c(1,1), ...)
{
        p=length(ic)
        n=t/dt
        xmat=matrix(0,ncol=p,nrow=n)
        x=ic
        xmat[1,]=x
        for (i in 2:n) {
                x = x + fun(x,...) * dt
                xmat[i,]=x
        }
        ts(xmat,start=0,deltat=dt)
}