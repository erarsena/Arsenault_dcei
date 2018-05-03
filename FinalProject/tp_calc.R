#Takes output from base_sig to calculate the trophic position for each fish (row) in dataframe
#
#Args
#
##fish (a dataframe with these columns):
  #"site"       Name of site where consumer (fish) was collected
  #"d15N"       Consumer d15N signatures for each individual (row) categorized by "site"
##frac      Trophic discrimination factor used to calculate trophic position (default = 3.4)
#
##Output (a dataframe with these columns):
  #"site"      Name of site where organism was collected (factor)
  #"d13C"      d13C isotope signature data (numeric)
  #"d15N"      d15N isotope signature data (numeric)
  #"species"   Fish species (character)
  #"id"        ID number for individual fish (numeric)
  #"tp"        Trophic position (numeric)
#
#Note: assumes that ID numbers are not repeated among different sites of the same project
#Note: rows with NA values removed in function output
#
mussdf <- base_sig(muss, 3.4)
fish <- read.csv("fish.csv", header = T)

tp_calc <- function(dat, frac=3.4){
  df <- merge(mussdf, fish, by = "site")
  df$tp <- ((((df$d15N-df$baseline))/frac)+1)
  tpdf <- data.frame(df$site, df$d13C, df$d15N, df$species, df$id, df$tp, df$feeding, df$habitat)
  colnames(tpdf) <- c("site", "d13C", "d15N", "species", "id", "tp", "feeding", "habitat")
  return(na.omit(tpdf))
}
