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

# ON-ROAD is directly the vehicle in Los Angeles
LAEmissionsvehicleData <- NEI[(NEI$type=="ON-ROAD") & (NEI$fips=="06037"),]
LAEmissionsvehicleDataGrouped <- summarise(group_by(LAEmissionsvehicleData, year), Emissions=sum(Emissions))

# Combine two City Data
baltimoreEmissionsvehicleDataGrouped$City <- "Baltimore"
LAEmissionsvehicleDataGrouped$City <- "Los Angeles"
twoCityData <- rbind(baltimoreEmissionsvehicleDataGrouped, LAEmissionsvehicleDataGrouped)

# plot
png("plot6.png", width=480, height=480)

ggplot(twoCityData, aes(x = year, y = round(Emissions/1000, 2), label=round(Emissions/1000,2), color = City)) +
  geom_bar(stat = "identity") + 
  facet_grid(. ~ City) +
  labs(x = "Year", y = expression('PM'[2.5]*' Emissions in 10^3 Ton')) +
  ggtitle("Compare Vehicle Emissions in Baltimore and Los Angeles") +
  theme(plot.title = element_text(hjust = 0.5))
dev.off()

# Answer to Q6: 
# From 1999 to 2008, the motor vehicles Emissions in Baltimore have decreased by 258.5 ton
# the motor vehicles Emissions in Los Angeles has increased by 163.4 ton

