# Before running the following code
# need to set work space to a folder which contains this file and data files: 
# "Source_Classification_Code.rds", "summarySCC_PM25.rds"

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# select the data for Baltimore and calculate the sum firstly
baltimoreData <- subset(NEI, fips=="24510")
sumBaltimoreEmmissions <- aggregate(Emissions ~ year, baltimoreData, sum)

# plot
png("plot2.png", width=480, height=480)

barplot(
  height=(sumBaltimoreEmmissions$Emissions)/10^3, 
  names.arg=sumBaltimoreEmmissions$year, 
  xlab="Year", ylab=expression('Sum of Emission in Baltimore (10^3 Tons)'), ylim=c(0,4), 
  main=expression('Sum of PM'[2.5]*' Emmissions in Baltimore by Year'), 
  col = c("cyan", "brown1", "chocolate1", "azure")
)
dev.off()

# Answer to Q2: The PM2.5 emissions decreased nearly 1411.9 ton from 1999 to 2008 in Baltimore City