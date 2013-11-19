source('ch06-gillespied.r')

anlystoch <- function(N, T, dt, i)
{
	P<-array(dim = c(T/dt, 3))
	p<-array(dim = c(T/dt, i))
	for (j in 1:i)
	{
		gillespied(N, T, dt)-> o
		p[,j] = o[,1]
	}
	plot.ts(ts(p,start=0,deltat = dt), plot.type = c("single"), ylab = "No. of Molecules")
	
	P[,1] = rowMeans(p)
	P[,2] = rowMeans(p) + (sd(t(p))*3)
	P[,3] = rowMeans(p) - (sd(t(p))*3)
	
	#x11()
	#windows()
	quartz()
	plot.ts(ts(P,start=0,deltat = dt), plot.type = c("single"), lty = c(1,2,2), ylab = "No. of Molecules")
	legend("topright", c("Sample mean", "Mean plus/minus 3 SDs"), lty = c(1,2))
	
	#x11()
	#windows()
	quartz()
	hist(p[10,], probability = "TRUE", xlab = "Number of Molecules", main = "")
	
	PP = list()
	PP$P = P
	PP$p = p
	return(PP)
}
anlystoch(N,T=20,dt=0.5, 1000)