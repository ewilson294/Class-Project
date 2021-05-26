## run_analysis.R
## Author: Eric Wilson
## Date Created: 23 May 2021
## Required Libraries: dplyr

library(dplyr)

# Read data from /train
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

# Read data from /test
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)

features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <-read.table("UCI HAR Dataset/activity_labels.txt")