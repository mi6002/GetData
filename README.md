GetData
=======
This file explains how run_analysis.R works.

The script takes as Input UCI HAR data obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
and generates the Output a file known as "processedData.txt", which contains the Cleaned / merged data set as per specifications
The 5 requirements are that run_analysis.R
1 Merges the training and the test sets to create one data set.
2 Extracts only the measurements on the mean and standard deviation for each measurement. 
3 Uses descriptive activity names to name the activities in the data set
4 Appropriately labels the data set with descriptive variable names. 
5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

N.B.
Assumptions: data set already downloaded from source and unzipped in the working direction together with this R script
Usage: type source("run_analysis.R") and the cleaned data will appear as "processedData.txt" in the working directory

More specifically run_analysis performs a preliminary step (0) followed by 3 steps to meet the requirements:

