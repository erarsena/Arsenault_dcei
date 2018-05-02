#Generates table with several Layman's metric calculations
#
#Args
#
##lay (a dataframe with these columns):
  #"site"
  #"d13C"
  #"d15N"
##group
#
##Output (a dataframe with these columns):
#
#
#
tpdf <- tp_calc(fish, 3.4)
layman_calc <- function(lay, group) {
  site <- tpdf$site
  rangeN <- vector(mode = "numeric")
  rangeC <- vector(mode = "numeric")
  for(i in site) {
    rangeN[i] <- (max(lay$d15N[lay$site==i])-min(lay$d15N[lay$site==i]))
    rangeC[i] <- (max(lay$d13C[lay$site==i])-min(lay$d13C[lay$site==i]))
  }
  laydf <- data.frame(rangeN, rangeC)
  colnames(laydf) <- c("rangeN", "rangeC")
  return(laydf)
}