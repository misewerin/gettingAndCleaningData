# Code Book

This code book describes the variables, the data and transformations that were performed to clean up the data

##Data source
The data can be downloaded from [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
A full description of the data is available at this [site] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##Data
The data contains information of the measurements from the accelerometer and gyroscope about different activities performed by 30 volunteers while wearing a smartphone.
The volunteers where split into one group creating the training data (70%) and one group for generating the test data (30%).
For more detailed information please check the README.txt of the downloaded data.

##Data Import
The following files were imported:
###Test data
* UCI HAR Dataset/test/X_test.txt was imported into data frame x_test. This contains a test set
* UCI HAR Dataset/test/y_test.txt -> y_test : test labels
* UCI HAR Dataset/test/subject_test.txt -> subject_test: each row identifies the subject who performed the activity

###Training data
* UCI HAR Dataset/train/X_test.txt was imported into data frame x_train. This contains a training set
* UCI HAR Dataset/train/y_test.txt -> y_train : train labels
* UCI HAR Dataset/train/subject_train.txt -> subject_train: each row identifies the subject who performed the activity

###other data
* UCI HAR Dataset/activity_labels.txt -> activities : Links the class labels with their activity name
* UCI HAR Dataset/features.txt -> features : List of all features

##Transformations
First column names were defind for all data frames.
For activities the column names are "activityid" and "activity".
For y_test and y_train the column name was set to "activityid".
For subject_test and subject_train the column name was set to "subject".
The column names for x_test and x_train were obtained from the second column of the features data frame.

As a next step a data frame (named test) was created by combining x_test, y_test and subject test. Same thing was done for the training data.
After this the train and test data were merged to data.

Then this data was reduced to only the columns containing mean and standard deviation and the information about subject and activityid (data frame extract)
To this data frame the activity names were joined and the activityid was removed resulting in the data frame extract2.

After that the variable names were set to have descriptive well formatted names.

From this data teh data frame meanData was created with the average of each variable for each activity and each subject.
