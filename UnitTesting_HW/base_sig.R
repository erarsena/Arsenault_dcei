#Takes primary producer d15N signature data separated by site and returns a dataframe with two columns
#
#Args
#dat        A data frame with primary consumer (mussel) d15N data at one or more sites
#frac       Trophic discrimination factor (default set at 3.4, most commonly accepted)
#
#Output - a data frame with these columns:
#sitename   Name of site where primary consumer (mussel) was collected
#baseline   A single number equal to mean primary producer d15N signature at "site"

muss <- read.csv("muss.csv", header = T)
base_sig <- function(dat = muss, frac = 3.4) {
  sitename <- levels(muss$site)
  base <- vector(mode = "numeric")
  for(i in sitename) {
    base[i] <- mean(muss$d15N[muss$site==i]-frac)
  }
  mussdf <- data.frame(sitename, base)
  colnames(mussdf) <- c("site", "baseline")
  return(mussdf)
}