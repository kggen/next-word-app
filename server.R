library(shiny)
source("Prediction.R")

shinyServer(
  function(input, output){
    result <- reactive({
      nextWord(input$query)
    })
    
    output$query <- renderPrint({input$query})
    output$recommendation_1 <- renderText({result()[1]})
    output$recommendation_2 <- renderText({result()[2]})
    output$recommendation_3 <- renderText({result()[3]})
  }
)