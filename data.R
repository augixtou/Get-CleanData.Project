#import the library
library(data.table)
library(dplyr)

# set the work dir and download the file 
setwd("~")
dir.create("data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "~/data.zip", method = "curl")
# unzip the file and set the work directory
setwd("~/UCI HAR Dataset/")
filelist <- list.files(recursive = TRUE, full.names = TRUE)
filelist

#read  test data, train data, feature names, activity_labels, activityID and subjectID. 
testData <- read.table("test/X_test.txt")
trainData <- read.table("train/X_train.txt")
featureNames <- read.table("features.txt")
testActivityID <- read.table("test/y_test.txt")
trainActivityID <- read.table("train/y_train.txt")
testSubjectID <- read.table("test/subject_test.txt")
trainSubjectID <- read.table("train/subject_train.txt")
activityLables <- read.table("activity_labels.txt")

#join two dateset byrow.
dataSet <- rbindlist(list(testData, trainData))
dim(dataSet) # 10299   561

#set the data names with feature names.
setnames(dataSet, as.character(featureNames[,2]))
a<-head(dataSet,3)

#subset the dataset for mean and std.
dataSet.MeanAndStd <- select(dataSet, contains("mean()"), contains("std()"))
dim(dataSet.MeanAndStd) #10299    66
#removing the excessive brackets in the column names.
columnName <- colnames(dataSet.MeanAndStd)
columnName <- gsub("\\()","",columnName)
setnames(dataSet.MeanAndStd, columnName)

#add the activity label and subjectID.
subjectID <- rbind(testSubjectID, trainSubjectID)
dataSet.MeanAndStd$subjectID <- subjectID
activityID <- rbind(testActivityID, trainActivityID)
dataSet.MeanAndStd$activityID <- activityID

#replace the activityID with their pesepctive labels.
setnames(activityLables,c("activityID","activityLabel"))
dt <- merge(dataSet.MeanAndStd, activityLables, by = "activityID")
dim(dt)
#reset the column order
setcolorder(dt, c((length(dt)-1),1,length(dt),(2:(length(dt)-2))))
#remove the activity ID
dt[, activityID:= NULL]
head(dt[, 1:4, with = FALSE],3)
#set key 
setkey(dt, subjectID,activityLabel)
columnlist <- names(dt)[3:length(dt)]
dt.tidy <- dt[, lapply(.SD,mean),  by = list(subjectID, activityLabel) ]
dim(dt.tidy)
