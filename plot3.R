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
febdata$DateTime <- dmy_hms(paste(febdata$Date, febdata$Time),tz="America/Chicago")

febdata$Sub_metering_1 <- as.numeric(as.character(febdata$Sub_metering_1))
febdata$Sub_metering_2 <- as.numeric(as.character(febdata$Sub_metering_2))
febdata$Sub_metering_3 <- as.numeric(as.character(febdata$Sub_metering_3))

par(mar=c(5,5,4,3)+0.1)
plot(y=febdata$Sub_metering_1,x=febdata$DateTime, type="l", ylim=c(0,35), xlab="", ylab="Energy sub metering")

par(new=T)
plot(y=febdata$Sub_metering_2,x=febdata$DateTime, col="Red", type="l", yaxs="r", xlab="",ylab="",ylim=c(0,35))

par(new=T)
plot(y=febdata$Sub_metering_3,x=febdata$DateTime, type="l", ylim=c(0,35),xlab="",ylab="", col="Blue")

#Now for the legend
legend("topright", lwd=1, y.intersp=0.25, cex=0.75, text.width=45405, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))

dev.copy(png,"plot3.png")
dev.off()

