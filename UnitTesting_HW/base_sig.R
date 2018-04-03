#Takes mussel d15N signature data seperated by site 
#and returns a vector with two values (site name and mean primary producer signature for that site)
#
#Args
#sitename     The name of one site 
#frac         Trophic discrimination factor used to calculate trophic position (default = 3.4)
#
#Output
#base         A single number equal to mean primary producer signature at sitename

base_sig <- function(sitename, frac) {
  frac <- 3.4
  base <- mean((muss$d15N-frac)[muss$site==sitename])
  return(base)
}