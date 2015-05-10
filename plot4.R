library(lubridate)              #To work with dates 
library(data.table)             #To make transformation quicker

#Let's read the data in
power <- read.csv("/Users/pranavmdesai/Documents/Courses/Exploratory Data Analysis/household_power_consumption.txt",sep=";",header = T)

#Let's convert the date into character which we can parse
power$Date_filter <- as.character(power$Date)

#Let's subset the data so that we import only days important to us
febdata <- subset(power, power$Date=="1/2/2007" | power$Date=="2/2/2007")
febdata <- data.table(febdata)

#Let's drop the filter column
febdata[,Date_filter:=NULL]

#Let's create a datetime variable for plotting continous values against
febdata$DateTime <- dmy_hms(paste(febdata$Date, febdata$Time),tz="America/Chicago")

#Let's make the different values numeric
febdata$Sub_metering_1 <- as.numeric(as.character(febdata$Sub_metering_1))
febdata$Sub_metering_2 <- as.numeric(as.character(febdata$Sub_metering_2))
febdata$Sub_metering_3 <- as.numeric(as.character(febdata$Sub_metering_3))
febdata$Global_active_power <- as.numeric(febdata$Global_active_power)
febdata$Global_reactive_power <- as.numeric(febdata$Global_reactive_power)

#Let's divide our plot area as a 2 x 2 
par(mfrow = c(2,2))
plot(y=febdata$Global_active_power/500, x=febdata$DateTime,type="l", xlab="", ylab="Global Active Power")
plot(y=febdata$Voltage, x=febdata$DateTime,type="l", xlab="", ylab="Voltage")

plot(y=febdata$Sub_metering_1,x=febdata$DateTime, type="l", ylim=c(0,35), xlab="", ylab="Energy sub metering")

par(new=T)
plot(y=febdata$Sub_metering_2,x=febdata$DateTime, col="Red", type="l", yaxs="r", xlab="",ylab="",ylim=c(0,35))

par(new=T)
plot(y=febdata$Sub_metering_3,x=febdata$DateTime, type="l", ylim=c(0,35),xlab="",ylab="", col="Blue")

plot(y=febdata$Global_reactive_power, x=febdata$DateTime,type="l", xlab="", ylab="Global_reactive_power")

#Writing the plots out as a png file
dev.copy(png,"plot4.png")
dev.off()





