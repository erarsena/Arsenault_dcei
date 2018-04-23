#' Takes primary producer d15N signature data separated by site and returns a
#dataframe with two columns
#
#Args ' @param dat A data frame with primary consumer (mussel) d15N data at one
#or more sites ***DAN: not clear from this description the structure of the
#dataframe (what columsn?) ' @param frac Trophic discrimination factor (default
#set at 3.4, most commonly accepted) ' ' The output of base_sig is a data frame
#with columns sitename and baseline. ' @return A dataframe of columns sitename
#(Name of site where primary consumer (mussel) was collected) ' @return baseline
#A single number equal to mean primary producer d15N signature at "site" ***DAN:
#good clear description of this output data frame though

#' @examples
#' base_sig(dat = df, 3.4)
#'
#' @seealso \code{\link{tp_calc}}

base_sig <- function(dat, frac = 3.4) {
  sitename <- levels(muss$site)
  base <- vector(mode = "numeric")
  for(i in sitename) {
    base[i] <- mean(muss$d15N[muss$site==i]-frac)
  }
  mussdf <- data.frame(sitename, base)
  colnames(mussdf) <- c("site", "baseline")
  return(mussdf)
}
