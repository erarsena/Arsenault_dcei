#Takes output from base_sig to calculate the trophic position for each fish (row) in dataframe
#
#Args
#dat      A dataframe with d15N data for mussels and fish at different sites along a river
#frac     Trophic discrimination factor used to calculate trophic position (default = 3.4)
#
#Output - a dataframe with these columns
#site     Site along river
#species  Fish species (character class)
#tp       Trophic position
#
tp_calc <- function(dat, frac) {
  #call base_sig
  
  #for(each fish (row) in the dataset)
    #use the output of base_sig to calculate trophic position
}