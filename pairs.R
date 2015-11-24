source("common.R")

pairscols <- c("leaf_nlayers", "leaf_chlorophyll_a", "leaf_chlorophyll_b",
               "leaf_chlorophyll_total", "leaf_carotenoid_total",
               "leaf_water_content", "LMA", "leafC", "leafO", "leafH", "leafN",
               "c2n_leaf", "leaf_protein_percent", "leaf_cellulose_percent",
               "leaf_lignin_percent", "leaf_starch_percent", "leaf_fiber_percent",
               "leaf_deltaN15", "N.mu", "Cab.mu", "Car.mu", "Cw.mu", "Cm.mu")

library(combinat)

colpairs <- combn(pairscols, 2)
pdf("allpairs.pdf")
for(i in 1:ncol(colpairs)){
    print(colpairs[,i])
    x <- dat[[colpairs[1,i]]]
    y <- dat[[colpairs[2,i]]]
    plot(x, y, xlab=colpairs[1,i], ylab=colpairs[2,i])
    corr <- try(round(cor(y,x), 4))
    title(main = corr)
}
dev.off()

#upper.panel <- function(x,y){
    #try({
        #fit <- lm(y~x)
        #intercept <- fit$coefficients[1]
        #slope <- fit$coefficients[2]
        #r2 <- summary(fit)$r.squared
        #corr <- cor(y,x)
        #string <- sprintf("b = %.3f \n m = $.3f \n r2 = %.3f \n corr=%.3f",
                        #intercept, slope, r2, corr)
        #midx <- 0.5*(min(x) + max(x))
        #midy <- 0.5*(min(y) + max(y))
        #text(midx, midy, string)
        #return()
    #})
    #text("")
#}

#dat.sub <- dat[, pairscols, with=F]
#png("bigpairs.png", height=20, width=20, units="in", res=200)
#pairs(dat.sub, upper.panel = upper.panel)
##pairs(dat.sub)
#dev.off()
