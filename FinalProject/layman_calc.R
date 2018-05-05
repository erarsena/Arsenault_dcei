#Generates list with six Layman's metric calculations separated by site
#
##Args
#
#dat (a dataframe with these columns):
  #"site"       Name of site where consumer (fish) was collected
  #"d13C"       Consumer d13C signature data
  #"d15N"       Consumer d15N signature data
##Output (a list with these metrics, listed by argument 'site'):
  #"dY_range"   range of all d15N values (max-min)
  #"dX_range"   range of all d13C values (max-min)
  #"TA"         total area of the convex hull
  #"CD"         mean distance to centroid
  #"NND"        mean nearest neighbor distance
  #"SDNDD"      standard deviation of the nearest neighbor distance
#
layman_calc <- function(dat) {
  require("SIBER")
  lay <- vector(mode = "numeric")
  for(i in levels(dat$site)) {
  lay[i] <- list(SIBER::laymanMetrics(dat$d13C[dat$site==i], dat$d15N[dat$site==i]))
  }
  return(lay)
}