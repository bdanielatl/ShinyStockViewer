
hd$startdate<-ymd(hd$startdate)
hdFC<-filter(hd,startdate >= ymd(Sys.Date()-90))
hdEMA <- EMA(hdFC[,5],n=10,ratio =.5)

fcoutput<-data.frame(startdate=hdFC[,1], act=hdFC[,2], fc=hdEMA)

#for i = 1 to n (10)
#take the last n data points and create a forecast value out of it and append it to the output dataset
addForecastRows<- function (df,i,m){
        #df is a data frame with the original fcoutput, create a new forecast value
        fc<-EMA(tail(df,m)[,3],n=m,ratio=.50)
        fc<-last(fc)
        #n is a parameter stating the number of buckets, create a new start date
        act<-NA
        startdate <- tail(df,1)[,1] + days(1)
        newDF<-data.frame(startdate,act,fc)
}
#add a row to the output data frame

for(i in 1:10){
        
        newDF<-addForecastRows(fcoutput,i,10)
        fcoutput<<-rbind(fcoutput,newDF)                
        
}
