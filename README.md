# Getting and Cleaning Data Course Project

**This file describes how run_analysis.R script should be used**

####Directory Setup
* [Download](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) sensor data
* Unzipping the file should create a subdirectory "UCI HAR Dataset"
* Now place run_analysis.R file at the same level as "UCI HAR Dataset"

####Running the script
* Open R console or R studio
* install plyr package if it isn't already installed
* Set the working directory using setwd() to the directory containing run_analysis.R
* Source run_analysis.R using source() function
* When the function returns, global environment has a variable 'result' where the result is stored


####How does the script works
* Extract column names for sensor data and activity labels from files
  * Script reads features.txt file
  * Extracts the column names and saves it for future use
  * Script proceeds to extract activity labels from activity_labels.txt
* Reading data
  * Script reads all data files first training_data, subjects, activity id
  * Script proceeds to create a vector with activity label instead of activity id
  * It then combines the three column wise to create a single data set
  * Columns are named using data extracted from features.txt
  * Script repeats the steps for test data
* Merging data
  * Script uses rbind() to combine test and training data sets into a single data set
  * Extracts index for the columns with names 'mean()' and 'std()' in them
  * subsets the data set to only have columns with these index
* Grouping and aggregating
  * Once a merged data set is created, script proceeds to group them
  * Using dplyr() function, script groups by subject and activity and applies mean function on rest of the columns
  * Saves the result to 'result' variable
