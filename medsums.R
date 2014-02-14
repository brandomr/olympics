totalcount <- with(medcount, tapply(Total, list(partCountry, GameType), sum))

dim(totalcount)

lapply(1:2, function(i) totalcount[,i])
