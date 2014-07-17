Getting-and-Cleaning-Data-Course-Project
========================================

This repo is for Coursera course Getting and Cleaning Data.

run_analysis.R is the R code that performs the required actions in the project.

tidy_dataset.txt is the tidy dataset.

CODEBOOK FOR THE TIDY DATASET.docx is the code book required.

========================================

I've followed the instructions listed in the requirement of the project. 

First, we read the feature names and the activity names and use regular expression (grep function) to find out the measurements that only related to mean and standard deviation. 

Then we read the test and training files, use the selected measurement names above to subset those data into smaller pieces. 

Next we convert the activity numbers into activity names, then merge all of the subsets above into one dataset and assign the suitable column names for them. 

And also we need to calculate the mean of each variable, so we use melt and dcast function in reshape2 library to create correspond tables for activity and subject. 

Finally we combine those two tables and our final tidy dataset is created.