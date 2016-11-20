# shared routine for each function

library(dplyr)

trainPath    <- "UCI\ HAR\ Dataset\\train"
testPath     <- "UCI\ HAR\ Dataset\\test"
featurePath  <- "UCI\ HAR\ Dataset"

read_data <- function(dirName, fileName) {
  fileFullPath <- paste(dirName, fileName, sep = "\\")
  fileContent <- read.table(fileFullPath, header = FALSE)
  fileContent
}

# 1. Merges the training and the test sets to create one data set.

merge_train_test <- function(trainDir = trainPath, testDir = testPath) {
      
      # read train data
      train_X          <- read_data(trainDir, "X_train.txt")
      # read test  data
      test_X           <- read_data(testDir, "X_test.txt")
      # read feature 
      
      # combine train and test data
      combine_X       <- rbind(train_X, test_X)
      combine_X
}

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
extract_mean_std_measurements <- function(activityDataSet, featureDir = featurePath) {
      # read feature 
      features              <- read_data(featureDir, "features.txt")
      mean_std_measurements <- activityDataSet[,grep("(mean\\(\\)|std\\(\\))", features[,2])]
      mean_std_measurements
}

# 3. Uses descriptive activity names to name the activities in the data set
apply_activity_names <- function(activityDataset, trainDir = trainPath, testDir = testPath, activityDir = featurePath) {
      train_y                        <- read_data(trainDir, "y_train.txt")
      test_y                         <- read_data(testDir, "y_test.txt")
      combine_y                      <- rbind(train_y, test_y)
      names(combine_y)               <- "activityID"
      activityDataset$"activityID"   <- combine_y$"activityID"
      activityLabel                  <- read_data(activityDir, "activity_labels.txt")
      names(activityLabel)           <- c("activityID", "activityName")
      activityDataset$"activityName" <- activityLabel$activityName[match(activityDataset$activityID, activityLabel$activityID)]
      activityDataset
}

# 4. Appropriately labels the data set with descriptive variable names. 

label_data_set <- function(activityDataset, featureDir = featurePath) {
      # read feature 
      features                        <- read_data(featureDir, "features.txt")
      # assign col names to data sets
      colnames(activityDataset)[1:561]   <- as.character(features[,2])
      activityDataset
}

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

create_avg_tidy_set <- function(activityDataset, trainDir = trainPath, testDir = testPath, subjectDir = featurePath) {
     train_subject                        <- read_data(trainDir, "subject_train.txt")
     test_subject                         <- read_data(testDir, "subject_test.txt")
     combine_subject                      <- rbind(train_subject, test_subject)
     names(combine_subject)               <- "subjectID"
     activityDataset$"subjectID"          <- combine_subject$"subjectID"
     # names(activityDataset)               <- gsub("(-|\\(|\\)|\\,)","",names(activityDataset))
     # remove dup col names
     activityDataset                      <- activityDataset[, ! duplicated(colnames(activityDataset))]
     activityDatasetGroup                 <- group_by(activityDataset, subjectID, activityName)
     avgTidySet                           <- summarise_each(activityDatasetGroup, funs(mean(., na.rm=TRUE)))
     names(avgTidySet)                    <- gsub("(-|\\(|\\)|\\,)","",names(avgTidySet))
     avgTidySet
}





