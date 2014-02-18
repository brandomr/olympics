createlattice <- function(data, sortby="Summer") {
  
  gametypesub <- data[ which(data$GameType== sortby), ]
  
 
  #assign('gametypesub', gametypesub, envir=.GlobalEnv)
  
  library(lattice)
  
  gametypesub$Year <- as.factor(gametypesub$Year)
  
  xyplot(TotalAdj ~ Pop | Year, 
         data = gametypesub,
         xlab = "Population",
         ylab = "Total Medals Earned",
         main = "Winter Olympics: Medal Count by Population",
         panel = function(x,y,...,subscripts){
           panel.xyplot(x,y)
           panel.lmline(x,y, col="grey")
         })
  
  
}
