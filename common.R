# 01-common.R

#' Common script for trait paper analysis

#' Load packages and data
library(data.table)
load("processed-spec-data/all.results.RData")
load("processed-spec-data/lopex.RData")
load("processed-spec-data/angers.RData")
load("processed-spec-data/fft.RData")

# Average LOPEX chemistry data
mean.chr <- function(x){
    if(is.numeric(x)) return(mean(x, na.rm=TRUE))
    return(x[1])
}
lopex.dat <- lopex.dat[,lapply(.SD, mean.chr), by=sample_id]

# Merge Lopex and Angers chemistry data
common.cols <- intersect(colnames(angers.dat), colnames(lopex.dat))
setkeyv(angers.dat, common.cols)
setkeyv(lopex.dat, common.cols)
both.dat <- merge(angers.dat, lopex.dat, all=T)

common.cols <- intersect(colnames(both.dat), colnames(fft.dat))
setkeyv(both.dat, common.cols)
setkeyv(fft.dat, common.cols)
both.dat <- merge(both.dat, fft.dat, all=T)

# Merge with results data frame
setkey(results, sample_id)
setkey(both.dat, sample_id)
dat <- results[both.dat]


