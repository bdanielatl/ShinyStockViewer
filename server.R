# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

require(shiny)
require(quantmod)
require(TTR)
require(lubridate)
require(dplyr)
require(ggplot2)

shinyServer(function(input, output) {
        v <- reactiveValues(data = NULL)
        
        #create a reactive function.
#         dataInput<-reactive({
#                 #get the symbol from the input
#                 sym <- input$symbol
#                 #get the symbol stock data from yahoo!
#                 getSymbols(sym,src="yahoo",auto.assign = FALSE)
#                 
#         })

        #on submit, read the data and plot it        
        observeEvent(input$goButton, {
                #v$data <- rnorm(100)

                progress <- shiny::Progress$new()
                # Make sure it closes when we exit this reactive, even if there's an error
                on.exit(progress$close())
                progress$set(message = "Reading data", value = 0)
                
                progress$set(message = paste("Data for " , input$symbol , "retrieved."), value = 0)
                
                progress$set(message = paste("Generating plot and forecast."), value = 0)
                #get the symbol from the input
                sym <- input$symbol
                #get the symbol stock data from yahoo!
                dataInput<-getSymbols(sym,src="yahoo",auto.assign = FALSE)
                
                
                
                 stockData<- as.data.frame(dataInput)  
                 stockData<-cbind(startdate = rownames(stockData),stockData)
                 stockData$startdate<-ymd(stockData$startdate)
                 
                 l90StockData<-filter(stockData,startdate >= ymd(Sys.Date()-days(90)))
                 

                 output$distPlot<- renderPlot({
                         #hist(as.data.frame(last(dataInput(),90)[,3])[,1], 
                         #     breaks = input$bins, col = 'darkgray', border = 'white') 
                         hist(l90StockData[,4],
                                breaks=input$bins,col='darkgray',border='white',
                             main=paste("Histogram for 90 days closing stock price of ",input$symbol))
                })
                
                #do an n period  moving average forecast from the last 90 days 
                
                sdEMA <- EMA(l90StockData[,4],n=input$MALength,ratio =input$Ratio)
                
                #now bind it with the rest of the data
                #add a startdate column
                fcoutput<-data.frame(startdate=l90StockData[,1],act=l90StockData[,2],fc=sdEMA)
                
                plotTitle<-paste(input$MALength," period moving average for ",input$symbol)
                
                fcplot<-ggplot(fcoutput,aes(startdate))+
                        ggtitle(plotTitle)+
                        ylab("Closing Price")+
                        xlab("Start date") +
                        geom_line(aes(y=act),color="black") +
                        geom_line(aes(y=fc),color="orange")
                
                
                output$fcstPlot <-renderPlot(fcplot)
                
                
                
        })  
        
})