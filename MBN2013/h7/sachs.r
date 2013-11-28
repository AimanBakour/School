# analyzing the Sachs data with bnlearn.
library(bnlearn)

sachs = read.table("sachs.data.txt", header = TRUE)
dsachs = discretize(sachs, method = "hartemink", breaks = 3, ibreaks = 60)

for (i in names(dsachs))
    levels(dsachs[, i]) = c("LOW", "AVG", "HIGH")

# bootstrapping
boot = boot.strength(data = dsachs, R = 500, algorithm = "hc",
         algorithm.args = list(score = "bde", iss = 10))
boot[(boot$strength > 0.85) & (boot$direction >= 0.5), ]
avg.boot = averaged.network(boot, threshold = 0.85)

# create random graph
nodes = names(dsachs)
start = random.graph(nodes = nodes, method = "melancon", num = 500)
# hill-climbing
netlist = lapply(start, function(net) {
  hc(dsachs, score = "bde", iss = 10, start = net) })
rnd = custom.strength(netlist, nodes = nodes)
rnd[(rnd$strength > 0.85) & (rnd$direction >= 0.5), ]
avg.start = averaged.network(rnd, threshold = 0.85)

all.equal(cpdag(avg.boot), cpdag(avg.start))
all.equal(moral(avg.boot), moral(avg.start))
score(avg.boot, dsachs, type = "bde", iss = 10)

issues <- undirected.arcs(avg.start)
avg.start <- set.arc(avg.start, issues[1,1], issues[1,2])


score(avg.start, dsachs, type = "bde", iss = 10)

all.equal(avg.start,avg.boot)


# estimated threshold.
all.equal(avg.boot, averaged.network(boot, threshold = 0.60))
all.equal(avg.start, averaged.network(rnd, threshold = 0.60))

averaged.network(boot)

par(mfrow=c(1,2))
pdf("networks.pdf")
plot(avg.boot)
plot(avg.start)
dev.off()

pdf("boot.pdf")
plot(avg.boot,  main = "Bootstrapped average network", highlight = c("PIP2", "PIP3"))
dev.off()

pdf("start.pdf")
plot(avg.start,  main = "Hill-climbed average network", highlight = c("PIP2", "PIP3"))
dev.off()