#' plot_web
#'
#' Generates a plot in isotopic space for each study site
#
#' @param fish A dataframe with d13C and d15N data for fish at different sites along a river
#'
#' @return A plot in isotopic space (x=d13C, y=d15N)

plot_web <- function(fish) {
  cnplot <- plot(x = dat$d13C, y = dat$d15N, pch = 16,
                 col = c("red", "blue", "green", "black")[as.numeric(tpdf$site)],
                 xlab = expression(paste(delta, ""^"13", "C")), ylab = expression(paste(delta, ""^"15", "N")))
  return(cnplot)
}
