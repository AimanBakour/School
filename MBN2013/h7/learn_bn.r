library("bnlearn")
data(learning.test)
# learn the structure
bn.hc <- hc(learning.test) # Hill Climb
# constraint-based learning (equivalence structure)
bn.gs <- gs(learning.test) # Grow-Shrink

compare(current=bn.hc, target=bn.gs, arcs=TRUE )
pdf("graphs.pdf")
par(mfrow = c(1, 2))
plot(bn.gs, main = "Grow-Shrink (constraint-based)", highlight = c("A", "B"))
plot(bn.hc, main = "Hill-Climbing", highlight = c("A", "B"))
dev.off()

# do some blacklisting
bn.AB <- gs(learning.test, blacklist = c("B", "A"))
compare(bn.AB, bn.hc)
pdf("graphs2.pdf")
par(mfrow = c(1, 2))
plot(bn.AB, main = "Grow-Shrink (constraint-based)\nwith blacklisting A and B", highlight = c("A", "B"))
plot(bn.hc, main = "Hill-Climbing", highlight = c("A", "B"))
dev.off()

# compare number of test
ntests(bn.hc)
ntests(bn.gs)

