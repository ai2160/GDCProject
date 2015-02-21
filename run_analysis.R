#File to run analysis on Human Activity Recoginition data

#requires plyr package
library(plyr)

###Read the features.txt file to get column names of merged table

features <- read.table("UCI HAR Dataset\\features.txt", header = FALSE, stringsAsFactors = FALSE)
#Extract Column names
features <- features$V2
#add subject_id and activity
features <- c("subject_id", features, "activity")

###


###Read Activity labels file

activity_labels <- read.table("UCI HAR Dataset\\activity_labels.txt", header = FALSE, stringsAsFactors = FALSE)
#Extract activity names
activity_labels <- activity_labels$V2

###

###read training data

training_data <- read.table("UCI HAR Dataset\\train\\X_train.txt", header = FALSE)
training_subjects <- read.table("UCI HAR Dataset\\train\\subject_train.txt", header = FALSE)
training_activity <- read.table("UCI HAR Dataset\\train\\y_train.txt", header = FALSE)
#Generate activity labels instead of numbers
training_labels <- activity_labels[training_activity[,1]]
training_table <- cbind(training_subjects, training_data, training_labels)
#name columns
colnames(training_table) <- features

###

###read test data

test_data <- read.table("UCI HAR Dataset\\test\\X_test.txt", header = FALSE)
test_subjects <- read.table("UCI HAR Dataset\\test\\subject_test.txt", header = FALSE)
test_activity <- read.table("UCI HAR Dataset\\test\\y_test.txt", header = FALSE)
#Generate activity labels instead of numbers
test_labels <- activity_labels[test_activity[,1]]
test_table <- cbind(test_subjects, test_data, test_labels)
#name columns
colnames(test_table) <- features

###

#merge both data sets
complete_data <- rbind(training_table, test_table)
colnames(complete_data) <- features

#Let us get all columns with mean and standard deviation
#columns with mean() and std() in them
required_columns <- c(1,grep(".*mean\\(\\).*",colnames(complete_data)), grep(".*std\\(\\).*",colnames(complete_data)), 563)
required_data <- complete_data[,required_columns]


###Let us create a new tidy data set

#Split by subject and activity, calculate mean on other columns
result <- ddply(required_data, .(subject_id, activity), colwise(mean))
#Give good names to columns
new_names = paste("AVG", colnames(result))
new_names[1] = 'subject'
new_names[2] = 'activity'
colnames(result) <- new_names

###
###RESULT is saved in variable 'result'
###
