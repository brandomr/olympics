cr <- function(cDF) {
  cDF["cGDP_country"] <- NA
  cDF["cPOP_country"] <- NA
  
  cDF <- data.frame(lapply(cDF, as.character), stringsAsFactors=FALSE)
  cGDP <- data.frame(lapply(cGDP, as.character), stringsAsFactors=FALSE)
  cPOP <- data.frame(lapply(cPOP, as.character), stringsAsFactors=FALSE)
  
  
  rows <- nrow(cDF)
  
  for (i in 1:rows) {
    
    country <- cDF$country[i]
    
    gdpindx <- which(cGDP$country == country)
    popindx <- which(cPOP$country == country)
    
    
    cDF[i, 2] <- if(length(gdpindx)==0) {"NA"} else { cGDP[gdpindx, 1] }
    cDF[i, 3] <- if(length(popindx)==0) {"NA"} else { cPOP[popindx, 1] }
    
  }
  
  assign('cDF',cDF,envir=.GlobalEnv)
}