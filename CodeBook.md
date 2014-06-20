As required, this CodeBook.md is  a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

It accompanies the main R script known as run_analysis.R and a readme.md file that explains how run_analysis.R works.

1. Basic Premise
The raw data files used in this exercise are all contained in a directory known as "UCI HAR Dataset". The whole set of files have been downloaded from 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
In particular, the files have been unzipped (from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), and put into a working directory 
that also contains the main R script run_analysis.R.

So, when both "UCI HAR Dataset" and run_analysis.R are contained in the (same) working directory, we can invoke the script simply
by typing source("run_analysis.R").

2. Data files and variables

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

ii) a directory known as train

iii) 4 txt files.


3. Transformations
