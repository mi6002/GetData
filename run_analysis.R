##run_analysis.R
##Input: UCI HAR data obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
##Output: Cleaned / merged data set as per specifications
##Actions:
##1 Merges the training and the test sets to create one data set.
##2 Extracts only the measurements on the mean and standard deviation for each measurement. 
##3 Uses descriptive activity names to name the activities in the data set
##4 Appropriately labels the data set with descriptive variable names. 
##5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##Assumptions: data set already downloaded from source and unzipped in the working direction together with this R script
##Usage: type source("run_analysis.R") and the cleaned data will appear as "processedData.txt" in the working directory
library(reshape2)
library(data.table)

######Step 0 Read all data
##Read x train and test data
dataXTrain <- read.table('UCI HAR Dataset//train/X_train.txt')
dataXTest <- read.table('UCI HAR Dataset//test/X_test.txt')

##Read y Train and y Test data
datayTrain <- read.table('UCI HAR Dataset//train/y_train.txt')
datayTest <- read.table('UCI HAR Dataset//test/y_test.txt')

##Read Subject Train and Subject Test files
dataSubjectTrain <- read.table('UCI HAR Dataset//train/subject_train.txt')
dataSubjectTest <- read.table('UCI HAR Dataset//test/subject_test.txt')

##Read activity labels
Activity_labels <- read.table('UCI HAR Dataset//activity_labels.txt')

######Step 1 Merge the data
## merge y test and training activity labels
yTrainLabels <- merge(datayTrain,Activity_labels,by="V1")
yTestLabels <- merge(datayTest,Activity_labels,by="V1")

##cbind the subject, yLabels and Xdata for train and repeat for test
CombinedTraindata <- cbind(dataSubjectTrain, yTrainLabels, dataXTrain)
CombinedTestdata <- cbind(dataSubjectTest, yTestLabels, dataXTest)

##rbind the Train and Test data to form the complete set of data
CompleteDataSet <-  rbind(CombinedTraindata, CombinedTestdata)


######Step 2 Extract the mean and standard deviation measurements; also perform appropriate labeling to address requirements 3 and 4.
##Read the feature labels
Feature_labels <- read.table('UCI HAR Dataset//features.txt')
##Use grepl to subset rows with "mean" and "std", there are 66 relevant labels
RowsWithMeanStd <- subset(Feature_labels,  grepl("(mean\\(\\)|std\\(\\))", Feature_labels $V2) )

##Specify the column names as "Subject", "Activity.Id" and "Activity"
colnames(CompleteDataSet) <- c("Subject","Activity.Id","Activity",as.vector(Feature_labels [,2])) 
##Use grep to identify data from CompleteDataSet that have column names "mean" and "std"
ColsWithMean <- grep("mean()", colnames(CompleteDataSet), fixed=T)
ColsWithStd <- grep("std()", colnames(CompleteDataSet), fixed=T)
##Combine these columns
ColsWithMeanStd <- sort(c(ColsWithMean, ColsWithStd))
##Extract from the CompleteDataSet only columns with Mean and Std
DataMeanStd <- CompleteDataSet[,c(1,2,3, ColsWithMeanStd)]
##Now we have Subject, Activity.Id, Activity, followed by the 66 relevant columns (mean and std)


######Step 3 Reshape the data and generate the final data set that meets all 5 requirements. Melt and dcast will be used.
MoltenData <- melt(DataMeanStd, id=c("Subject","Activity.Id","Activity"))
FinalData <- dcast(MoltenData, formula = Subject + Activity.Id + Activity ~ variable, fun=mean)
write.table(FinalData, "processedData.txt")

