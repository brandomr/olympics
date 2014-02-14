medconcat <- function() {
  DF <- medcount
  DF["gdp"] <- NA
  DF["pop"] <- NA

  DF <- data.frame(lapply(DF, as.character), stringsAsFactors=FALSE)
  gdp <- data.frame(lapply(gdp, as.character), stringsAsFactors=FALSE)
  pop <- data.frame(lapply(pop, as.character), stringsAsFactors=FALSE)


  rows <- nrow(DF)

  for (i in 1:rows) {
  
    year <- DF$Year[i]
    country <- DF$partCountry[i]
  
    gdpindx <- which(gdp$Country.Name == country & gdp$Year == year)
    popindx <- which(pop$Country_Name == country & pop$Time_Value == year)
    
    
    DF[i, 11] <- gdp[gdpindx, 5]
    DF[i, 12] <- pop[popindx, 5]
  
  }
}

