#########################################################################
## This R code is for coursera Getting and Cleaning Data course project.
## Please put it in the main directory of the dataset, that is, 
## you should place it with the file features.txt, activity_labels.txt, etc.
#########################################################################

#########################################################################
## by Scartle Roy, 2014.7.16
#########################################################################


library(zoo)
library(plyr)
library(reshape2)

# Read the txt files

# Read the features
feature <- read.table("features.txt")

# Read the activity names
activity <- read.table("activity_labels.txt")

# Find out the measurements about mean and std
select_id <- grep("mean\\(\\)|std\\(\\)", feature$V2)
select_feature <- feature[feature$V1 %in% select_id,]

# Read the test files
test_data <- read.table("test/X_test.txt")
test_activity <- read.table("test/y_test.txt")
test_subject <- read.table("test/subject_test.txt")

# Select the measurements above from test data
test_data_select <- test_data[,select_id]

# Do the same with training files
train_data <- read.table("train/X_train.txt")
train_activity <- read.table("train/y_train.txt")
train_subject <- read.table("train/subject_train.txt")

train_data_select <- train_data[,select_id]

# Merge the test set and the train set

total_data <- rbind(test_data_select, train_data_select)
total_activity <- rbind(test_activity, train_activity)
total_subject <- rbind(test_subject, train_subject)


# Delect useless variables
rm(feature)
rm(select_id)
rm(test_data)
rm(test_activity)
rm(test_subject)
rm(test_data_select)
rm(train_data)
rm(train_activity)
rm(train_subject)
rm(train_data_select)

# Convert activity numbers into names
act_names <- activity$V2
total_activity <- total_activity$V1
total_activity_name <- NULL
for(cnt in seq_along(total_activity)) {
  total_activity_name[cnt] <- as.character(act_names[total_activity[cnt]])
}

# Merge all those features
total_data <- cbind(total_data, total_activity_name, total_subject)
rm(total_activity)
rm(total_activity_name)
rm(total_subject)

# Set the column names
measure_names <- as.character(select_feature$V2)
col_name <- c(measure_names, "activity", "subject")
colnames(total_data) <- col_name
rm(select_feature)

# Get the mean of the variables group by activity
activity_group <- melt(total_data, id = "activity")
activity_mean <- dcast(activity_group, activity ~ variable, mean)
activity_mean <- activity_mean[,-length(activity_mean)]

# Get the mean of the variables group by subject
subject_group <- melt(total_data, id = c("activity", "subject"))
subject_mean <- dcast(subject_group, subject ~ variable, mean)

# Change a colomn's name and class in order to merge the two data frames
colnames(subject_mean)[1] <- "activity"
subject_mean$activity <-as.character(subject_mean$activity)

# Merge the two data frames
tidy_data <- rbind(activity_mean, subject_mean)
colnames(tidy_data)[1] <- "activity&subject"

# Save the new tidy dataset
write.table(tidy_data, file = "tidy_dataset.txt")