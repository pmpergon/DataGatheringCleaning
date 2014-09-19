## Assignement Data Gathering and Cleaning

#load txt data training and test sets:
features_training<-read.table("./UCI HAR Dataset/X_train.txt")
head(features_training)
summary(features_training)
dim(features_training)
featuresTest<-read.delim("./UCI HAR Dataset/X_test.txt")
dim(featuresTtest)

# ??? need to add headers to fetaures_training?? (load features.txt)

# load columns A (subject_train.txt) & B (y_train.txt)
subject_train<-read.table("./UCI HAR Dataset/subject_train.txt")
y_train<-read.table("./UCI HAR Dataset/y_train.txt")

# merge columns A (subject_train.txt) & B (y_train.txt) to features_training => featuresTraining

# merge fetauresTraining to FeaturesTest

# extract columns with"mean" and with "std" only in header

# replace Activity numbers (column B) with activity names

#       Appropriately labels the data set with descriptive variable names.??????????

# Creates a second, independent tidy data set with the average of each variable for each activity and
# each subject. column header : features, row name: activity; values means for each feature/activity

