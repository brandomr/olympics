createlattice <- function(data, sortby="Summer") {
  
  gametypesub <- data[ which(data$GameType== sortby), ]
  
  
  #assign('gametypesub', gametypesub, envir=.GlobalEnv)
  
  library(lattice)
  
  gametypesub$Year <- as.factor(gametypesub$Year)
  
  xyplot(TotalAdj ~ log(GDP) | Year, 
         data = gametypesub,
         xlab = "Log(GDP)",
         ylab = "Total Medals Earned",
         main = "Winter Olympics: Medal Count by Log(GDP)",
         layout = c(4,4),
         panel = function(x,y,...,subscripts){
           panel.xyplot(x,y)
           panel.lmline(x,y, col="grey")
         })
  
  
}
