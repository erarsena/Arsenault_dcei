#Takes output from base_sig to calculate the trophic position for each fish (row) in dataframe
#
##Args
#
#mussdf   dataframe output from 
#fish (a dataframe with these columns):
  #"site"       Name of site where consumer (fish) was collected
  #"d15N"       Consumer d15N signatures for each individual (row) categorized by "site"
#frac      Trophic discrimination factor used to calculate trophic position (default = 3.4)
#
##Output (a dataframe with these columns):
  #"site"      Name of site where organism was collected (factor)
  #"d13C"      d13C isotope signature data (numeric)
  #"d15N"      d15N isotope signature data (numeric)
  #"species"   Fish species (character)
  #"id"        ID number for individual fish (numeric)
  #"tp"        Trophic position (numeric)
  #"feeding"   Functional feeding group classification (character)
#
#Note: assumes that ID numbers are not repeated among different sites of the same project
#Note: rows with NA values removed in function output
#
tp_calc <- function(mussdf = mussdf, fish, frac=3.4){
  source("base_sig.R")
  mussdf <- base_sig(muss, frac)
  df <- merge(mussdf, fish, by = "site")
  df$tp <- ((((df$d15N-df$baseline))/frac)+1)
  tpdf <- data.frame(df$site, df$d13C, df$d15N, df$species, df$id, df$tp, df$feeding)
  colnames(tpdf) <- c("site", "d13C", "d15N", "species", "id", "tp", "feeding")
  return(na.omit(tpdf))
}
