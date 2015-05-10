#Let's read the data in
power <- read.csv("/Users/pranavmdesai/Documents/Courses/Exploratory Data Analysis/household_power_consumption.txt"
                  ,sep=";",header = T)

#Let's convert the date into character which we can parse
power$Date_filter <- as.character(power$Date)

#Let's subset the data
febdata <- subset(power, power$Date=="1/2/2007" | power$Date=="2/2/2007")

#Let's convert the active power values to numeric so that they can be plotted
febdata$Global_active_power <- as.numeric(febdata$Global_active_power)

#Let's create our histogram with the appropriate x-axis label and color for the bars
hist(febdata$Global_active_power/500,main = "Global Active Power", col = "Red", 
     xlab = "Global Active Power (kilowatts), ")

dev.copy(png,"plot1.png")
dev.off()

