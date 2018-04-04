#Takes mussel d15N signature data separated by site and returns a dataframe with two columns
#
#Args
#dat      The dataset 
#frac     Trophic discrimination factor used to calculate trophic position (default = 3.4, most commonly accepted)
#
#Output - a data frame with these
#base     A single number equal to mean primary producer signature at sitename

dat <- read.csv("muss.csv", header = T)
base_sig <- function(dat, frac=3.4) {
  frac <- 3.4
  site <- levels(muss$site)
  base <- vector(mode = "numeric")
  for(i in site) {
    base[i] <- mean(muss$d15N[muss$site==i])
  }
  df <- data.frame(site, base)
  colnames(df) <- c("Site", "Baseline")
  return(df)
}