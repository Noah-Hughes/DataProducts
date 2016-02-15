#
# Math Formulas for loans from http://www.mtgprofessor.com/formulas.htm
library(shiny)
library(ggplot2)

Amort <- function(principala,rate,numMonth,group){
  
  df <- data.frame(Month = integer(),
                   Principal=double(),
                   Payment = double(),
                   Interest = double(),
                   Loan = character(),
                   stringsAsFactors=FALSE
  )
  loopPrincipal <- principala
  monthcount = 0
  payment <- principala *((rate/12/100*(1+rate/12/100)^numMonth)/((1+rate/12/100)^numMonth - 1))
  payment <- round(payment, digits = 2)
  group <- as.character(group)
  
  for (i in 1:numMonth){
    monthcount <- monthcount +1
    interestpmt <- round(loopPrincipal * rate/12/100, digits = 2)
    loopPrincipal <- round(loopPrincipal - payment + interestpmt, digits = 2)
    
    df[nrow(df)+1,] <- c(monthcount,loopPrincipal,payment,interestpmt,group)
    
  }
  df <- transform(df, Month = as.numeric(Month), Principal = as.numeric(Principal))
  return(df)
}

combinedf <- function(df1,df2){
  
  df <- rbind(df1,df2)
  return(df)
}

graphstuff <- function(df){
  df22 <- data.frame(df)
  g <- ggplot(df22, aes(x=Month, y=Principal, group=Loan, col=Loan, fill=Loan)) +
    geom_point() +
    geom_smooth(size=1)
  
  return(g)
}

shinyServer(
  function(input, output){
    principal <- reactive({as.numeric(input$Principal)})
    
    dfthirty <- reactive({Amort(principal(),input$thirtyyr,360,"30 year")})
    dffifteen <- reactive({Amort(principal(),input$fifteenyr,180,"15 year")})
    dfall <- reactive({combinedf(dfthirty(),dffifteen())})
    graphobject <- reactive({graphstuff(dfall())})
    
    
    output$PP <- renderPrint(dfall())
    
    #P = L[c(1 + c)^n]/[(1 + c)^n - 1]
    output$thirtyP = renderPrint(principal() *((input$thirtyyr/12/100*(1+input$thirtyyr/12/100)^360)/((1+input$thirtyyr/12/100)^360 - 1)))
  
    output$fifteenP = renderPrint(principal() *((input$fifteenyr/12/100*(1+input$fifteenyr/12/100)^180)/((1+input$fifteenyr/12/100)^180 - 1)))
    
    output$Plotme = renderPlot(graphobject())
    
  }
)