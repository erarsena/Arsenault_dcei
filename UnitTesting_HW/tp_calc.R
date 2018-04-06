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

#For each value in column A, do this formula to it and put it in a new column (X)
#(could just have one function to populate new column (maybe use levels?) and then do the actual calculation in seperate function!)

#I think this one actually worked
mussdf <- base_sig(muss, 3.4)
fish <- na.omit(read.csv("fish.csv", header = T))
tp_calc <- function(fish, frac=3.4){
  for(i in 1:length(fish$site)) {
    if(fish$site[i] %in% mussdf$Site) {
      fish$tp[i] <- ((((fish$d15N-mussdf$Baseline)[i])/frac)+1)
    }
  }
  tpdf <- data.frame(fish$site, fish$d15N, fish$species, fish$id, fish$tp)
  colnames(tpdf) <- c("Site", "d15N", "Species", "ID", "Trophic Position")
  return(tpdf)
}

#testing modifications
#for each row in fish$d15N, subtract the value corresponding to the site code

for(i in fish$d15N) {
  fish$test[i] <- fish$d15N-mussdf$Baseline
}

mussdf <- base_sig(muss, 3.4)
fish <- na.omit(read.csv("fish.csv", header = T))
tp_calc <- function(fish, frac=3.4){
  for(i in fish$site) {
    if(fish$site[i] %in% mussdf$Site) {
      fish$tp[i] <- ((((fish$d15N-mussdf$Baseline)[i])/frac)+1)
    }
  }
  tpdf <- data.frame(fish$site, fish$d15N, fish$species, fish$id, fish$tp)
  colnames(tpdf) <- c("Site", "d15N", "Species", "ID", "Trophic Position")
  return(tpdf)
}

testfish <- merge(mussdf, fish, by = "site") #just do the merge and instead of using %in%
