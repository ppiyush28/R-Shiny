

# ui

library(shiny)
library(shinythemes)


fig.width <- 600
fig.height <- 450


shinyUI(fluidPage(theme =  shinytheme("cerulean"),
 titlePanel("Linear Regression Model"),

 sidebarLayout(
   sidebarPanel(
    
     # sidepbar panel has the Input
     h4("Please Note :"),
     h4("The Input Dataset should contain",
        "Predictor in fisrt column and outcome in second column",style = "font-family: 'times'; font-si16pt"),
     helpText("the type of file you upload should be .csv or .txt",style = "font-family: 'times'; font-si16pt"),
     
     br(),
    # Check box for selection of header and type of file option
    checkboxInput('header','Header', value = F),
    checkboxInput('default','Default Data Set', value = T),
    br(),
    radioButtons('sep', 'separator', c(comma = ',', semicolon = ';', tab = '\t'), selected = NULL, inline = FALSE),
    br(),

   # take the file from user
   fileInput('data', 'Choose file to upload', multiple = FALSE, accept = c('.text/ comma-separated-values',
                                                                           '.csv',
                                                                           '.xlsx',
                                                                           '.txt',
                                                                           '.text/ tab-separated-values')),
   tags$hr(),
   checkboxInput('header', 'Header', TRUE),
   radioButtons('quote', 'Quote',
                c(None='',
                  'Double Quote'='"',
                  'Single Quote'="'"),
                'Double Quote'),
   
   helpText("Deselect default data set when you upload your data set"),
   
   numericInput("obs", "Observations:", 20,
                min = 1, max = 1000),
   


),
  
   
   mainPanel(
      
     
   
     tabsetPanel(
       
       tabPanel("Table", tableOutput("table")),
       tabPanel("Plot", plotOutput("plot")),
       tabPanel("Linear Regression", plotOutput("LinearPlot")),
       tabPanel("Summary", verbatimTextOutput("summary")),
       tabPanel("Linear Regression Summary", verbatimTextOutput("Linearsummary"))
     )
   )
   
   )  
)
)