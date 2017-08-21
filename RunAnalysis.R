filepath=file.path("/home/robla/Desktop/Coursera/DataScience/Course3/UCI HAR Dataset")

#Read Activity Files
activityTest<-read.table(file.path(filepath,"test","y_test.txt"),header=FALSE)
activityTrain<-read.table(file.path(filepath,"train","y_train.txt"),header=FALSE)
#Read Subject Files
subjectTest<-read.table(file.path(filepath,"test","X_test.txt"),header=FALSE)
subjectTrain<-read.table(file.path(filepath,"train","X_train.txt"),header=FALSE)
#Read Feature Files
featuresTest<-read.table(file.path(filepath,"test","subject_test.txt"),header=FALSE)
featuresTrain<-read.table(file.path(filepath,"train","subject_train.txt"),header=FALSE)

#1. Merges the training and the test sets to create one data set.
#Rowbind test and train data
Subject <- rbind(subjectTrain, subjectTest)
Activity<- rbind(activityTrain, activityTest)
Features<- rbind(featuresTrain, featuresTest)

#Set names to variables
names(Subject)<-c("subject")
names(Activity)<- c("activity")
featuresNames <- read.table(file.path(filepath, "features.txt"),head=FALSE)
names(Features)<- featuresNames$V2

#Perform cbind to get one data frame of all data
Combine <- cbind(Subject, Activity)
Data <- cbind(Features, Combine)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#Names of Features with “mean()” or “std()”
subFeaturesNames<-featuresNames$V2[grep("mean\\(\\)|std\\(\\)", featuresNames$V2)]
#Subset the data frame 'Data' by selected names of features
selectedNames<-c(as.character(subFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

#3. Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table(file.path(filepath, "activity_labels.txt"),header = FALSE)
Data$activity<-factor(Data$activity);
Data$activity<- factor(Data$activity,labels=as.character(activityLabels$V2))

#4. Appropriately labels the data set with descriptive variable names.
#Names of Features will labelled using descriptive variable names.
names(Data)<-gsub("^t", "time", names(Data))#prefix t is replaced by time
names(Data)<-gsub("Acc", "Accelerometer", names(Data))#Acc is replaced by Accelerometer
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))#Gyro is replaced by Gyroscope
names(Data)<-gsub("^f", "frequency", names(Data))#prefix f is replaced by frequency
names(Data)<-gsub("Mag", "Magnitude", names(Data))#Mag is replaced by Magnitude
names(Data)<-gsub("BodyBody", "Body", names(Data))#BodyBody is replaced by Body

#5. From the data set in step 4, creates a second, independent tidy data set with the average
#   of each variable for each activity and each subject.
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)


