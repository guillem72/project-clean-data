#script for performing the analysis
library("reshape")

#set working directory i load data
setwd("~/sincron/coursera/r/cleandata/projecte/enviar")
X_test <- read.table("../UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
y_test <- read.table("../UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
stest <- read.table("../UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
X_train <- read.table("../UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
y_train <- read.table("../UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
strain <- read.table("../UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
features <- read.table("../UCI HAR Dataset/features.txt", quote="\"", comment.char="")

#small transformations
features1<-features$V2
features_t<-t(features1)

#put names in the columns (it is part of question 4)
colnames(X_test)<-features_t
colnames(X_train)<-features_t


# add an id to each set for mergin purposes 
# the subjects in the train set are not the same of the test set, so they have to have a diferent id
stest$id<-seq(1:nrow(stest))
strain$id<-seq(from=1+nrow(stest), to=nrow(strain)+nrow(stest))
X_train$id<-seq(from=1+nrow(X_test), to=nrow(X_train)+nrow(X_test))
View(y_test)
y_train$id<-seq(from=1+nrow(y_test), to=nrow(y_train)+nrow(y_test))
x_train$id<-seq(1:nrow(x_train))
y_test$id<-seq(1:nrow(y_test))

#complete all the colnames (the others have been completed above)
colnames(stest)<-c("subject","id")
colnames(strain)<-c("subject","id")
colnames(y_test)<-c("activity","id")
colnames(y_train)<-c("activity","id")

#merge vertically in two steps
t1<-merge(stest,X_test,x.by.x="id",by.y="id",all = T)
test<-merge(t1,y_test,x.by.x="id",by.y="id",all = T)
rm(t1)
t1<-merge(strain,X_train,x.by.x="id",by.y="id",all = T)
train<-merge(t1,y_train,x.by.x="id",by.y="id",all = T)
rm(t1)


#merge horizontaly. (question 1)
phone<-rbind(test,train)


#Extracts only the measurements on the mean and standard deviation for each measurement (question 2)
patro<-".*mean\\(\\).*|.*std\\(\\).*"
index<-grep(patro,names(phone))
elegits<-phone[,index]
elegits$subject<-phone$subject
elegits$activitat<-phone$activity


# Uses descriptive activity names to name the activities in the data set (question 3)
library("plyr")
activity_labels <- read.table("../UCI HAR Dataset/activity_labels.txt", quote="", comment.char="")
elegits$activitat<-mapvalues(elegits$activitat,activity_labels$V1,as.vector(activity_labels$V2))
write.csv(elegits,"data.csv")


# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject (question 5)
dcast(ele, activitat + subject ~ variable)
library("reshape")
resum<-cast(ele, activitat ~ subject ~ variable, mean)
write.csv(resum,"data2.csv");
