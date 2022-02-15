# Before running the following code
# need to set work space to a folder which contains this file and data files: 
# "Source_Classification_Code.rds", "summarySCC_PM25.rds"

library(ggplot2)
library(dplyr)
# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# select the data for Baltimore and group by type and year firstly
baltimoreEmissionsData <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarise(Emissions=sum(Emissions))

baltimoreEmissionsData$year <- as.factor(baltimoreEmissionsData$year)

# plot
png("plot3.png", width=480, height=480)
ggplot(data=baltimoreEmissionsData, aes(fill = type, x=year, y=Emissions, label = round(Emissions,2))) + 
  geom_bar(stat="identity") +
  facet_wrap(~type) +
  ggtitle("Sum of PM2.5 Emmissions in Baltimore by Year for Each Type") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Year", y = "Emissions of PM2.5")
dev.off()

# Answer to Q3: "point" increased, others decreased