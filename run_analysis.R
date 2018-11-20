## Load libraries neede
# check if reshape2 package is installed
if (!"reshape2" %in% installed.packages()) {
    install.packages("reshape2")
}
library(reshape2)

## Clear Data
rm(list = ls())

## Check if directory exist and create if it doesn't
subfolder <- "./data"
if(!file.exists(subfolder)){
    dir.create(subfolder)
} 


## Download file to folder and unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "DataSet.zip"
destFile <- paste(subfolder, "/", fileName, sep = "")
if(!file.exists(fileName)){
    download.file(fileUrl, destfile = fileName, method = "curl")
    unzip(fileName, exdir = subfolder)
    file.copy(from = fileName, to = "./data/")
    file.remove(fileName)
}


## Read activity labesl and features
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")

## Read Data
dataTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
dataTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
activitiesTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
activitiesTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subjectsTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
subjectsTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

## 4.- Appropriately labels the data set with descriptive variable names.
names(dataTest) <- features$V2
names(dataTrain) <- features$V2
names(subjectsTest) <- "subject"
names(subjectsTrain) <- "subject"
names(activitiesTest) <- "activities"
names(activitiesTrain) <- "activities"


## 1.- Merges the training and the test sets to create one data set
totalData <- rbind(dataTest, dataTrain)
totalSubjects <- rbind(subjectsTest, subjectsTrain)
totalActivities <- rbind(activitiesTest, activitiesTrain)


## 2.- Extracts only the measurements on the mean and standard deviation for each measurement.
featuredCols <- grep("mean()|std()", features[,2])
featData <- totalData[,featuredCols]
allData <- cbind(totalSubjects, totalActivities, featData)


## 3.- Uses descriptive activity names to name the activities in the data set
actGroup <- factor(allData$activities)
levels(actGroup) <- activityLabels[,2]
allData$activities <- actGroup

## 5.- From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject.
allDataMelted <- melt(allData, id.vars =  c("subject", "activities"))
allDataMean <- dcast(allDataMelted, subject + activities ~ variable, mean)

write.table(allDataMean, file = "./tidyTable.txt", sep = ",", row.names = FALSE)
