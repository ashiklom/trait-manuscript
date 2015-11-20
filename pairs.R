source("common.R")

pairscols <- c("leaf_nlayers", "leaf_chlorophyll_a", "leaf_chlorophyll_b",
               "leaf_chlorophyll_total", "leaf_carotenoid_total", "leaf_anthocyanin_total",
               "leaf_water_content", "LMA", "leafC", "leafO", "leafH", "leafN",
               "c2n_leaf", "leaf_protein_percent", "leaf_cellulose_percent",
               "leaf_lignin_percent", "leaf_starch_percent", "leaf_fiber_percent",
               "leaf_deltaN15")

upper.panel <- function(x,y){
    fit <- lm(y~x)
    intercept <- fit$coefficients[1]
    slope <- fit$coefficients[2]
    r2 <- summary(fit)$r.squared
    corr <- cor(y,x)
    string <- sprintf("b = %.3f \n m = $.3f \n r2 = %.3f \n corr=%.3f",
                      intercept, slope, r2, corr)
    midx <- 0.5*(min(x) + max(x))
    midy <- 0.5*(min(y) + max(y))
    text(midx, midy, string)
}

dat.sub <- dat[, pairscols, with=F]
pairs(dat.sub, upper.panel = upper.panel)
