DataGatheringCleaning
=====================

Read.me  : Process journal						
						
1	## Assignement Data Gathering and Cleaning					
2	# DATA STRUCTURE ANALYSI:					
3	# download data sets in order to becoming familiar with their structure					
4						features_test<-read.delim("./UCI HAR Dataset/X_test.txt")
5						features_training<-read.table("./UCI HAR Dataset/X_train.txt")
6						features_headings<-read.table("./UCI HAR Dataset/features.txt")
7						subject_train<-read.table("./UCI HAR Dataset/subject_train.txt")
8						y_train<-read.table("./UCI HAR Dataset/y_train.txt")
9	# USE OF THE FOLLOWING FUNCTIONS TO FIND OUT THEIR STRUCTURE					
10	#       head(DF,n=3L)					
11	#       summary(DF)					
12	#       dim(DF)					
13	# Clean data space for PROCESS					
14						rm(list=ls())
						
1	## PROCESS 					
2	#load libraries needed					
3						library(dplyr)
4						
5	#load txt data training and test sets:					
6	#       load training data set first					
7						features_training<-read.table("./UCI HAR Dataset/X_train.txt")
8						
9	#       add set's headings					
10	# load features.txt (FEATURES COLUMN HEADINGS)					
11						features_headings<-read.table("./UCI HAR Dataset/features.txt")
12						headings<- as.character(features_headings [,2])
13						colnames(features_training) <- headings
14						
15	# load columns A (subject_train.txt) & B (y_train.txt) 					
16	#(BASED ON THE STRUCTURE OF THE TEST SET)					
17						subject_train<-read.table("./UCI HAR Dataset/subject_train.txt")
18						y_train<-read.table("./UCI HAR Dataset/y_train.txt")
19						
20	# merge columns A (subject_train.txt) & B (y_train.txt) 					
21						AB<- cbind(subject_train,y_train)
22						AB_colnames<-c("subject_code","Activity_Labels")
23						colnames(AB) <- AB_colnames
24						
25	#merge AB to features_training => ABfeatures_training					
26						ABfeatures_training<- cbind(AB,features_training)
27						
28	#load test data set 					
29	#(this set contains headings and subject coed and activity labels columns)					
30	# only the headings for the first to columns need to be changed					
31						features_test<-read.delim("./UCI HAR Dataset/X_test.txt")
32						colnames (features_test) [1:2] <- AB_colnames
33						colnames (features_test) [3:563] <- headings
34						
35	# merge fetauresTraining to FeaturesTest					
36						data_merged <- rbind(features_test,ABfeatures_training)
37						
38	# extract columns with"mean" and with "std" only in header					
39						data_select_mean <- select(data_merged, contains ("mean"))
40						data_select_std <- select(data_merged, contains ("std"))
41						data_selectAB <- select(data_merged, subject_code,Activity_Labels)
42	# nerge into a single data set					
43						data_select <- cbind(data_selectAB,data_select_mean,data_select_std)
44						
45	# Step Split, & Calculate on data_select using aggregate() on subject_code & Activity_Labels					
46						subject_activity<- aggregate(data_select [,3:88], by=list(data_select$subject_code, data_select$Activity_Labels),mean)
47						
48	# Rename swapped first two coloumns					
49						colnames(subject_activity) [1:2] <- c("subject_code","Activity_Labels")
50						
51	# Change Actiity_labels from #code to labels					
52			# activity_text<-read.table("./UCI HAR Dataset/activity_labels.txt")
53						levels_text <- c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
54			# levels_numbers <- c(1:6)
55						
56						subject_activity$Activity_Labels <- cut(subject_activity$Activity_Labels, breaks=6, labels=levels_text)
57						
58	# upload data set ("subject_activity") as a txt file created with write.table() using row.name=FALSE					
59						
60						write.table(subject_activity,file="./UCI HAR Dataset/subject_activity_means.txt", row.names= FALSE)

