
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
        
        # Application title
        titlePanel("Shiny Stock Viewer"),
        sidebarLayout(
                sidebarPanel(
                        p("Input a stock symbol, length number of histogram bins,choose a moving avg length, sensitivity, and click Go."),
                        p("Note: (higher values weight more recent values)"),
                        #add a text input field for a stock symbol
                        textInput("symbol","Stock Symbol","HD"),
                        #add a slider for a n-period moving average
                        sliderInput("bins",
                                    "Number of bins:",
                                    min = 1,
                                    max = 50,
                                    value = 30),
                        #day moving average
                        numericInput("MALength","Moving Avg Length (days)",10,1,45),
                        #sensitivty
                        numericInput("Ratio","Moving Avg Sensitivity",.5,0,1),
                        actionButton("goButton","Go")
                ),
                mainPanel(
                        p("This application will retreive a stock symbol and generate a moving average forecast."),
                        
                        textOutput("symbolText")
                        ,plotOutput("distPlot")
                        ,plotOutput("fcstPlot")
                        
                )
                
        )
        
)
)