# Before running the following code
# need to set work space to a folder which contains this file and data file: "household_power_consumption.txt"

originalEnergy <- read.table("household_power_consumption.txt", header=TRUE, na.strings = "?", sep=";", dec=".")
twoDayData <- subset(originalEnergy, originalEnergy$Date == "1/2/2007" | originalEnergy$Date == "2/2/2007")

# change some format and create a new column here to make plot easy 
twoDayData$DateWithTime <- strptime(paste(twoDayData$Date, twoDayData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
twoDayData$Sub_metering_1 <- as.numeric(twoDayData$Sub_metering_1)
twoDayData$Sub_metering_2 <- as.numeric(twoDayData$Sub_metering_2)
twoDayData$Sub_metering_3 <- as.numeric(twoDayData$Sub_metering_3)

# plot 
png("plot3.png", width=480, height=480)
plot(twoDayData$DateWithTime, twoDayData$Sub_metering_1, type="l", xlab="Date & Time (detailed to second)", ylab="Energy Submetering", main="Energy Submetering variation by Date & Time")
lines(twoDayData$DateWithTime, twoDayData$Sub_metering_2, col="red")
lines(twoDayData$DateWithTime, twoDayData$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()