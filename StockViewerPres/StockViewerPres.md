Stock Information Through R
========================================================
author: Ben Daniel
date: 11/14/2015
transition: rotate

Financial Information on the Internet
========================================================

- For more than two decades, financial inforamtion on stock prices have been available throuth the Internet.
- Several aggregators such as Yahoo and Google have finance websites that can graph and download this information

Issues Viewing this Information

- Downloading data can be cumbersome
- Getting it in the right format is unreliable
- Loading it into an analytics application has not always lent flexibility

Financial Info on Internet + Analytics
========================================================
There is a solution
- R Packages such as [quantmod](http://www.quantmod.com/) make it easy to obtain this information directly into reusable code.
- Analytic packages such as [TTR](http://www.inside-r.org/packages/cran/TTR/docs/MovingAverages) can use this information to present useful or insightful analytics
- ShinyApps provide a means for users to interact with the data, do what-if scenarios, and create meaningful analysis.

Examining the Stock Price of The Home Depot
========================================================
Lets look at the stock price for The Home Depot, a home improvement retailer based in the United States in Atlanta, Georgia. 

- The code below shows the quantmod package to import the data from Yahoo for HD.
- Once the data is downloaded, it can be transformed into other structures, such as dataframes, for analysis. 

```r
dataInput<-getSymbols("HD",src="yahoo",auto.assign = FALSE)
#transform to data frame
stockData<- as.data.frame(dataInput)  
```

Examples of Analysis of Data
========================================================
In the figure on the left, I used the **hist** function to create a histogram. On the right, TTR package creates a 10 period moving average forecast of the stock's closing price. 
- See the [Stock Viewer on ShinyApps] (https://bdanielatl.shinyapps.io/ShinyStockViewer) to try other symbols and scenarios.

<img src="StockViewerPres-figure/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="float:left" />
<img src="StockViewerPres-figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="float:left" />
