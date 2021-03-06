#Generates a unique color for each level in a group by drawing from a set color palette
#
##Args
#groups   Number of groups to be illustrated using different colors (numeric)
#
##Output
#variable with colors, to be used in plotting using plot_web()
#
gen_col <- function(groups){
  if(require(RColorBrewer)){
    cols <- brewer.pal(groups,"Spectral")
  }
  return(cols)
}