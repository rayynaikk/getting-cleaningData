### 1- Getting the data and uploading the right packages
# Downloading the files only if they haven't been yet.

path <- getwd()
if (!file.exists(file.path(path, "dataset.zip"))){
      url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(url, file.path(path,"dataset.zip"))
      unzip(zipfile="dataset.zip")
} 
library(data.table)
library(reshape2)
library(dplyr)

### 2- Getting the index of the variables

activity_labels <- fread(file.path(path,"UCI HAR Dataset/activity_labels.txt"))
features <- fread(file.path(path,"UCI HAR Dataset/features.txt"))

### 3-Loading the train and test data sets
subject_test <- fread("UCI\ HAR\ Dataset/test/subject_test.txt")
x_test <- fread("UCI\ HAR\ Dataset/test/X_test.txt")
y_test <- fread("UCI\ HAR\ Dataset/test/y_test.txt")
subject_test <- fread("UCI\ HAR\ Dataset/test/subject_test.txt")

subject_train <- fread("UCI\ HAR\ Dataset/train/subject_train.txt")
x_train <- fread("UCI\ HAR\ Dataset/train/X_train.txt")
y_train <- fread("UCI\ HAR\ Dataset/train/y_train.txt")
subject_train <- fread("UCI\ HAR\ Dataset/train/subject_train.txt")

### 4-Merging the datasets and selecting means and standard deviation features
#we also tidy up by removing the parentheses in the feature names.
index<- grep("([Mm]ean|[Ss]td)",features$V2)
features$V2 <- gsub("[()]", "", features$V2)
x_test<-select(x_test,index)
x_train<-select(x_train,index)
x_test<-cbind(subject_test,y_test,x_test)
x_train<-cbind(subject_train,y_train,x_train)
names(x_test)<-c("subject","activity",features$V2[index])
names(x_train)<-c("subject","activity",features$V2[index])
x<-rbind(x_test,x_train)

### 5- changing the activities into names
#we take the name of the activities in activity_labels and switch the numbers in x$activity
#by these strings.
x$activity<-sapply(x$activity, function(x) activity_labels$V2[x])

### 6- melting the activities with the subject in order to get the mean
#of every variable
y<-melt(x, id=c("activity","subject"))
y<-dcast(y,subject+activity~variable,fun.aggregate=mean)


fwrite(y, file = "tidyData.txt", quote = FALSE)

