#Takes mussel d15N signature data seperated by site and returns a dataframe with two columns (site and mean d15N)
#
#Args
#muss      A dataframe with d15N data for mussels at different sites along a river
#by        The column populated by site number (default = site)
#
#Output - a dataframe with these columns
#site     Site along river
#base     Mean d15N for primary producers (baseline signature) at a site

base_sig <- function(dat, by) {
  
  #for each site in column by
    #find the mean d15N from column
}

