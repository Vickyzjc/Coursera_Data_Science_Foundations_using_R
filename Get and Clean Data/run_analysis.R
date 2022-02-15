# Before running the following code
# need to set work space to a folder which contains this file and data folder: "UCI HAR Dataset"
library(plyr)

# 1. Merge the training & test dataset to create one data set
# Labels
labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
# features
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
# Train Data
xTrainDataSet <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
yTrainDataSet <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
subjectTrainDataSet <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
# Test Data
xTestDataSet <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
yTestDataset <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
subjectTestDataSet <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
# Add column names before merging the data
# This will be more convenient to create merged data with column names
colnames(xTrainDataSet) <- features[, 2]
colnames(xTestDataSet) <- features[, 2]

colnames(yTrainDataSet) <- "activityID"
colnames(yTestDataset) <- "activityID"

colnames(subjectTrainDataSet) <- "subjectID"
colnames(subjectTestDataSet) <- "subjectID"

colnames(labels) <- c("activityID", "activityType")

# Merge and create one dataset
xDataSet <- rbind(xTrainDataSet, xTestDataSet)
yDataSet <- rbind(yTrainDataSet, yTestDataset)
subjectDataSet <- rbind(subjectTrainDataSet, subjectTestDataSet)
dataSet <- cbind(xDataSet, yDataSet, subjectDataSet)

# 2. Extract only the measurements on the mean and deviation for each measurement
cleanedData <- dataSet %>% select(subjectID, activityID, contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the data set
cleanedData$activityID <- labels[cleanedData$activityID, 2]

# 4. Appropriately labels the data set with descriptive variable names
names(cleanedData) <- gsub("-mean()", "Mean", names(cleanedData), ignore.case = TRUE)
names(cleanedData) <- gsub("-std()", "STD", names(cleanedData), ignore.case = TRUE)
names(cleanedData)<-gsub("tBody", "TimeofBody", names(cleanedData))

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

averageCleanedData <- cleanedData %>%
  group_by(subjectID, activityID) %>%
  summarise_all(funs(mean))

write.table(averageCleanedData, "tidyDataSet.txt", row.name=FALSE)
