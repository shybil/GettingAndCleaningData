########################################## 
# 1. Merge the training and the 
#    test sets to create one data set.
########################################## 
# read training data
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", col.names=c("subjectId")) 
X_train = read.table("UCI HAR Dataset/train/X_train.txt") 
y_train = read.table("UCI HAR Dataset/train/y_train.txt", col.names=c("activityId"))  
# read test data 
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("subjectId")) 
X_test = read.table("UCI HAR Dataset/test/X_test.txt") 
y_test = read.table("UCI HAR Dataset/test/y_test.txt", col.names=c("activityId"))
# read features
features = read.table("UCI HAR Dataset/features.txt", col.names=c("featureId", "featureLabel"),)  
# read activity
activity_labels = read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activityId", "activityLabel"),) 
#
# assign row numbers as the values of ID column 
subject_train$ID <- as.numeric(rownames(subject_train)) 
X_train$ID <- as.numeric(rownames(X_train)) 
y_train$ID <- as.numeric(rownames(y_train)) 
subject_test$ID <- as.numeric(rownames(subject_test)) 
X_test$ID <- as.numeric(rownames(X_test)) 
y_test$ID <- as.numeric(rownames(y_test)) 
#
# merge train   
trainMerge <- merge(subject_train, y_train, all=TRUE) 
trainMerge <- merge(trainMerge, X_train, all=TRUE) 
#
# merge test   
testMerge <- merge(subject_test, y_test, all=TRUE)  
testMerge <- merge(testMerge, X_test, all=TRUE)  
#   
# End result combine train and test 
dsStep1 <- rbind(trainMerge, testMerge) 
#
########################################## 
# 2. Extract only the measurements on the 
#    mean and standard deviation for each measurement.
##########################################
#
selected_features <- features[grepl("mean\\(\\)", features$featureLabel) | grepl("std\\(\\)", features$featureLabel), ] 
dsStep2 <- dsStep1[, c(c(1, 2, 3), selected_features$featureId + 3) ] 
#
##########################################  
# 3. Use descriptive activity names to 
#    name the activities in the data set.
########################################## 
#
dsStep3 = merge(dsStep2, activity_labels) 
########################################## 
# 4. Appropriately label the data set 
#    with descriptive activity names.
########################################## 
selected_features$featureLabel = gsub("\\(\\)", "", selected_features$featureLabel) 
selected_features$featureLabel = gsub("-", ".", selected_features$featureLabel) 
for (i in 1:length(selected_features$featureLabel)) { 
     colnames(dsStep3)[i + 3] <- selected_features$featureLabel[i] 
 } 
 dsStep4 = dsStep3 

##########################################  
# 5. From the data set in step 4, creates an independent tidy data set 
#    with the average of each variable for each activity and each subject.
########################################## 
removal <- c("ID","activityLabel") 
dsStep5 <- dsStep4[,!(names(dsStep4) %in% removal)] 
tidydata <-aggregate(dsStep5, by=list(subject = dsStep5$subjectId, activity = dsStep5$activityId), FUN=mean, na.rm=TRUE) 
removal <- c("subject","activity") 
tidydata <- tidydata[,!(names(tidydata) %in% removal)] 
tidydata = merge(tidydata, activity_labels) 
#
write.table(tidydata,"projectTidy.txt", row.name=FALSE, sep="\t")