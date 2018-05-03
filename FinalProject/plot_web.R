#Generates a plot in isotopic space for each study site
#
#Args
##dat (a dataframe with these columns):
  #"d13C"   d13C isotope signature data (numeric)
  #"d15N"   d15N isotope signature data (numeric)
  #"site"  factor to groupp d13C and d15N observations (e.g., sites or species)
#
##Output
  #cnplot   Plot in isotopic space (x = d13C, y = d15N)
#
#Note: Assumes a dataset with four sites - adjust variable "cscheme" to customize
#
plot_web <- function(dat) {

  cnplot <- plot(x = dat$d13C, y = dat$d15N, pch = 16,
                 col = getColours(4)[as.numeric(dat$site)],
                 xlab = expression(paste(delta, ""^"13", "C")), ylab = expression(paste(delta, ""^"15", "N")))
  legend(x = "bottomright", legend = as.character(unique(dat$site)), 
         col=getColours(4)[as.numeric(unique(dat$site))], pch=16)
  return(cnplot)
}
