# Data_cleaning

Link to description of original data set (Human Activity Recognition Using Smartphones Data Set): 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Link to download the data set:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The dataset will be prepared as follows:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis.R contains the script to perform the above data preparation

The final tiny data set has 180 observations and 81 variables. 
1st var contains types of activity.
2nd var presents the subjects(total: 30 subjects being 30 volunteers)
3rd - end: avarage of mean and standard deviation variables grouped by subject and activity 
