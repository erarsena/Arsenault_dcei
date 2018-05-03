#Generates table with six Layman's metric calculations
#
#Args
#
##lay (a dataframe with these columns):
  #"site"
  #"d13C"
  #"d15N"
##group
#
##Output (a dataframe with these rows, columns designated by argument 'group'):
  #"dY_range"
  #"dX_range"
  #"TA"
  #"CD"
  #"NND"
  #"SDNDD"
#
require("SIBER")
tpdf <- tp_calc(fish, 3.4)
layman_calc <- function(lay, group) {
  lay <- vector(mode = "numeric")
  for(i in levels(group)) {
  lay[i] <- SIBER::laymanMetrics(fish$d13C[group==i], fish$d15N[group==i])
  }
  return(as.data.frame(lay))
}
