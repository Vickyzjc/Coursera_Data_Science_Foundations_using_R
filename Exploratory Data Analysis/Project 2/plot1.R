# Before running the following code
# need to set work space to a folder which contains this file and data files: 
# "Source_Classification_Code.rds", "summarySCC_PM25.rds"


# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# calculate the sum firstly
sumEmmissions <- aggregate(Emissions ~ year, NEI, sum)
# plot
png("plot1.png", width=480, height=480)

barplot(
  height=(sumEmmissions$Emissions)/10^6, 
  names.arg=sumEmmissions$year, 
  xlab="Year", ylab=expression('Sum of Emission (10^6 Tons)'), ylim=c(0,8), 
  main=expression('Sum of PM'[2.5]*' Emmissions by Year'), 
  col = c("cyan", "brown1", "chocolate1", "azure")
  )
dev.off()

# Answer to Q1: The PM2.5 emissions decreased nearly 3.86 * 10^6 ton from 1999 to 2008