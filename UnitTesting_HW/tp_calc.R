#Takes output from base_sig to calculate the trophic position for each fish (row) in dataframe
#
#Args
#fish      A dataframe with d15N data for fish at different sites along a river
#frac      Trophic discrimination factor used to calculate trophic position (default = 3.4)
#base_sig(i)
#
#Output -  A dataframe with these columns
#site      Site along river
#megahabitat
#species   Fish species (character class)
#id        ID number for individual fish
#tp        Trophic position
#
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

####

#this one is for each fish individual, the next one averages that out for each site
fish <- read.csv("fish.csv", header = T)
baseline <- base_sig(muss, 3.4)
tp_calc <- function(fish, frac=3.4, baseline) {
  tp <- vector(mode = "numeric")
  fishy <- fish$id
  megahabitat <- fish$____
  for(i in fishy) {
  tp[i] <- (((fishy-baseline)/3.4)+1)
}
  tpdf <- data.frame(site, megahabitat, species, id, tp)
  colnames(tpdf) <- c("Site", "Megahabitat", "Species", "ID", "Trophic Position")
  return(tpdf)
}


#For each value in column A, do this formula to it and put it in a new column (X)

trophic <- na.omit(fish$d15N)
tp <- vector()
for(i in trophic) {
  tp <- (i/3.4)+1
  tp <- m
}
#TP = ((fish d15N-mean pp sig)/frac)+1