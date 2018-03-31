#Takes output from base_sig to calculate the trophic position for each fish (row) in dataframe
#
#Args
#fish      A dataframe with d15N data for fish at different sites along a river
#frac      Trophic discrimination factor used to calculate trophic position (default = 3.4)
#
#Output -  A dataframe with these columns
#site      Site along river
#species   Fish species (character class)
#id        ID number for individual fish
#tp        Trophic position
#
tp_calc <- function(fish, frac=3.4) {
  
  #read in data
  #call base_sig
  
  #for(each fish (row) in the dataset)
    #use the output of base_sig to calculate trophic position
  
  return(as.data.frame(c(site, species, id, tp)))
  
}