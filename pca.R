source("common.R")

exclude <- c("leaf_deltaN15",
             "leaf_fiber_percent")
fit <- princomp(dat.mat[,c("N.mu", "Cab.mu", "Car.mu",
                           "Cw.mu", "Cm.mu")], 
                cor=TRUE, na.action=na.omit)
