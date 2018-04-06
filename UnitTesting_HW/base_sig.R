#Takes mussel d15N signature data separated by site and returns a dataframe with two columns
#
#Args
#muss     The dataset 
#frac     Trophic discrimination factor used to calculate trophic position (default = 3.4, most commonly accepted)
#
#Output - a data frame with these
#base     A single number equal to mean primary producer signature at sitename

muss <- read.csv("muss.csv", header = T)
base_sig <- function(muss, frac=3.4) {
  site <- levels(muss$site)
  base <- vector(mode = "numeric")
  for(i in site) {
    base[i] <- mean(muss$d15N[muss$site==i])
  }
  mussdf <- data.frame(site, base)
  colnames(mussdf) <- c("Site", "Baseline")
  return(mussdf)
}