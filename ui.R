if (interactive()) {

# ui

library(shiny)
library(shinythemes)
#library(shinyjs)


fig.width <- 600
fig.height <- 450


shinyUI(fluidPage(theme =  shinytheme("cerulean"),
 titlePanel("Linear Regression Model Dashboard"),

 sidebarLayout(
   sidebarPanel(
      
     #submitButton(text = "Click to Update Dashboard", icon("refresh")),
      br(),
     # sidepbar panel has the Input
     h4("Please Note :"),
     h4("The Input Dataset should contain",
        "Predictor in fisrt column and outcome in second column",style = "font-family: 'times'; font-si16pt"),
     helpText("the type of file you upload should be .csv or .txt",style = "font-family: 'times'; font-si16pt"),
     
     br(),
    # Check box for selection of header and type of file option
    #checkboxInput('header','Header', value = F),
    #checkboxInput('default','Default Data Set', value = T),
    #br(),
    #radioButtons('sep', 'separator', c(comma = ',', semicolon = ';', tab = '\t'), selected = NULL, inline = FALSE),
    #br(),

   # take the file from user
   fileInput('data', 'Choose file to upload', multiple = FALSE, accept = c('.text/ comma-separated-values',
                                                                           '.csv',
                                                                           '.xlsx',
                                                                           '.txt',
                                                                           '.text/ tab-separated-values')),
   actionButton('view', 'Upload', icon("upload")),
   actionButton('Plot_Button', 'Plot',icon("line-chart")),
   actionButton('linerregression', 'Linear Regression', icon("hourglass-start")),
   actionButton('summary', 'Data Summary',icon("pie-chart")),
   actionButton('modelsum', 'Model Summary',icon("bar-chart")),
   #actionButton("reset", "Clear"),
   
   tags$hr(),
   checkboxInput('header', 'Header', TRUE),
   radioButtons('quote', 'Quote',
                c(None='',
                  'Double Quote'='"',
                  'Single Quote'="'"),
                'Double Quote'),
   
   #br(),
   radioButtons('sep', 'separator', c(comma = ',', semicolon = ';', tab = '\t'), selected = NULL, inline = FALSE),
   br(),
   
   #helpText("Deselect default data set when you upload your data set"),
   
   numericInput("obs", "Observations:", 10,
                min = 1, max = 1000),
   

   #submitButton(text = "Update Dashboard")
),
  
   
   mainPanel(
      
      tableOutput("table"),
      plotOutput("plot"),
      plotOutput("LinearPlot"),
      verbatimTextOutput("summary"),
      verbatimTextOutput("Linearsummary")

      )
   )
   
   )  
)

}