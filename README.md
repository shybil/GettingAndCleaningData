Getting and Cleaning Data: Course Project


# Prerequisites

Create a directory(e.g. C:\Master) that will be used as the master directory.
This directory will contain the run_analysis.R file.

Manually download the data and unzipped the files into a subdirectory, named "UCI HAR Dataset", 
under the master directory. 
The run_analysis.R file will reference this subdirectory for data when executed.

Programmatically, you could inject the following into the beginning of the R code.

url='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip' 
download.file(url,destfile='projectdata.zip',method='curl') 
unzip('project data.zip') 

Open up R studio, use the setwd() to your master directory.


# The R Script program

Source the script into R (Open or source command)

The R script, run_analysis.R, is broken into documented section that follow the project instructions:
 
	1.Merges the training and the test sets to create one data set.

	2.Extracts only the measurements on the mean and standard deviation for each measurement. 

	3.Uses descriptive activity names to name the activities in the data set

	4.Appropriately labels the data set with descriptive variable names. 

	5.From the data set in step 4, creates an independent tidy data set with the average of each variable for each activity and each subject.


# Data Files Used

The data files used are placed in the directory UCI HAR Dataset.
These files are referenced in the R script, run_analysis.R, program:
Further description of the files can be found in the codebook.md

# Execution

Run the R script.
The result will be a file created called projectTidy.txt


