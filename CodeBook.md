Getting and Cleaning Data: Course Project

#Code book 

This document provides information about the generated sets by the script  run_analysis.R , provided in this repository.

# 1. Merge the training and the test sets to create one data set.

Read in the data with the read.table command.

subject_train and subject_test represent the subjects that performed the activity

y_train  contains the training labels
X_train  contains the data using the feature vector with time and frequency domain variables

y_test  contains the test labels
X_test  contains the data using the feature vector with time and frequency domain variables

The features vector reads in a assigned integer id and feature name representing
signals used to estimate a set of variables for each pattern. 
Each feature in the data set was assigned X, Y and Z directions to denote 3-axial signals

The activity_labels reads in an assigned integer id and activity name. 
Used to link the class labels with their activity name:

	1 WALKING

	2 WALKING_UPSTAIRS
	3 WALKING_DOWNSTAIRS

	4 SITTING

	5 STANDING

	6 LAYING


Assign numeric row numbers to the train and test sets for the merge command
Merge the resulting trainMerge and testMerge sets into one dsStep1

# 2. Extract only the measurements on the mean and standard deviation for each measurement.

Used grepl to extract only the mean and std features estimates.

# 3. Use descriptive activity names to name the activities in the data set.

Assign the activity label with the activity id associated with the row

# 4. Appropriately label the data set with descriptive activity names.

Remove () Replace - with . from the features
Skip the first 3 columns and replace the column names from V... to the Features label

# 5. From the data set in step 4, creates an independent tidy data set with the average of each variable for each activity and each subject.

Remove extra columns
Add in the activity label
use the write.table to create the resulting projectTidy.txt tidy file

