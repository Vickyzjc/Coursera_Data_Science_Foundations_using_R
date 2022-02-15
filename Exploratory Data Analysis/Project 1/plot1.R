# Before running the following code
# need to set work space to a folder which contains this file and data file: "household_power_consumption.txt"

originalEnergy <- read.table("household_power_consumption.txt", header=TRUE, na.strings = "?", sep=";", dec=".")
twoDayData <- subset(originalEnergy, originalEnergy$Date == "1/2/2007" | originalEnergy$Date == "2/2/2007")
                           
# change some format here to make plot easy
twoDayData$Date <- as.Date(twoDayData$Date, format="%d/%m/%Y")
twoDayData$Global_active_power <- as.numeric(twoDayData$Global_active_power)

# plot 
png("plot1.png", width=480, height=480)
hist(twoDayData$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
dev.off()