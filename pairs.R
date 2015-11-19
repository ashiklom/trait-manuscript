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
common.cols <- intersect(colnames(angers.dat), colnames(lopex.dat), colnames(fft.dat))
setkeyv(angers.dat, common.cols)
setkeyv(lopex.dat, common.cols)
setkeyv(fft.dat, common.cols)
both.dat <- merge(angers.dat, lopex.davg, all=T)

# Merge with results data frame
setkey(results, sample_id)
setkey(both.dat, sample_id)
dat <- results[both.dat]

# Some results plots
png("figures/both.validation.png", width=6, height=6, units="in", res=200)
par(mfrow=c(2,2), pch=20, mar=c(2,2,2,1), oma=c(4,4,1,0))
with(dat,{
    plot(Cab.mu, C_ab, xlab='', ylab='')
    title(main=expression(paste("Total chlorophyll (", mu, "g ", cm^-2, ")")))
    abline(0,1)
    plot(Car.mu, C_car, xlab='', ylab='')#, xlim=c(0, 60))
    title(main=expression(paste("Total carotenoids (", mu, "g ", cm^-2, ")")))
    abline(0,1)
    plot(Cw.mu*10000, EWT*10000, xlab='', ylab='')
    title(main=expression(paste("Leaf water content (g ",m^-2,")")))
    abline(0,1)
    plot(Cm.mu*10000, LMA*10000, xlab='', ylab='', ylim=c(0,200))
    title(main=expression(paste("LMA (g ", m^-2, ")")))
    abline(0,1)
    mtext("Spectral inversion estimate", 1, 1, cex=1.2, outer=TRUE)
    mtext("Direct measurement", 2, 1, cex=1.2, outer=TRUE)
    #title(xlab="Inversion estimate", ylab="Measurement", outer=TRUE, cex=4, line=1)
})
dev.off()

##### I DIDN'T ALTER THE FIGURES BELOW. THEY ARE FOR LOPEX ONLY #####
