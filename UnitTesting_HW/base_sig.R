#Takes mussel d15N signature data seperated by site and returns a dataframe with two columns (site and mean d15N)
#
#Args
#muss      A dataframe with d15N data for mussels at different sites along a river
#frac      Trophic discrimination factor used to calculate trophic position (default = 3.4)
#
#Output - a dataframe with these columns
#site     Site along river
#base     Mean d15N for primary producers (baseline signature) at a site

base_sig <- function(dat, by) {
  
  #read in data
 
  #for each mussel (row) in muss
    #calculate primary producer signature by subtracing frac from d15N value
      #find the mean d15N by site (by)
  return(as.data.frame(c(site, base)))
  
}