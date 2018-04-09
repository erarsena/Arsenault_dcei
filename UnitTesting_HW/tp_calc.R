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
#Note: assumes that ID numbers are not repeated among different sites of the same project


####

#For each value in column A, do this formula to it and put it in a new column (X)
#(could just have one function to populate new column (maybe use levels?) and then do the actual calculation in seperate function!)

####### this one is better, actually gives right answer
mussdf <- base_sig(muss, 3.4)
fish <- read.csv("fish.csv", header = T)
tp_calc <- function(fish, frac=3.4){
  df <- merge(mussdf, fish, by = "site")
  df$tp <- ((((df$d15N-df$baseline))/frac)+1)
  tpdf <- data.frame(df$site, df$d13C, df$d15N, df$species, df$id, df$tp)
  colnames(tpdf) <- c("site", "d13C", "d15N", "species", "id", "tp")
  return(tpdf)
}