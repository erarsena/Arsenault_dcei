#Takes output from tp_calc to calculate the maximum trophic position (food chain length) for each site in dataframe
#
#Args
#fish      A dataframe with d15N data for fish at different sites along a river
#frac      Trophic discrimination factor used to calculate trophic position (default = 3.4)
#
#Output - a dataframe with these columns
#site     Site along river
#species  Fish species (character class)
#id        ID number for individual fish
#maxtp    Trophic position of the fish with the maximum trophic position (FCL)
#

tpdf <- na.omit(tp_calc(fish, 3.4))
fcl_calc <- function(tpdf) {
  site <- levels(tpdf$site)
  fcl <- vector(mode = "numeric")
  for(i in site) {
    fcl[i] <- max(tpdf$tp[tpdf$site==i])
  }
  fcldf <- data.frame(site, fcl)
  colnames(fcldf) <- c("site", "fcl")
  return(fcldf)
}