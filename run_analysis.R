## Assignement Data Gathering and Cleaning
#load libraries needed
library(dplyr)

#load txt data training and test sets:
#       load training data set first
features_training<-read.table("./X_train.txt")

#       add set's headings
# load features.txt (FEATURES COLUMN HEADINGS)
features_headings<-read.table("./features.txt")
headings<- as.character(features_headings [,2])
colnames(features_training) <- headings

# load columns A (subject_train.txt) & B (y_train.txt) 
#(BASED ON THE STRUCTURE OF THE TEST SET)
subject_train<-read.table("./subject_train.txt")
y_train<-read.table("./y_train.txt")

# merge columns A (subject_train.txt) & B (y_train.txt) 
AB<- cbind(subject_train,y_train)
AB_colnames<-c("subject_code","Activity_Labels")
colnames(AB) <- AB_colnames

#merge AB to features_training => ABfeatures_training
ABfeatures_training<- cbind(AB,features_training)

#load test data set 
#(this set contains headings and subject coed and activity labels columns)
# only the headings for the first to columns need to be changed

features_test<-read.delim("./X_test.txt")
colnames (features_test) [1:2] <- AB_colnames
colnames (features_test) [3:563] <- headings

# merge fetauresTraining to FeaturesTest
data_merged <- rbind(features_test,ABfeatures_training)

# extract columns with"mean" and with "std" only in header
data_select_mean <- select(data_merged, contains ("mean"))
data_select_std <- select(data_merged, contains ("std"))
data_selectAB <- select(data_merged, subject_code,Activity_Labels)
data_select <- cbind(data_selectAB,data_select_mean,data_select_std)

# Step Split, & calculate on data_select using aggregate() on subject_code & Activity_Labels

subject_activity<- aggregate(data_select [,3:88], by=list(data_select$subject_code, data_select$Activity_Labels),mean)
# Rename swapped first two coloumns
colnames(subject_activity) [1:2] <- c("subject_code","Activity_Labels")

# Change Actiity_labels from #code to labels
#               activity_text<-read.table("./activity_labels.txt")
levels_text <- c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
#               levels_numbers <- c(1:6)

subject_activity$Activity_Labels <- cut(subject_activity$Activity_Labels, breaks=6, labels=levels_text)

# upload data set ("subject_activity") as a txt file created with write.table() using row.name=FALSE

write.table(subject_activity,file="./subject_activity_means.txt", row.names= FALSE)