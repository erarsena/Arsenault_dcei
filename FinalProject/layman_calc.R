#Generates table with six Layman's metric calculations
#
##Args
#
#tpdf (a dataframe with these columns):
  #"site"
  #"d13C"
  #"d15N"
##Output (a dataframe with these rows, columns designated by argument 'group'):
  #"dY_range"
  #"dX_range"
  #"TA"
  #"CD"
  #"NND"
  #"SDNDD"
#
layman_calc <- function(dat) {
  require("SIBER")
  lay <- vector(mode = "numeric")
  for(i in levels(dat$site)) {
  lay[i] <- SIBER::laymanMetrics(dat$d13C[dat$site==i], dat$d15N[dat$site==i])
  }
  return(as.data.frame(lay))
}
