#Takes output from tp_calc to calculate the maximum trophic position (food chain length) for each site in dataframe
#
#Args
#dat      A dataframe with d15N data for fish at different sites along a river
#***DAN: again not so clear the precise structure of this df
#Output - a dataframe with these columns
#site     Site along river
#fcl      Trophic position of the fish with the maximum trophic position (FCL)
#
tpdf <- na.omit(tp_calc(dat = fish, frac = 3.4))
fcl_calc <- function(dat) {
  site <- levels(tpdf$site)
  fcl <- vector(mode = "numeric")
  for(i in site) {
    fcl[i] <- max(tpdf$tp[tpdf$site==i])
  }
  fcldf <- data.frame(site, fcl)
  colnames(fcldf) <- c("site", "fcl")
  return(fcldf)
}

fcldf <- fcl_calc(tpdf)