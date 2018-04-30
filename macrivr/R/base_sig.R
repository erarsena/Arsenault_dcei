#' base_sig
#'
#' Takes primary producer d15N signature data separated by site and returns a dataframe with two columns
#
#' @param muss A data frame with primary consumer (mussel) d15N data
#' @param frac Trophic fractionation factor, default set at 3.4
#'
#' @return A dataframe of columns sitename and baseline

mussurl <- "https://raw.githubusercontent.com/erarsena/Arsenault_dcei/master/UnitTesting_HW/muss.csv"
muss <- RCurl::getURL(mussurl)
muss <- na.omit(read.csv(textConnection(muss)))

base_sig <- function(muss, frac = 3.4) {
  sitename <- levels(muss$site)
  base <- vector(mode = "numeric")
  for(i in sitename) {
    base[i] <- mean(muss$d15N[muss$site==i]-frac)
  }
  mussdf <- data.frame(sitename, base)
  colnames(mussdf) <- c("site", "baseline")
  return(mussdf)
}
