#Generates a plot in isotopic space for each study site
#
#Args
##dat (a dataframe with these columns):
  #"d13C"   d13C isotope signature data (numeric)
  #"d15N"   d15N isotope signature data (numeric)
#
##Output
  #cnplot   Plot in isotopic space (x = d13C, y = d15N)
#
#Note: Assumes a dataset with four sites - adjust variable "cscheme" to customize
#
tpdf <- tp_calc(fish, 3.4)
cscheme <- c("red", "blue", "green", "black")
plot_web <- function(dat) {
  cnplot <- plot(x = tpdf$d13C, y = tpdf$d15N, pch = 16,
                 col = cscheme[as.numeric(tpdf$site)],
                 xlab = expression(paste(delta, ""^"13", "C")), ylab = expression(paste(delta, ""^"15", "N")))
  return(cnplot)
}
