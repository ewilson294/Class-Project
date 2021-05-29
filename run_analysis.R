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
X_train$Dataset <- rep("Train", length(X_train$V1))

# Read data from /test
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
y_test <- rename(y_test, Activity = V1)
subject_test <- rename(subject_test, Subject = V1)
# Append subject and Activity Data
X_test <- cbind(subject_test, y_test, X_test)
X_test$Dataset <- rep("Test", length(X_test$V1))

# Combine Test and Train data
Full_Data <- rbind(X_train, X_test)

features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <-read.table("UCI HAR Dataset/activity_labels.txt")
mean_locations <- grep(pattern = "mean()", x = features$V2)
std_locations <- grep(pattern = "std()", x = features$V2)

# Extract mean and standard deviation measurements
means_stds <- Full_Data[,c(1, 2, mean_locations+2, std_locations+2, match("Dataset", names(Full_Data)))]

# Extract mean and standard deviation labels
new_labels <- features$V2[c(mean_locations, std_locations)]

# Rename mean and standard deviation variables
means_stds <- rename_with(.data = means_stds, .fn = ~ (names(means_stds)[4:length(means_stds)-1] <- new_labels), .cols = names(means_stds)[4:length(means_stds)-1])

# Replace Activity Number with Descriptive Label
for (activity in 1:length(activity_labels$V1)) {
    for (activity_code in 1:length(means_stds$Activity)){
        if (means_stds$Activity[activity_code] == activity_labels$V1[activity]){
            means_stds$Activity[activity_code] <- activity_labels$V2[activity]
        }
    }
}

# Output means_stds to a .csv file
write.csv(means_stds, "UCI HAR Dataset/Means_and_Standard_Deviations.csv", row.names = FALSE)

## Create second tidy data set with average for each variable for each
## activity and each subject
averages <- data.frame()
for (subject in 1:30) {
    subject_data <- means_stds[means_stds$Subject == subject,]
        for (activity in 1:6){
            subject_data.f <- filter(subject_data, subject_data$Activity == activity_labels[activity,2])
                subject_averages <- colMeans(x = select(subject_data.f,"tBodyAcc-mean()-X":"fBodyBodyGyroJerkMag-std()" ), na.rm = FALSE)
                averages <- rbind(averages, c(subject, activity_labels[activity,2], subject_averages, subject_data$Dataset[1]))
        }
}
colnames(averages) <- names(means_stds)
