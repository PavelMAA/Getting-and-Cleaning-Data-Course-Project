---
title: "CodeBook"
author: "Muha Abdullah Al Pavel"
date: "8/6/2021"
output: html_document
---

##Assignment for Getting and Cleaning Data Course Project

##The original data was transformed by following step

1.Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## R script

Above stem was perform  by the R script "run_analysis.R"


## Variables

1. x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files

2. train data and test data merge to make new datasets to further analysis.

3. features contains the correct names for the new dataset, which are applied to the column names stored 

4. Modifies labels the data set with descriptive variable names

5. Create a new, clean and tidy data set as "tidydataset.txt"
