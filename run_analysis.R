library(data.table)
library(dplyr)

#import test set
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

#import training set
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

#import activity labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activities) <- c("activityid", "activity")

#import column names
features <- read.table("UCI HAR Dataset/features.txt")

#set column names for data frames
names(x_test) <- features$V2
names(y_test) <- c("activityid")
names(subject_test) <- c("subjectid")

names(x_train) <- features$V2
names(y_train) <- c("activityid")
names(subject_train) <- c("subjectid")

#merge test data
test <- cbind(x_test, y_test, subject_test)
#merge train data
train <- cbind(x_train, y_train, subject_train)

#1.merge test and train data
data = rbind(test, train)

#2.Extract only the measurements on the mean and standard deviation for each measurement. but for 3-5. we also need the activityID and subjectID, so select them as well
columnExtract <- grepl("(mean|std)\\(\\)|activityid|subjectid", names(data))
extract <- data[, columnExtract]

#3.Uses descriptive activity names to name the activities in the data set
#merge activity names to extract
extract2 <- merge(extract, activities, by = "activityid")
#remove activityid
extract2 = subset(extract2, select = -c(activityid))

#4.update names to have descriptive variable names
names(extract2) <- tolower(names(extract2))
names(extract2) <- gsub("\\(\\)", "", names(extract2))
names(extract2) <- gsub("-", "", names(extract2))

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
meanData <- aggregate(extract2, by = list(activity = extract2$activity, subject = extract2$subjectid), mean)
meanData <- aggregate(. ~activity + subjectid, extract2, mean)

write.table(meanData, "meanData.txt", sep="\t", row.names = FALSE)