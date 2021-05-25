## run_analysis.R
## Author: Eric Wilson
## Date Created: 23 May 2021

X_train = read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
y_train = read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
