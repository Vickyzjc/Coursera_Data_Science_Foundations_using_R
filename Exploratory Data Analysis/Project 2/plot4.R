# Before running the following code
# need to set work space to a folder which contains this file and data files: 
# "Source_Classification_Code.rds", "summarySCC_PM25.rds"

library(ggplot2)
library(dplyr)
# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# combine SCC and MEI data for coal combustion-related sources
SCCCoalData <- SCC[grep("[Cc]oal",SCC$EI.Sector),]
NEICombineSCCCoal <- NEI[(NEI$SCC %in% SCCCoalData$SCC), ]
coalEmissionsData <- summarise(group_by(NEICombineSCCCoal, year), Emissions=sum(Emissions))

# plot
png("plot4.png", width=480, height=480)

ggplot(data=coalEmissionsData, aes(x=year, y=Emissions/10^2, label=round(Emissions/100,2))) + 
  geom_bar(stat="identity", fill = "#FF6666") +
  ggtitle("Sum of PM2.5 Emissions of Coal Comsumption") +
  labs(x = "Year", y = "PM2.5 Emissions (10^2 Tons)") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_y_continuous(breaks=seq(0, 6000, by=1000), limits=c(0, 6000)) 
dev.off()

# Answer to Q4: The coal combustion emissions has nearly decreased by 228694 tons