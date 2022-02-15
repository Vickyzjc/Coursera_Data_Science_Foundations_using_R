# Before running the following code
# need to install the three packages: ggplot2, dplyr, Hmisc
# and also set work space to a folder which contains this file and data file: "activity.csv"

library(ggplot2)
library(dplyr)
library(Hmisc)

activityData <- read.csv("activity.csv")

# Preprocessing the data
cleanedData <- na.omit(activityData)
cleanedData$date <- as.Date(cleanedData$date)

# aggregate by a day
stepsEachDay <- aggregate(steps ~ date, cleanedData, sum)

# Plot statistic of steps
png("histogramOfEachDay.png", width=480, height=480)
ggplot(stepsEachDay, aes(x = steps)) +
  geom_histogram(binwidth = 700, fill = "orange") +
  ggtitle("Steps Statistic") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Steps", y = "Frequency")
dev.off()

# calculate mean and median:
print("The mean value of frequency of steps per day: ") # 10766.19
print(mean(stepsEachDay$steps))
print("The median value of frequency of steps per day: ") # 10765
print(median(stepsEachDay$steps))

# aggregate by interval
stepsByInterval <- aggregate(steps ~ interval, cleanedData, mean)

# plot time series plot of the average number of steps taken
png("timeSeriesOfAverageStepsByInterval.png", width=480, height=480)
ggplot(stepsByInterval, aes(x=interval, y=steps)) + 
  geom_line(color = "blue") +
  ggtitle("Time Series Plot of The Average Number of steps By Interval") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Interval", y = "Average Number of steps")
  
dev.off()
print("The 5-minute interval that, on average, contains the maximum number of steps: ")
print(stepsByInterval$interval[which.max(stepsByInterval$steps)])

# Calculate the number of NA
print("The number of NA: ")
print(sum(is.na(activityData)))

# use Package named: Hmisc 
# to add mean of eliminating NA to fill the NA value

prepareFilledNAData <- activityData
prepareFilledNAData$steps <- impute(activityData$steps, fun=mean)

stepsEachDayWithFilledNA <- aggregate(steps ~ date, prepareFilledNAData, sum)

# plot statistic of filled NA
png("histogramOfEachDayWithFilledNA.png", width=480, height=480)
ggplot(stepsEachDayWithFilledNA, aes(x = steps)) +
  geom_histogram(binwidth = 700, fill = "orange") +
  ggtitle("Steps Statistic with filled NA by Mean") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Steps", y = "Frequency")
dev.off()

# calculate mean and median:
print("After filling the NA, the mean value of frequency of steps per day: ") # 10766.19
print(mean(stepsEachDay$steps))
print("After filling the NA, the median value of frequency of steps per day: ") # 10765
print(median(stepsEachDay$steps))

# Preprocessing the date:
prepareFilledNAData$date <- as.Date(prepareFilledNAData$date)
prepareFilledNAData$weekday <- weekdays(prepareFilledNAData$date)

prepareFilledNAData$dayType[prepareFilledNAData$weekday %in% c('Monday','Tuesday', 'Wednesday', 'Thursday', 'Friday')] <- "Weekday"
prepareFilledNAData$dayType[prepareFilledNAData$weekday %in% c('Saturday','Sunday')] <- "Weekend"

prepareFilledNAData$dayType <- as.factor(prepareFilledNAData$dayType)


# aggregate by interval for weekday and weekend
prepareFilledNADataByInterval <- aggregate(steps ~ interval + dayType, data=prepareFilledNAData, mean)

# plot
png("timeSeriesOfAverageStepsByIntervalAccrossWeekdaysAndWeekends.png", width=480, height=480)
ggplot(prepareFilledNADataByInterval , aes(x = interval , y = steps, color=dayType)) + 
  geom_line() + 
  facet_wrap(~dayType, ncol = 1, nrow=2) + 
  ggtitle("Average Number of steps By Interval Accross Weekdays & Weekends") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = "Interval", y = "Average Number of steps")
dev.off()

