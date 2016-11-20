===General information
In this script, I made couple of changes so that you can specify the actual location of training data set and testing data set, but for convinient, you might want to unzip the data just under the current working directory.

===read_data
read_data function is a shared function that load the data from local disk files, the parameters are as following:

read_data <- function(dirName, fileName)

===Merges the training and the test sets to create one data set.

merge_train_test <- function(trainDir = trainPath, testDir = testPath)

mergedDataset <- merge_train_test()

===Extracts only the measurements on the mean and standard deviation for each measurement.

extract_mean_std_measurements <- function(activityDataSet, featureDir = featurePath)

For example:

meanStdMeasurements <- extract_mean_std_measurements(mergedDataset)

===Uses descriptive activity names to name the activities in the data set

apply_activity_names <- function(activityDataset, trainDir = trainPath, testDir = testPath, activityDir = featurePath)

For example:

mergedDatasetWithAcitivyNames <- apply_activity_names(mergedDataset)

===Appropriately labels the data set with descriptive variable names. 

label_data_set <- function(activityDataset, featureDir = featurePath)

For example:

mergedDatasetWithAcitivyNamesAndLabels <- label_data_set(mergedDatasetWithAcitivyNames)


===From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

create_avg_tidy_set <- function(activityDataset, trainDir = trainPath, testDir = testPath, subjectDir = featurePath)

For example:

tidyAvgDataset <- create_avg_tidy_set(mergedDatasetWithAcitivyNamesAndLabels)


===Write tidy dataset to local disk
write.table(tidyAvgDataset, file = "tidyDataset", row.name=FALSE)

