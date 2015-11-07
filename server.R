# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(quantmod)


shinyServer(function(input, output) {
        v <- reactiveValues(data = NULL)
        
        dataInput<-reactive({
                
                sym <- input$symbol
                
                getSymbols(sym,src="yahoo",auto.assign = FALSE)
                
        })
        
        observeEvent(input$goButton, {
                #v$data <- rnorm(100)
                
                
                progress <- shiny::Progress$new()
                # Make sure it closes when we exit this reactive, even if there's an error
                on.exit(progress$close())
                progress$set(message = "Reading data", value = 0)
                
                output$distPlot<- renderPlot({
                        hist(as.data.frame(last(dataInput(),90)[,3])[,1], 
                             breaks = input$bins, col = 'darkgray', border = 'white') 
                })
                
                progress$set(message = paste("Data for " , input$symbol , "retrieved."), value = 0)
                
                
                
        })  
        
})