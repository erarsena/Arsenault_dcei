#Takes primary producer d15N signature data separated by site and returns a dataframe with two columns
#
##Args
#
#muss (a data frame with these columns):
    #"site"     Name of site where primary consumer (mussel) was collected
    #"d15N"     Primary producer d15N signatures for each individual (row) categorized by "site"
#frac  Trophic discrimination factor (default = 3.4)
#
##Output (a data frame with these columns):
  #"site"       Name of site where primary consumer (mussel) was collected (factor)
  #"baseline"   A single number equal to mean primary producer d15N signature at "site" (numeric)
#
base_sig <- function(muss, frac = 3.4) {
  site <- muss$site
  d15N <- muss$d15N
  sitename <- levels(site)
  base <- vector(mode = "numeric")
  for(i in sitename) {
    base[i] <- mean(d15N[site==i]-frac)
  }
  mussdf <- data.frame(sitename, base)
  colnames(mussdf) <- c("site", "baseline")
  return(mussdf)
}
