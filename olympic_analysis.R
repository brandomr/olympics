getperformance <- function(type) { 
  
  #read in data
  data <- read.csv("consolidated_olympic_datav3.csv")

  #subset by game type (winter or summer) and for only countries that participated
  datasub <- subset(data, GameType == type & Participant == 1)
    
  #create log population and log GDP vars
  datasub["logPop"] <- log(datasub$Pop)
  datasub["logGDP"] <- log(datasub$GDP)
  datasub["logGDPperCap"] <- log(datasub$GDP/datasub$Pop)
  
  #create lag total medals var using DataCombine package
  library(DataCombine)
  datasub <- datasub[order(datasub$Country.Name, datasub$Year),]
  datasub <- slide(datasub, Var = "TotalAdj", GroupVar = "Country.Name", slideBy = -1)
  colnames(datasub)[26] <- "TotalAdjLagBy1"
  
  #deal with NAs or inf in logGDPperCap var
  datasub$logGDPperCap[which(is.nan(datasub$logGDPperCap))] = NA
  datasub$logGDPperCap[which(datasub$logGDPperCap==Inf)] = NA
  
  #create dummy var for Year
  year.f = factor(datasub$Year)
  year.dummies = model.matrix(~year.f)
  
  #regression
  fit <- lm(TotalAdj ~ logPop + logGDPperCap + TotalAdjLagBy1 + year.dummies, data = datasub, na.action = na.exclude)
  print(summary(fit))
  
  #add predicted column
  datasub["predicted"] <- fitted(fit)
  datasub["residuals"] <- residuals(fit)
  
  
  assign('datasub',datasub,envir=.GlobalEnv)
  
  #create plot
  type_lab <- paste(type, "- Predicted Total Medals vs. Actual Total Medals")
  plot(datasub$predicted, datasub$TotalAdj,
       main = type_lab,
       cex.main = 1,
       xlab = "Predicted Total Medals",
       ylab = "Actual Total Medals",
       col = rgb(70,130,180,100,maxColorValue=255),
       pch = 19,)
  abline(lm(datasub$predicted~datasub$TotalAdj), col="grey") # regression line (y~x) 
  
  #subset out NA values and set min of predicted value to 0
  regoutput <- datasub[complete.cases(datasub),]
  regoutput["predicted"] <- round(regoutput$predicted, 0)
  regoutput$predicted[regoutput$predicted < 0] <- 0
  colnames(regoutput)[3] <- "CountryName"
  colnames(regoutput)[4] <- "CountryCode"
  colnames(regoutput)[9] <- "Yearextra"
  
  #min and max hardcode reductions
  #summer
  #regoutput$residuals[1360] <-45
  #regoutput$residuals[1361] <- -35
  
  #assign to global environment and save file
  assign('regoutput',regoutput,envir=.GlobalEnv)
  filetosave <- paste(type, "output.csv", sep="")
  write.csv(regoutput, file = filetosave)
  
  simpleoutput <- regoutput[, c("Year", "CountryName", "TotalAdj", "predicted", "residuals", "Gold", "Silver", "Bronze", "locCity")]
  assign('simpleoutput',simpleoutput,envir=.GlobalEnv)
  filetosave <- paste("simple", type, "output.csv", sep="")
  write.csv(simpleoutput, file = filetosave)
  
  
  #write summary output to an HTML table using xtable
  library(xtable)
  sumoutput <- summary(fit)
  xtableoutput <- xtable(sumoutput)
  coef_rl = print(xtableoutput, type = "html")
  

}