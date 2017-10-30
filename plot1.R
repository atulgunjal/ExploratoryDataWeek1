##load necessary libraries
library(dplyr)
library(datasets)
##initialize data frames, variables to use
df_epc = NULL
df_target_epc=NULL
DATE1 = NULL
DATE2= NULL

##read data. We will read the entire file 
df_epc <-  read.table(".\\household_power_consumption.txt",sep = ";", header = TRUE,na.strings="?")
df_epc$Date <- as.Date(df_epc$Date, format='%d/%m/%Y')

## set the date window 
date_range <-  c ("01/02/2007","02/02/2007")
date_tocheck<- as.Date(date_range,format("%d/%m/%Y"))

DATE1 = date_tocheck[1]
DATE2  = date_tocheck[2]

## create a data subset

twodays <- subset(df_epc, df_epc$Date== DATE1|df_epc$Date==DATE2)


## create histogram
hist((as.numeric(as.character(twodays$Global_active_power))), col= "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power" )
## copy histogram to a PNG file
dev.copy(png, file="plot1.png")
#Close PNG device
dev.off()



