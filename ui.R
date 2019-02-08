library(shiny)


shinyUI(
  pageWithSidebar(
    headerPanel("Next Word Prediction App"),
    sidebarPanel(
      
      h3("Enter your text here"),
      helpText("Please enter a sentence into the textbox below. The most probable next word prediction will be displayed on the right"),
      br(),
      textInput(inputId="query", label="Enter Text", width='100%')
      ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Prediction",
                          br(),
                           p('Most likely next word:'),
                           verbatimTextOutput('recommendation_1'),
                           p('Second most likely next word:'),
                           verbatimTextOutput('recommendation_2'),
                           p('Third most likely next word:'),
                           verbatimTextOutput('recommendation_3')
                  ),
                  tabPanel("Documentation",
                           h3("Background"),
                           p("This shiny application represents the product of the Capstone Project to the Data Science Specialisation by Johns Hopkins University"),
                           
                           h3("Author"),
                           p("K.Genov"),
                           
                           h3("Date"),
                           p("September 2018"),
                           
                           h3("How does it work"),
                           br(),
                           p("By entering a text in the textbox a simple back-off algorithm is turned on to predict the most likely next word. You can find more information about the project following the link to the presentation below"),
                           
                           br(),
                           h3("Presentation"),
                           p(a("Rpubs presentation to the Capstone Project", 
                                       href="http://rpubs.com/KGenov/next-word-prediction")))
                           
                           )            
                           )
                  )
  )