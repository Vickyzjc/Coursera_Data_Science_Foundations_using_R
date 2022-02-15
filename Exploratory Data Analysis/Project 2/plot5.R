# Before running the following code
# need to set work space to a folder which contains this file and data files: 
# "Source_Classification_Code.rds", "summarySCC_PM25.rds"

library(ggplot2)
library(dplyr)

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# ON-ROAD is directly the vehicle in Baltimore
baltimoreEmissionsvehicleData <- NEI[(NEI$type=="ON-ROAD") & (NEI$fips=="24510"),]
baltimoreEmissionsvehicleDataGrouped <- summarise(group_by(baltimoreEmissionsvehicleData, year), Emissions=sum(Emissions))

# plot
png("plot5.png", width=480, height=480)

ggplot(data=baltimoreEmissionsvehicleDataGrouped, aes(x=year, y=Emissions, label=Emissions)) + 
  geom_bar(stat="identity", fill = "#FF6666") +
  ggtitle("Sum of PM2.5 Emissions of vehicle in Baltimore") + 
  labs(x = "Year", y = "PM2.5 Emissions of vehicle") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_y_continuous(breaks=seq(0, 400, by=100), limits=c(0, 400)) 
dev.off()

# Answer to Q5: From 1999 to 2008, the motor vehicles Emissions in Baltimore have decreased by 258.5 ton