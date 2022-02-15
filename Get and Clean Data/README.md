# Getting_and_Cleaning_Data
This is the repository of Course Project for Getting and Cleaning Data

## File Structure
    .
    ├── run_analysis.R                 # the code file for the clean and analysis of the data
    ├── CodeBook.md                    # Detailed explanation of steps and all variables
    ├── tidyDataSet.txt                # the result tidy data set 
    └── README.md

## Explanation of run_analysis.R
The run_analysis.R is doing the following steps for analysis:
1. Merge the training & test dataset to create one data set
2. Extract only the measurements on the mean and deviation for each measurement
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject