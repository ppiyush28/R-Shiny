

library(shiny)
#library(shinyjs)
library(aws.s3)

options(shiny.maxRequestSize = 9 *1024^2)

shinyServer(function(input, output) {
  #reactive
  # inputData<-reactive({
  # 
  #   inFile <- input$data
  # 
  #   if (is.null(inFile))
  #     return(NULL)
  # 
  #  file <- read.csv(inFile$datapath, header = input$header,
  #            sep = input$sep, quote = input$quote)
  # 
  # })
 
 read_table <- eventReactive(input$view, {

    if(is.null(input$data))  {
       return(NULL)
    }
    inFile <- input$data

    file <- read.csv(inFile$datapath, header = input$header,
                     sep = input$sep, quote = input$quote)

    file<- file[1:input$obs,]

 })
  
 output$table <- renderTable({
    
    read_table()
    
  })

   output$downloadData <- downloadHandler(
      filename = function(){
      paste("file","csv",sep=".")
      },
      
      content = function(file){
         write.csv(inputData(),file)
         
      }
   )
   
   # observeEvent(input$reset, {
   #   removeUI("#table")
   # })
 
#event Function
 plot1 <- eventReactive(input$Plot_Button,{
    
   if(is.null(input$data))  {
     return(NULL)
   }
   inFile <- input$data
   
   file <- read.csv(inFile$datapath, header = input$header,
                    sep = input$sep, quote = input$quote)
    
   
  
    file<- file[1:input$obs,]
    x<- file[,1]
    y<- file[,2]
    
    
    plot(x, y,xlab =colnames(file[,1]),ylab=colnames(file[,2]))
    
    
 })
 output$plot <- renderPlot({
   
    plot1()
})
 
 # observeEvent(input$reset, {
 #   removeUI("#plot")
 # })

 LRplot <- eventReactive(input$linerregression, {
    
    inFile <- input$data
    
    
    if(is.null(input$data))     
       return(NULL) 
    file <- read.csv(inFile$datapath, header = input$header,
                     sep = input$sep, quote = input$quote)
    
    file<- file[1:input$obs,]
    x<- file[,1]
    y<- file[,2]
    
    par(mfrow=c(2,2))
    plot(lm(x~y)) 
    points(x, y, pch = 16, cex = 0.8, col = "red")
    
 })
 output$LinearPlot <- renderPlot({
   
    LRplot()
 })
 
 #event Function
 
 summary1 <- eventReactive(input$summary ,{
    inFile <- input$data
    
    
    if(is.null(input$data))     
       return()
    
    
    file <- read.csv(inFile$datapath, header = input$header,
                     sep = input$sep, quote = input$quote)
    
    file<- file[1:input$obs,]
    
    
    
    summary(file)
    
 })
 
 output$summary <-renderPrint({
    summary1()
   
 })
 
 #event Function
 
 LRsummary <- eventReactive(input$modelsum ,{
    
    inFile <- input$data
    
    
    
    if(is.null(input$data))     
       return()
    
    file <- read.csv(inFile$datapath, header = input$header,
                     sep = input$sep, quote = input$quote)
    
    file<- file[1:input$obs,]
    x<- file[,1]
    y<- file[,2]
    
    
    summary(lm(x~y))
    
    
 })
 
 output$Linearsummary <-renderPrint({
    LRsummary()
 })
 
 
 
 
 
 
})