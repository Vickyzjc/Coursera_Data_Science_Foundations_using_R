# Before running the following code
# need to set work space to a folder which contains this file and data file: "household_power_consumption.txt"

originalEnergy <- read.table("household_power_consumption.txt", header=TRUE, na.strings = "?", sep=";", dec=".")
twoDayData <- subset(originalEnergy, originalEnergy$Date == "1/2/2007" | originalEnergy$Date == "2/2/2007")

# change some format and create a new column here to make plot easy 
twoDayData$DateWithTime <- strptime(paste(twoDayData$Date, twoDayData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
twoDayData$Global_active_power <- as.numeric(twoDayData$Global_active_power)
twoDayData$Voltage <- as.numeric(twoDayData$Voltage)
twoDayData$Sub_metering_1 <- as.numeric(twoDayData$Sub_metering_1)
twoDayData$Sub_metering_2 <- as.numeric(twoDayData$Sub_metering_2)
twoDayData$Sub_metering_3 <- as.numeric(twoDayData$Sub_metering_3)
twoDayData$Global_reactive_power <- as.numeric(twoDayData$Global_reactive_power)

# plot 
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

plot(twoDayData$DateWithTime, twoDayData$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(twoDayData$DateWithTime, twoDayData$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(twoDayData$DateWithTime, twoDayData$Sub_metering_1, type="l", xlab="", ylab="Energy Submetering")
lines(twoDayData$DateWithTime, twoDayData$Sub_metering_2, col="red")
lines(twoDayData$DateWithTime, twoDayData$Sub_metering_3, col="blue")
legend("topright", lty=1, cex=0.7, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(twoDayData$DateWithTime, twoDayData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()