########################################## 
# 1. Merge the training and the 
#    test sets to create one data set.
########################################## 
# read training data
X_train = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE) 
X_train[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE, col.names=c("activityId")) 
X_train[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE, col.names=c("subjectId")) 

# read test data 
X_test = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE) 
X_test[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE, col.names=c("activityId")) 
X_test[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE, col.names=c("subjectId")) 

# read features and standardize the two feature names 
features = read.table("UCI HAR Dataset/features.txt", col.names=c("featureId", "featureLabel"),)
features$featureLabel = gsub('-mean', '-Mean', features$featureLabel) 
features$featureLabel = gsub('-std', '-Std', features$featureLabel) 

# read activity
activity_labels = read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activityId", "activityLabel"),) 
#
# assign row numbers as the values of ID column 
X_train$ID <- as.numeric(rownames(X_train)) 
X_test$ID <- as.numeric(rownames(X_test)) 
#
#   
# End result combine train and test 
dsStep1 <- rbind(X_train, X_test) 
#
########################################## 
# 2. Extract only the measurements on the 
#    mean and standard deviation for each measurement.
##########################################
#
selected_features <- features[grepl("Mean\\(\\)", features$featureLabel) | grepl("Std\\(\\)", features$featureLabel), ] 
dsStep1 <- dsStep1[,c(selected_features$featureId,c(562:564))] 
#
########################################## 
# 3. Appropriately label the data set 
#    with descriptive activity names.
########################################## 
selected_features$featureLabel = gsub("\\(\\)", "", selected_features$featureLabel) 
selected_features$featureLabel = gsub("-", ".", selected_features$featureLabel) 

for (i in 1:length(selected_features$featureLabel)) { 
        colnames(dsStep1)[i] <- selected_features$featureLabel[i] 
} 
##########################################  
# 4. From the data set in step 4, creates an independent tidy data set 
#    with the average of each variable for each activity and each subject.
########################################## 
removal <- c("ID")
dsStep1 <- dsStep1[,!(names(dsStep1) %in% removal)] 
tidydata <-aggregate(dsStep1, by=list(subject = dsStep1$subjectId, activity = dsStep1$activityId), FUN=mean, na.rm=TRUE) 
removal <- c("subject","activity") 
tidydata <- tidydata[,!(names(tidydata) %in% removal)]
#
##########################################  
# 5. Use descriptive activity names to 
#    name the activities in the data set.
########################################## 
#
tidydata = merge(tidydata, activity_labels) 
#
write.table(tidydata,"projectTidy.txt", row.name=FALSE, sep="\t")