# Script to create a tidy dataset from the UCI HAR Dataset (zipfile: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
# More info about the data available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Subject train and test files are combined. Same for X_train with X_test, and y_train with y_test
# From X_train only mean and sd values are kept.
# Dataset is then summarized by subject by activity.

library(dplyr)

# Read in subjects
subject_train = read.table('train/subject_train.txt', header = FALSE, col.names = "subject_id")
subject_test = read.table('test/subject_test.txt', header = FALSE, col.names = "subject_id")

# Bind train and test set, and change name of column
subject = rbind(subject_train, subject_test)

# Read in X and y.
X_train = read.table('train/X_train.txt', header = FALSE)
X_test = read.table('test/X_test.txt', header = FALSE)
y_train = read.table('train/y_train.txt', header = FALSE)
y_test = read.table('test/y_test.txt', header = FALSE)

# Read in features.txt. Use a regular expression to find features with mean or std 
# (column 2 of dataframe 'features'), and get their number (column 1).
features = read.table('features.txt', header = FALSE, colClasses = c("numeric", "character"))
features_to_keep = features[grep("mean|std", features$V2),]
# Remove meanFreq
meanFreq = features_to_keep[grep("meanFreq", features_to_keep$V2),] 
mean_sd_features = setdiff(features_to_keep, meanFreq)

# Tidy up variable names
mean_sd_features$V2 = gsub("^t", "time", mean_sd_features$V2) 
mean_sd_features$V2 = gsub("^f", "freq", mean_sd_features$V2)
mean_sd_features$V2 = gsub("BodyBody", "Body", mean_sd_features$V2)
mean_sd_features$V2 = gsub("[()]", "", mean_sd_features$V2)

# Subset X_train/test to only keep mean/sd features. Change column names
X_train = X_train[,mean_sd_features[,1]]
X_test = X_test[,mean_sd_features[,1]]
X_total = rbind(X_train, X_test)
colnames(X_total) = mean_sd_features[,2]

# Bind y
y_total = rbind(y_train, y_test)

# Change numeric labels to text descriptions
activities = c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")
for (i in seq_along(activities)) {
  y_total[y_total[,1] == i,2] = activities[i]
}

# Merge subjects, y_total and X_total into one dataframe
dataFrame = cbind(subject, activity = y_total[,2], X_total)

# Group dataset by subject_id and activity
dataFrame_grouped = group_by(dataFrame, subject_id, activity)

# Summarize data
dataFrame_summarized = summarise_each(dataFrame_grouped, funs(mean))

# Write data to file
write.table(dataFrame_summarized, file = 'tidyDataset_UCI_HAR.txt', sep = '\t', row.names = FALSE)
