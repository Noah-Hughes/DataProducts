Amort <- function(principala,rate,numMonth,group = character){
  
  df <- data.frame(Month = numeric(),
                   Principal= numeric(),
                   Payment = double(),
                   Interest = double(),
                   Loan = character(),
                   stringsAsFactors=FALSE
  )
  loopPrincipal <- principala
  monthcount <- 0
  payment <- principala *((rate/12/100*(1+rate/12/100)^numMonth)/((1+rate/12/100)^numMonth - 1))
  payment <- round(payment, digits = 2)
  group <- as.character(group)
  print(group)
  for (i in 1:numMonth){
    monthcount <- monthcount +1
    interestpmt <- round(loopPrincipal * rate/12/100, digits = 2)
    loopPrincipal <- round(loopPrincipal - payment + interestpmt, digits = 2)
    
    df[nrow(df)+1,] <- c(monthcount,loopPrincipal,payment,interestpmt,group)
    
  }
  return(df)
}