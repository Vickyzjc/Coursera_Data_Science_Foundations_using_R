# Before running the following code
# need to set work space to a folder which contains this file and data file: "household_power_consumption.txt"

originalEnergy <- read.table("household_power_consumption.txt", header=TRUE, na.strings = "?", sep=";", dec=".")
twoDayData <- subset(originalEnergy, originalEnergy$Date == "1/2/2007" | originalEnergy$Date == "2/2/2007")

# change some format here to make plot easy
twoDayData$Global_active_power <- as.numeric(twoDayData$Global_active_power)

# plot 
png("plot2.png", width=480, height=480)
# combine date and time because directly transfer time will contain local date
twoDayData$DateWithTime <- strptime(paste(twoDayData$Date, twoDayData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
plot(twoDayData$DateWithTime, twoDayData$Global_active_power, xlab="Date & Time (detailed to second)", ylab="Global Active Power (kilowatts)", main="Global Active Power Variation by Date & Time", type="l")
dev.off()