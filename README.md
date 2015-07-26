# Project for Getting and Cleaning Data

This repo is for the peer assignment. 

## How to use the `run_analysis.R` file:

1. Two R packages are required: “data.table” and “dplyr”. Please install these two packages if you have not.
   
   `install.packages("data.table")`
   
   `install.packages("dplyr")`
   
2. Download and unzip the data file at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
   
3. Set your R working directory to the data file. (i.e., “`~/UCI HAR Dataset/`“).
   
4. Run the R script `run_analysis.R`,  which will produce the result file “averageData.txt".

## Date processes steps:

1. read the test data, train data, feature names, activity_labels, activityID and subjectID into R using `read.table`. ( I used to prefer `freed` function, which is much faster. However, a bug occurred.)
2. join the train and test data set together using the `rbindlist`.
3. set the column names appropriate using the information from features.txt file.
4. subset the data with only the mean and standard deviation data using the `select` function.  
5. the numeric labels for activities were substituted with descriptive names using `merge` .
6. set the activity labels and subjectID as keys, and calculate the mean for each column by the keys.
7. export the tidy data as "averageData.txt"

##### Detail about this project.

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
> 
> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
> 
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
> 
> Here are the data for the project: 
> 
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
> 
>  You should create one R script called run_analysis.R that does the following. 
> 
> Merges the training and the test sets to create one data set.
> 
> Extracts only the measurements on the mean and standard deviation for each measurement. 
> 
> Uses descriptive activity names to name the activities in the data set
> 
> Appropriately labels the data set with descriptive variable names. 
> 
> From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
> 
> Good luck!