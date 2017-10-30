##load necessary libraries
library(dplyr)
library(tidyr)
library(datasets)

##initialize data frames, variables to use
df_epc = NULL
df_target_epc=NULL
DATE1 = NULL
DATE2= NULL
twodays = NULL

##read data. We will read the entire file 
df_epc <-  read.table(".\\household_power_consumption.txt",sep = ";", header = TRUE,na.strings="?")
df_epc$Date <- as.Date(df_epc$Date, format='%d/%m/%Y')

## set the date window 
date_range <-  c ("01/02/2007","02/02/2007")
date_tocheck<- as.Date(date_range,format("%d/%m/%Y"))

DATE1 = date_tocheck[1]
DATE2  = date_tocheck[2]

## create a tidy data by creating subset of data between two dates and using as.date
##and strptime() functions

twodays <- subset(df_epc, df_epc$Date== DATE1|df_epc$Date==DATE2)



##get weekday for each date of the data

twodays$day <- weekdays(as.Date(twodays$Date,format("%Y-/%m-/%d") ))

## conbine first two columns i.e. Date and Time
twodays$datetime <- paste(twodays$Date,twodays$Time, sep=",")

## apply strptime function to the combined date and time column

twodays$datetimeforplot <- strptime(twodays$datetime, format="%Y-%m-%d,%H:%M:%S")

##plot data as line type 

png("plot3.png", width = 480, height = 480)

#use type="n" to print multiple Sub Meter
plot(twodays$datetimeforplot,twodays$Sub_metering_1,  type="n", ylab = "Energy sub metering" , xlab="",ylim = c(0, max(twodays$Sub_metering_1, twodays$Sub_metering_2, twodays$Sub_metering_3)))

#plot Sub_metering_1
lines(twodays$datetimeforplot,twodays$Sub_metering_1, type="l", col="black")
#plot SUb_metering_2
lines(twodays$datetimeforplot,twodays$Sub_metering_2, type="l", col="red")
#Plot Sub_metering_3
lines(twodays$datetimeforplot,twodays$Sub_metering_3, type="l", col="blue")

#Print legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))


#Close PNG device
dev.off()
