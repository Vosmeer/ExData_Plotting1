### Coursera Data Science, Course 4, Week 1, Quiz 1 ###

setwd("C:/_Data/Mijn Documenten/R/Scripts Coursera/Course 4 - Week 1")
getwd()

options(scipen=0)

library(dplyr)
library(reshape2)
library(tidyr)
library(chron)
library(ggplot2)

## Import data and cleanup ## 

url1<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url1,destfile="Course4Week1Quiz1.zip")
brondata<-read.table("household_power_consumption.txt",sep=";",stringsAsFactors = F,dec=".",header = T)
brondata$Date <- strptime(brondata$Date, "%d/%m/%Y")
brondata$Time <- times(brondata$Time)

brondata[,8]<-as.numeric(brondata[,8])
brondata[,7]<-as.numeric(brondata[,7])
brondata[,6]<-as.numeric(brondata[,6])
brondata[,5]<-as.numeric(brondata[,5])
brondata[,4]<-as.numeric(brondata[,4])
brondata[,3]<-as.numeric(brondata[,3])

data<-brondata[(brondata$Date=="2007-02-1") | (brondata$Date=="2007-02-2"),]
data$weekday<-weekdays(data$Date)

data <- transform(data, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

## Create plot 4 ##


png('plot4.png')
par(mfrow=c(2,2))

# Create plot part 1 #

plot(data$timestamp,data$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")

# Create plot part 2 #

plot(data$timestamp,data$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")

# Create plot part 3 #

plot(data$timestamp,data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data$timestamp,data$Sub_metering_2,col="blue")
lines(data$timestamp,data$Sub_metering_3,col="red")
legend("topright", col=c("black","blue","red"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=1, lwd=1)

# Create plot part 4 #

plot(data$timestamp,data$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")

dev.off()