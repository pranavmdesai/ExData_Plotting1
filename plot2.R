library(lubridate)              #To work with dates 
library(data.table)             #To make transformation quicker

#Let's read the data in
power <- read.csv("/Users/pranavmdesai/Documents/Courses/Exploratory Data Analysis/household_power_consumption.txt",sep=";",header = T)

#Let's convert the date into character which we can parse
power$Date_filter <- as.character(power$Date)

#Let's subset the data
febdata <- subset(power, power$Date=="1/2/2007" | power$Date=="2/2/2007")
febdata <- data.table(febdata)

#Let's drop the filter column
febdata[,Date_filter:=NULL]
febdata$DateTime <- dmy_hms(paste(febdata$Date, febdata$Time),tz="America/Chicago")
febdata$Global_active_power <- as.numeric(febdata$Global_active_power)

plot(y=febdata$Global_active_power/500, x=febdata$DateTime,type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.copy(png,"plot2.png")
dev.off()

