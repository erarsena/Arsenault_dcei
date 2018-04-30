##Generates a plot in isotopic space for each study site
#
#Args
#dat      A dataframe with d13C and d15N data for fish at different sites along a river
#
#Output
#cnplot     Plot in isotopic space (x = d13C, y = d15N)
#
#Note: assumes a dataset with four sites

tpdf <- tp_calc(fish, 3.4)
plot_web <- function(dat) {
  cnplot <- plot(x = tpdf$d13C, y = tpdf$d15N, pch = 16,
                 col = c("red", "blue", "green", "black")[as.numeric(tpdf$site)],
                 xlab = expression(paste(delta, ""^"13", "C")), ylab = expression(paste(delta, ""^"15", "N")))
  return(cnplot)
}
