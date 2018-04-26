#' base_sig
#'
#' Takes primary producer d15N signature data separated by site and returns a dataframe with two columns
#
#' @param dat A data frame with primary consumer (mussel) d15N data
#' @param frac Trophic fractionation factor, default set at 3.4
#'
#' @return A dataframe of columns sitename and baseline

base_sig <- function(dat, frac = 3.4) {
  sitename <- levels(dat$site)
  base <- vector(mode = "numeric")
  for(i in sitename) {
    base[i] <- mean(dat$d15N[muss$site==i]-frac)
  }
  mussdf <- data.frame(sitename, base)
  colnames(mussdf) <- c("site", "baseline")
  return(mussdf)
}
