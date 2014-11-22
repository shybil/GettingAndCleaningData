Getting and Cleaning Data: Course Project


Summary

I created a directory that will be used as the master directory for github.
This directory contains the run_analysis.R file.
In R, use the setwd() to this directory.

I manually downloaded the data and unzipped the files into the subdirectory "UCI HAR Dataset"
and will reference this subdirectory when accessing data in the run_analysis.R file.

Programmatically, I could have used the following in my code(but curl gave me problems due to a system issue i had)

url='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip' 
download.file(url,destfile='projectdata.zip',method='curl') 
unzip('project data.zip') 

The R Script program

The R script, run_analysis.R, is broken into documented section that follow the project instructions: 
	1.Merges the training and the test sets to create one data set.

	2.Extracts only the measurements on the mean and standard deviation for each measurement. 

	3.Uses descriptive activity names to name the activities in the data set

	4.Appropriately labels the data set with descriptive variable names. 

	5.From the data set in step 4, creates an independent tidy data set with the average of each variable for each activity and each subject.


Data Files Used

The below files, listed in their respective Step order are placed in the directory UCI HAR Dataset.
These files are referenced in the R script, run_analysis.R, program:

# Step 1
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample.
- 'train/X_train.txt': Training set.A 561-feature vector with time and frequency domain variables
- 'train/y_train.txt': Training labels.

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample.
- 'test/X_test.txt': Test set. A 561-feature vector with time and frequency domain variables
- 'test/y_test.txt': Test labels.

# Step 2
- 'features.txt': List of all features.

# Step 3
- 'activity_labels.txt': Links the class labels with their activity name.




