# CodeBook for Course Project for Getting and Cleaning Data

## Data
The whole description could be found in this website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data in this project was download from this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Detailed Explanation of Steps and Variables
1. Before running the R file named run_analysis.R, please create a workspace with downloading and unzipping the data through the above second link. The data folder's name is "UCI HAR Dataset". Also, change the work space for R.  
2. Merge the training & test dataset to create one data set
	(1) read the following files: activity_labels.txt, features.txt, X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt, subject_test.txt
		* `labels:` 6 rows, 2 columns, read from activity_labels.txt
		* `features:` 561 rows, 2 columns, read from features.txt
		* `xTrainDataSet:` 7352 rows, 561 columns, read from X_train.txt
		* `yTrainDataSet` 7352 rows, 1 columns, read from y_train.txt
		* `subjectTrainDataSet:` 7352 rows, 1 column, read from subject_train.txt
		* `xTestDataSet:` 2947 rows, 561 columns, read from X_test.txt
		* `yTestDataset:` 2947 rows, 1 columns, read from y_test.txt
		* `subjectTestDataSet:` 2947 rows, 1 column, read from subject_test.txt
	(2) merge all train data
		* `trainDataSet:` 7352 rows, 563 columns
	(3) merge all test data
		* `testDataSet:` 2947 rows, 563 columns
	(4) concatenate the merged train data and merged test data
		* `dataSet:` 10299 rows, 563 columns
3. Extract only the measurements on the mean and deviation for each measurement
	* `cleanedData:` 10299 rows, 88 columns, extract features that only contain "mean" and "std"
4. Uses descriptive activity names to name the activities in the data set
	* combine the `cleanedData`'s column variables with `labels`'s column variables
5. Appropriately labels the data set with descriptive variable names
	* replace some names of features with descriptive variable names
6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
	* `averageCleanedData:` 180 rows, 88 columns, made by taking `cleanedData`'s means of all variables and then grouping by subjectID and activityID (in `averageCleanedData`, "activityID" should be "activityType" in `labels`)
	* The `averageCleanedData` will be exported to the file named "tidyDataSet.txt" 
