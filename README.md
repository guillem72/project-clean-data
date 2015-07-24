---
title: "Project"
author: "Guillem Lluch Moll"
date: "24 juliol de 2015"
---

### Files

This repository contains the following files:

1.	interaccions.R
2.	codebook.md
3.  data.csv
4.  data2.csv
5.  README.md (this file)


### interaccions.R
This file do all the work to generate the new data form https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The information of the raw data could be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The steps that interaccions.R do are

1. set working directory i load data
2. put names in the columns 
3. add an id to each set for mergin purposes 
4. merge vertically and then horizontaly.
5. extracts only the measurements on the mean and standard deviation for each measurement
6. uses descriptive activity names to name the activities in the data set
7. save to a file, data.csv
8. creates a second, independent tidy data set with the average of each variable for each activity and each subject and save it as data2.csv
