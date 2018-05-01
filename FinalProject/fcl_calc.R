#Takes output from tp_calc to calculate the maximum trophic position (food chain length) for each site in dataframe
#
#Args
#
##dat (a dataframe with these columns):
  #"site"     Name of site where primary consumer (mussel) was collected (factor)
  #"d15N"     d15N isotope signature data (numeric)
#
##Output - a dataframe with these columns
  #"site"     Site along river (factor)
  #"fcl"      Trophic position of the fish with the maximum trophic position (FCL) (numeric)
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
