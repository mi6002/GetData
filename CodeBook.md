As required, this CodeBook.md is  a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

It accompanies the main R script known as run_analysis.R and a readme.md file that explains how run_analysis.R works.

I. Basic Premise
==========================================
The raw data files used in this exercise are all contained in a directory known as "UCI HAR Dataset". The whole set of files have been downloaded from 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
In particular, the files have been unzipped (from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), and put into a working directory 
that also contains the main R script run_analysis.R.

So, when both "UCI HAR Dataset" and run_analysis.R are contained in the (same) working directory, we can invoke the script simply
by typing source("run_analysis.R").

The libraries that are needed are data.table and reshape2.

II. Data files and variables
==========================================
In terms of the raw data files available, the main directory  "UCI HAR Dataset" contains the following.

i) a directory known as test
The focus is on the 3 txt files X_test, y_test and subject_test.
A str of the X_test data looks like this (notice dataXTest is the name given internally within the R script after the data are read from X_test):
str(dataXTest)
'data.frame':	2947 obs. of  561 variables:
 $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
 $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 $ V3  : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
 $ V4  : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
 $ V5  : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
 
 A str of y_test data looks like this (notice datayTest is the name given internally within the R script after the data are read from y_test)
 str(datayTest)
'data.frame':	2947 obs. of  1 variable:
 $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

Similarly, a str of subject_test (internally known as dataSubjectTest) gives
str(dataSubjectTest)
'data.frame':	2947 obs. of  1 variable:
 $ V1: int  2 2 2 2 2 2 2 2 2 2 ...

ii) a directory known as train
Essentially training data sets that reflect the test data, i.e. X_, y_ and subject_). Specifically, we have
str(dataXTrain)
'data.frame':	7352 obs. of  561 variables:
 $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
 $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
 $ V3  : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
 $ V4  : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
 $ V5  : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
 
 str(datayTrain)
'data.frame':	7352 obs. of  1 variable:
 $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
 
 str(dataSubjectTrain)
'data.frame':	7352 obs. of  1 variable:
 $ V1: int  1 1 1 1 1 1 1 1 1 1 ...

iii) 4 txt files as follows

README.txt that gives the background information about the experiments and data. It includes information about the authors and their affiliation, version number, license, etc. Of particular interest are the following pieces of information:

For each record:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Files included in the data set:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

activity_labels.txt simply contains the 6 predefined categories of activities, namely

1 WALKING

2 WALKING_UPSTAIRS

3 WALKING_DOWNSTAIRS

4 SITTING

5 STANDING

6 LAYING


feature_info.txt, with particularly relevant information reproduced below.
These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Among these, mean() and std() are of particular interest in this exercise. 

The 4th txt file is features.txt, which contains 561 feature labels. So, for example,
> Feature_labels <- read.table('UCI HAR Dataset//features.txt')
> head(Feature_labels)
[1] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" 
[5] "tBodyAcc-std()-Y"  "tBodyAcc-std()-Z" 


III. Transformations
==========================================
Transformations done to the raw data include the following.

1. Combine the X train, y train and subject train data to form a combined training data set: 
> CombinedTraindata <- cbind(dataSubjectTrain, yTrainLabels, dataXTrain)

2. Do the same for test data:
> CombinedTestdata <- cbind(dataSubjectTest, yTestLabels, dataXTest)

3. Combine the above 2 to form the complete data set
> CompleteDataSet <-  rbind(CombinedTraindata, CombinedTestdata)


4. Extract the relevant mean and standard deviation measures, 66 of them: 
> RowsWithMeanStd
     V1                          V2
1     1           tBodyAcc-mean()-X
2     2           tBodyAcc-mean()-Y
3     3           tBodyAcc-mean()-Z
4     4            tBodyAcc-std()-X
5     5            tBodyAcc-std()-Y
6     6            tBodyAcc-std()-Z
41   41        tGravityAcc-mean()-X
42   42        tGravityAcc-mean()-Y
43   43        tGravityAcc-mean()-Z
44   44         tGravityAcc-std()-X
45   45         tGravityAcc-std()-Y
46   46         tGravityAcc-std()-Z
81   81       tBodyAccJerk-mean()-X
82   82       tBodyAccJerk-mean()-Y
83   83       tBodyAccJerk-mean()-Z
84   84        tBodyAccJerk-std()-X
85   85        tBodyAccJerk-std()-Y
86   86        tBodyAccJerk-std()-Z
121 121          tBodyGyro-mean()-X
122 122          tBodyGyro-mean()-Y
123 123          tBodyGyro-mean()-Z
124 124           tBodyGyro-std()-X
125 125           tBodyGyro-std()-Y
126 126           tBodyGyro-std()-Z
161 161      tBodyGyroJerk-mean()-X
162 162      tBodyGyroJerk-mean()-Y
163 163      tBodyGyroJerk-mean()-Z
164 164       tBodyGyroJerk-std()-X
165 165       tBodyGyroJerk-std()-Y
166 166       tBodyGyroJerk-std()-Z
201 201          tBodyAccMag-mean()
202 202           tBodyAccMag-std()
214 214       tGravityAccMag-mean()
215 215        tGravityAccMag-std()
227 227      tBodyAccJerkMag-mean()
228 228       tBodyAccJerkMag-std()
240 240         tBodyGyroMag-mean()
241 241          tBodyGyroMag-std()
253 253     tBodyGyroJerkMag-mean()
254 254      tBodyGyroJerkMag-std()
266 266           fBodyAcc-mean()-X
267 267           fBodyAcc-mean()-Y
268 268           fBodyAcc-mean()-Z
269 269            fBodyAcc-std()-X
270 270            fBodyAcc-std()-Y
271 271            fBodyAcc-std()-Z
345 345       fBodyAccJerk-mean()-X
346 346       fBodyAccJerk-mean()-Y
347 347       fBodyAccJerk-mean()-Z
348 348        fBodyAccJerk-std()-X
349 349        fBodyAccJerk-std()-Y
350 350        fBodyAccJerk-std()-Z
424 424          fBodyGyro-mean()-X
425 425          fBodyGyro-mean()-Y
426 426          fBodyGyro-mean()-Z
427 427           fBodyGyro-std()-X
428 428           fBodyGyro-std()-Y
429 429           fBodyGyro-std()-Z
503 503          fBodyAccMag-mean()
504 504           fBodyAccMag-std()
516 516  fBodyBodyAccJerkMag-mean()
517 517   fBodyBodyAccJerkMag-std()
529 529     fBodyBodyGyroMag-mean()
530 530      fBodyBodyGyroMag-std()
542 542 fBodyBodyGyroJerkMag-mean()
543 543  fBodyBodyGyroJerkMag-std()

Adding Subject, Activity ID and Actitvity factors, the data set becomes DataMeanStd.

> str(DataMeanStd)
'data.frame':	10299 obs. of  69 variables:
 $ Subject                    : int  1 1 1 1 1 1 1 1 1 1 ...
 $ Activity.Id                : int  1 1 1 1 1 1 1 1 1 1 ...
 $ Activity                   : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...
 $ tBodyAcc-mean()-X          : num  0.289 0.278 0.28 0.279 0.277 ...
 $ tBodyAcc-mean()-Y          : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
 $ tBodyAcc-mean()-Z          : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
 $ tBodyAcc-std()-X           : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
 $ tBodyAcc-std()-Y           : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
 $ tBodyAcc-std()-Z           : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
 $ tGravityAcc-mean()-X       : num  0.963 0.967 0.967 0.968 0.968 ...
 $ tGravityAcc-mean()-Y       : num  -0.141 -0.142 -0.142 -0.144 -0.149 ...
 $ tGravityAcc-mean()-Z       : num  0.1154 0.1094 0.1019 0.0999 0.0945 ...
 $ tGravityAcc-std()-X        : num  -0.985 -0.997 -1 -0.997 -0.998 ...
 $ tGravityAcc-std()-Y        : num  -0.982 -0.989 -0.993 -0.981 -0.988 ...
 $ tGravityAcc-std()-Z        : num  -0.878 -0.932 -0.993 -0.978 -0.979 ...
 $ tBodyAccJerk-mean()-X      : num  0.078 0.074 0.0736 0.0773 0.0734 ...
 $ tBodyAccJerk-mean()-Y      : num  0.005 0.00577 0.0031 0.02006 0.01912 ...
 $ tBodyAccJerk-mean()-Z      : num  -0.06783 0.02938 -0.00905 -0.00986 0.01678 ...
 $ tBodyAccJerk-std()-X       : num  -0.994 -0.996 -0.991 -0.993 -0.996 ...
 $ tBodyAccJerk-std()-Y       : num  -0.988 -0.981 -0.981 -0.988 -0.988 ...
 $ tBodyAccJerk-std()-Z       : num  -0.994 -0.992 -0.99 -0.993 -0.992 ...
 $ tBodyGyro-mean()-X         : num  -0.0061 -0.0161 -0.0317 -0.0434 -0.034 ...
 $ tBodyGyro-mean()-Y         : num  -0.0314 -0.0839 -0.1023 -0.0914 -0.0747 ...
 $ tBodyGyro-mean()-Z         : num  0.1077 0.1006 0.0961 0.0855 0.0774 ...
 $ tBodyGyro-std()-X          : num  -0.985 -0.983 -0.976 -0.991 -0.985 ...
 $ tBodyGyro-std()-Y          : num  -0.977 -0.989 -0.994 -0.992 -0.992 ...
 $ tBodyGyro-std()-Z          : num  -0.992 -0.989 -0.986 -0.988 -0.987 ...
 $ tBodyGyroJerk-mean()-X     : num  -0.0992 -0.1105 -0.1085 -0.0912 -0.0908 ...
 $ tBodyGyroJerk-mean()-Y     : num  -0.0555 -0.0448 -0.0424 -0.0363 -0.0376 ...
 $ tBodyGyroJerk-mean()-Z     : num  -0.062 -0.0592 -0.0558 -0.0605 -0.0583 ...
 $ tBodyGyroJerk-std()-X      : num  -0.992 -0.99 -0.988 -0.991 -0.991 ...
 $ tBodyGyroJerk-std()-Y      : num  -0.993 -0.997 -0.996 -0.997 -0.996 ...
 $ tBodyGyroJerk-std()-Z      : num  -0.992 -0.994 -0.992 -0.993 -0.995 ...
 $ tBodyAccMag-mean()         : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
 $ tBodyAccMag-std()          : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
 $ tGravityAccMag-mean()      : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
 $ tGravityAccMag-std()       : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
 $ tBodyAccJerkMag-mean()     : num  -0.993 -0.991 -0.989 -0.993 -0.993 ...
 $ tBodyAccJerkMag-std()      : num  -0.994 -0.992 -0.99 -0.993 -0.996 ...
 $ tBodyGyroMag-mean()        : num  -0.969 -0.981 -0.976 -0.982 -0.985 ...
 $ tBodyGyroMag-std()         : num  -0.964 -0.984 -0.986 -0.987 -0.989 ...
 $ tBodyGyroJerkMag-mean()    : num  -0.994 -0.995 -0.993 -0.996 -0.996 ...
 $ tBodyGyroJerkMag-std()     : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
 $ fBodyAcc-mean()-X          : num  -0.995 -0.997 -0.994 -0.995 -0.997 ...
 $ fBodyAcc-mean()-Y          : num  -0.983 -0.977 -0.973 -0.984 -0.982 ...
 $ fBodyAcc-mean()-Z          : num  -0.939 -0.974 -0.983 -0.991 -0.988 ...
 $ fBodyAcc-std()-X           : num  -0.995 -0.999 -0.996 -0.996 -0.999 ...
 $ fBodyAcc-std()-Y           : num  -0.983 -0.975 -0.966 -0.983 -0.98 ...
 $ fBodyAcc-std()-Z           : num  -0.906 -0.955 -0.977 -0.99 -0.992 ...
 $ fBodyAccJerk-mean()-X      : num  -0.992 -0.995 -0.991 -0.994 -0.996 ...
 $ fBodyAccJerk-mean()-Y      : num  -0.987 -0.981 -0.982 -0.989 -0.989 ...
 $ fBodyAccJerk-mean()-Z      : num  -0.99 -0.99 -0.988 -0.991 -0.991 ...
 $ fBodyAccJerk-std()-X       : num  -0.996 -0.997 -0.991 -0.991 -0.997 ...
 $ fBodyAccJerk-std()-Y       : num  -0.991 -0.982 -0.981 -0.987 -0.989 ...
 $ fBodyAccJerk-std()-Z       : num  -0.997 -0.993 -0.99 -0.994 -0.993 ...
 $ fBodyGyro-mean()-X         : num  -0.987 -0.977 -0.975 -0.987 -0.982 ...
 $ fBodyGyro-mean()-Y         : num  -0.982 -0.993 -0.994 -0.994 -0.993 ...
 $ fBodyGyro-mean()-Z         : num  -0.99 -0.99 -0.987 -0.987 -0.989 ...
 $ fBodyGyro-std()-X          : num  -0.985 -0.985 -0.977 -0.993 -0.986 ...
 $ fBodyGyro-std()-Y          : num  -0.974 -0.987 -0.993 -0.992 -0.992 ...
 $ fBodyGyro-std()-Z          : num  -0.994 -0.99 -0.987 -0.989 -0.988 ...
 $ fBodyAccMag-mean()         : num  -0.952 -0.981 -0.988 -0.988 -0.994 ...
 $ fBodyAccMag-std()          : num  -0.956 -0.976 -0.989 -0.987 -0.99 ...
 $ fBodyBodyAccJerkMag-mean() : num  -0.994 -0.99 -0.989 -0.993 -0.996 ...
 $ fBodyBodyAccJerkMag-std()  : num  -0.994 -0.992 -0.991 -0.992 -0.994 ...
 $ fBodyBodyGyroMag-mean()    : num  -0.98 -0.988 -0.989 -0.989 -0.991 ...
 $ fBodyBodyGyroMag-std()     : num  -0.961 -0.983 -0.986 -0.988 -0.989 ...
 $ fBodyBodyGyroJerkMag-mean(): num  -0.992 -0.996 -0.995 -0.995 -0.995 ...
 $ fBodyBodyGyroJerkMag-std() : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
 
 
5. The next thing to do is to generate another data set that contains the average of each variable for each activity and each subject. To do this, the reshape2 functions melt and dcast (for data frame cast) are used. 
In the melt operation, Subject, Activity Id and Activity are specified as id variables. By default, the others are treated as measured variables.

