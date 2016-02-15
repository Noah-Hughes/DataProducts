library(shiny)
library(ggplot2)

shinyUI(

  fluidPage(
    
    titlePanel("Mortgage Payment Comparison 15 vs. 30"),
    
    sidebarPanel(
      
      numericInput("Principal",
                   "Principal",150000,min =0, step = 25000),
      
      sliderInput("fifteenyr",
                  "15 Year Interest Rate %",value = 3,min =.125, max = 10, step = .125),
      
      sliderInput("thirtyyr",
                   "30 Year Interest Rate %",value = 4,min =.125, max = 10, step = .125),
      
      submitButton('Submit')
    ),
    
    mainPanel(
      h4("15 Year Payment"),
      verbatimTextOutput("fifteenP"),
      
      h4("30 Year Payment"),
      verbatimTextOutput("thirtyP"),
      
      h4("Plot of 15 vs 30 year"),
      plotOutput("Plotme"),
      
      h4("Monthly Amortization Tables"),
      verbatimTextOutput("PP")
      
      
    )
  )
)