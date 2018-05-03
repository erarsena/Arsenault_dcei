fish_supp <- function(fish) {
  species <- levels(fish$species)
  count <- vector(mode = "numeric")
  for(i in species) {
    count[i] <- nrow(fish[fish$species==i,])
  }
  fishsupp <- data.frame(species, count, row.names = NULL)
  colnames(fishsupp) <- c("Species", "Count")
  return(fishsupp)
}