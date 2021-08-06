rm(list = ls())

##install library
install.packages("reshape2")
install.packages("dplyr")
library(reshape2)
library(dplyr)


## define directory 
setwd("C:/Coursera/GettingData")

#Get data(data> UCI HAR Dataset)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

#unzip data in the folder (data> UCI HAR Dataset)
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#define the path
p_rf <- file.path("./data" , "UCI HAR Dataset")
f<-list.files(p_rf, recursive=TRUE)
f


#Read the data from the files
dActivityTest  <- read.table(file.path(p_rf, "test" , "Y_test.txt" ),header = FALSE)
dActivityTrain <- read.table(file.path(p_rf, "train", "Y_train.txt"),header = FALSE)

dSubjectTrain <- read.table(file.path(p_rf, "train", "subject_train.txt"),header = FALSE)
dSubjectTest  <- read.table(file.path(p_rf, "test" , "subject_test.txt"),header = FALSE)

dFeaturesTest  <- read.table(file.path(p_rf, "test" , "X_test.txt" ),header = FALSE)
dFeaturesTrain <- read.table(file.path(p_rf, "train", "X_train.txt"),header = FALSE)


##Check the properties of the variable 
str(dActivityTest)
str(dActivityTrain)
str(dSubjectTest)
str(dSubjectTrain)
str(dFeaturesTest)
str(dFeaturesTrain)


#Merges the training and the test sets to create one data set
dSubject <- rbind(dSubjectTrain, dSubjectTest)
dActivity<- rbind(dActivityTrain, dActivityTest)
dFeatures<- rbind(dFeaturesTrain, dFeaturesTest)

# Tidy the variable name
names(dSubject)<-c("subject")
names(dActivity)<- c("activity")

# read the feature.txt 
dFeaturesNames <- read.table(file.path(p_rf, "features.txt"),head=FALSE)
names(dFeatures)<- dFeaturesNames$V2

# Merge the data set
dCombine <- cbind(dSubject, dActivity)
D <- cbind(dFeatures, dCombine)

# Calculate the mean and standard deviation 
subdFeaturesNames<-dFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dFeaturesNames$V2)]

# Add the "subject", "activity" with the subdFeaturesNames
selectedNames<-c(as.character(subdFeaturesNames), "subject", "activity" )

# Create again data set base on the selectedNames
D<-subset(D,select=selectedNames)
str(D)

#Uses descriptive activity names to name of the activities in the data set
activityLabels <- read.table(file.path(p_rf, "activity_labels.txt"),header = FALSE)
head(D$activity,30)


#Appropriately labels the data set with descriptive variable names
names(D)<-gsub("^t", "time", names(D))
names(D)<-gsub("^f", "frequency", names(D))
names(D)<-gsub("Acc", "Accelerometer", names(D))
names(D)<-gsub("Gyro", "Gyroscope", names(D))
names(D)<-gsub("Mag", "Magnitude", names(D))
names(D)<-gsub("BodyBody", "Body", names(D))
names(D)


#Creates a second,independent tidy data set and it output
library(plyr);
D2<-aggregate(. ~subject + activity, D, mean)
D2<-D2[order(D2$subject,D2$activity),]
write.table(D2, file = "tidydataset.txt",row.name=FALSE)


