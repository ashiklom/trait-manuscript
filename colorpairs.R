source("common.R")
library(ggplot2)
library(reshape2)

cordat <- as.matrix(dat[,value.cols, with=F])
cormat <- cor(cordat, use="pairwise.complete.obs")
cordt <- melt(cormat)

plt <- ggplot(cordt) + aes(x=Var2, y=Var1, fill=value) + geom_tile() +
    scale_fill_gradient2(high="green", low="red") + 
    scale_y_discrete(limits=rev(pairscols)) +
    theme(axis.text.x = element_text(angle=90))
plot(plt)
