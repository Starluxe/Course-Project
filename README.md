# Getting and Cleaning Data Peer-graded Assignment
# ReadMe

This repository contains the files belonging to the final peer-graded assignment of the Course "Getting and Cleaning Data" (https://www.coursera.org/learn/data-cleaning/home/welcome).

* CodeBook.md  
This file describes the original data set and the transformations applied to fulfill the assignment, ending in the generation of the file tidy_dataset.txt.

* run_analysis.R  
Script used to transform the original UCI data set (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into the final tidy data set, as per the assignment instructions.  
Other than the comments in the file itself, the steps are explained in CodeBook.md.

* tidy_dataset.txt  
File containing the final tidy dataset, generated by run_analysis.R through

       allDataMelted <- melt(allData, id.vars =  c("subject", "activities"))
       allDataMean <- dcast(allDataMelted, subject + activities ~ variable, mean)

        write.table(allDataMean, file = "./tidyTable.txt", sep = ",", row.names = FALSE)

* README.md  
This file.
