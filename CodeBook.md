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
ii) a directory known as train
iii) 4 txt files.


3. Transformations
