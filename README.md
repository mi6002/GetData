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

Step 0 doesn't specifically address any of the 5 requirements. It basically reads in all the relevant data using the read.table function. The data files that are read include the main X training / test data (X_train.txt and X_test.txt),  the y tarining / test data (y_train.txt and y_test.txt), the subject training / test data (subject_train.txt, subject_test.txt), and the activity labels (activity_labels.txt) that are subsequently used to appropriately name the columns.

Step 1 addresses Requirement 1 by performing merging of the data. So, training data from the 3 sources (X, y, subject) are column bound together to form the combined training data. This is repeated for the test data. The two are then row bound to form the complete data set for further processing.

Step 2 addresses Requirements 2,3, and 4. It extracts the mean and standard deviation measurements and also performs appropriate labeling to address requirements 3 and 4. It uses read.table to read in the feature labels 
(from features.txt) that are then subsequently used for appropriate labeling. It uses grep and grepl to identify measures that include mean and std.

Step 3 addresses Requirement 5 through the use of Reshape2 functions melt and dcast (for data frame) to derive the final data set that meets all 5 requirements. Finally, write.table is called to write to finall data to a txt file named "processedData", which is the final output of this R script.
