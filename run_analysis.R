library(data.table)
library(dplyr)

#set the work directory to the downloaded file directory.
setwd("~/UCI HAR Dataset/")

#read  test data, train data, feature names, activity_labels, activityID and subjectID. 
testData <- read.table("./test/X_test.txt")
trainData <- read.table("./train/X_train.txt")
featureNames <- read.table("./features.txt")
testActivityID <- read.table("./test/y_test.txt")
trainActivityID <- read.table("./train/y_train.txt")
testSubjectID <- read.table("./test/subject_test.txt")
trainSubjectID <- read.table("./train/subject_train.txt")
activityLables <- read.table("./activity_labels.txt")

#join two dateset byrow.
dataSet <- rbindlist(list(testData, trainData))
dim(dataSet) # 10299   561

#set the data names with feature names.
setnames(dataSet, as.character(featureNames[,2]))

#subset the dataset for mean and std.
dataSet.MeanAndStd <- select(dataSet, contains("mean()"), contains("std()"))
dim(dataSet.MeanAndStd) #10299    66
#removing the excessive brackets in the column names.
columnName <- colnames(dataSet.MeanAndStd)
columnName <- gsub("\\()", "", columnName)
setnames(dataSet.MeanAndStd, columnName)

#add the activity label and subjectID.
subjectID <- rbind(testSubjectID, trainSubjectID)
dataSet.MeanAndStd$subjectID <- subjectID
activityID <- rbind(testActivityID, trainActivityID)
dataSet.MeanAndStd$activityID <- activityID

#replace the activityID with their pesepctive labels.
setnames(activityLables,c("activityID", "activityLabel"))
dataSet.MeanAndStd.activityLabel <- merge(dataSet.MeanAndStd, activityLables, by = "activityID")
dim(dataSet.MeanAndStd.activityLabel) #10299    69
#reset the column order, subjectID, activitylabel and measurement...
dtlen <- length(dataSet.MeanAndStd.activityLabel)
setcolorder(dataSet.MeanAndStd.activityLabel, c(dtlen-1, 1, dtlen, 2:(dtlen-2)))
#remove the activity ID column
dataSet.MeanAndStd.activityLabel[, activityID:= NULL]
head(dataSet.MeanAndStd.activityLabel,3)

#set key
setkey(dataSet.MeanAndStd.activityLabel, subjectID, activityLabel)
dt.tidy <- dataSet.MeanAndStd.activityLabel[, lapply(.SD,mean), by = list(subjectID, activityLabel)]
dim(dt.tidy) #180 68
write.table(dt.tidy, "averageData.txt", row.names = FALSE)

