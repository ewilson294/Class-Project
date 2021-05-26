## run_analysis.R
## Author: Eric Wilson
## Date Created: 23 May 2021
## Required Libraries: dplyr

library(dplyr)

# Read data from /train
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
y_train <- rename(y_train, Activity = V1)
subject_train <- rename(subject_train, Subject = V1)
# Append Subject and Activity Data
X_train <- cbind(subject_train, y_train, X_train)

# Read data from /test
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
y_test <- rename(y_test, Activity = V1)
subject_test <- rename(subject_test, Subject = V1)
# Append subject and Activity Data
X_train <- cbind(subject_test, y_test, X_test)

# Combine Test and Train data


features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <-read.table("UCI HAR Dataset/activity_labels.txt")
mean_locations <- grep(pattern = "mean()", x = features$V2)
std_locations <- grep(pattern = "std()", x = features$V2)