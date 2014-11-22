########################################## 
# 1. Merge the training and the 
#    test sets to create one data set.
########################################## 
# read training data
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", col.names=c("subject_id")) 
X_train = read.table("UCI HAR Dataset/train/X_train.txt") 
y_train = read.table("UCI HAR Dataset/train/y_train.txt", col.names=c("activity_id"))  
# read test data 
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("subject_id")) 
X_test = read.table("UCI HAR Dataset/test/X_test.txt") 
y_test = read.table("UCI HAR Dataset/test/y_test.txt", col.names=c("activity_id"))
#
# assign row number as the values of ID column 
subject_train$ID <- as.numeric(rownames(subject_train)) 
X_train$ID <- as.numeric(rownames(X_train)) 
y_train$ID <- as.numeric(rownames(y_train)) 
subject_test$ID <- as.numeric(rownames(subject_test)) 
X_test$ID <- as.numeric(rownames(X_test)) 
y_test$ID <- as.numeric(rownames(y_test)) 
#
# merge training data
trainMerge <- merge(subject_train, y_train, all=TRUE) 
trainMerge <- merge(trainMerge, X_train, all=TRUE) 
#
# merge testing data
testMerge <- merge(subject_test, y_test, all=TRUE)  
testMerge <- merge(testMerge, X_test, all=TRUE)  
#   
# End result combine train and test 
dsStep1 <- rbind(trainMerge, testMerge) 

########################################## 
# 2. Extract only the measurements on the 
#    mean and standard deviation for each measurement.
##########################################
features = read.table("UCI HAR Dataset/features.txt", col.names=c("feature_id", "feature_label"),)  
#
selected_features <- features[grepl("mean\\(\\)", features$feature_label) | grepl("std\\(\\)", features$feature_label), ] 
dsStep2 <- dsStep1[, c(c(1, 2, 3), selected_features$feature_id + 3) ] 

##########################################  
# 3. Use descriptive activity names to 
#    name the activities in the data set.
########################################## 
activity_labels = read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activity_id", "activity_label"),)  
dsStep3 = merge(dsStep2, activity_labels) 
########################################## 
# 4. Appropriately label the data set 
#    with descriptive activity names.
########################################## 
selected_features$feature_label = gsub("\\(\\)", "", selected_features$feature_label) 
selected_features$feature_label = gsub("-", ".", selected_features$feature_label) 
for (i in 1:length(selected_features$feature_label)) { 
     colnames(dsStep3)[i + 3] <- selected_features$feature_label[i] 
 } 
 dsStep4 = dsStep3 

##########################################  
# 5. From the data set in step 4, creates an independent tidy data set 
#    with the average of each variable for each activity and each subject.
########################################## 
drops <- c("ID","activity_label") 
dsStep5 <- dsStep4[,!(names(dsStep4) %in% drops)] 
tidydata <-aggregate(dsStep5, by=list(subject = dsStep5$subject_id, activity = dsStep5$activity_id), FUN=mean, na.rm=TRUE) 
drops <- c("subject","activity") 
tidydata <- tidydata[,!(names(tidydata) %in% drops)] 
tidydata = merge(tidydata, activity_labels) 
#
write.table(tidydata,"projectTidy.txt", row.name=FALSE, sep="\t")