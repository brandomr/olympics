gettotals <- function(data, sortby="Country") {
  
  totalcount <- with(data, tapply(TotalAdj, list(Country.Name, GameType), sum))

  dim(totalcount)

  totalcount <- data.frame(lapply(1:2, function(i) totalcount[,i]))
  colnames(totalcount) <- c("summer.medcount", "winter.medcount")

  totalcount["Country.Name"] <- rownames(totalcount)
  totalcount <- totalcount[c(3,1,2)]
  row.names(totalcount) <- NULL
  
  if(sortby == "Summer") {  
    totalcount <- totalcount[with(totalcount, order(-totalcount[,2])),]
  }

  if(sortby == "Winter") {  
    totalcount <- totalcount[with(totalcount, order(-totalcount[,3])),]
  }
  
  if(sortby == "Country") {  
    
  }
    
  print(head(totalcount))
  
}
