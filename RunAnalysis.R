filepath=file.path("/home/robla/Desktop/Coursera/DataScience/Course3/UCI HAR Dataset")

#Read files into R dataframe
activity<-read.table(file.path(filepath,"activity_labels.txt"),col.names = c('Number', 'Activity'))
features<-read.table(file.path(filepath, "features.txt"),col.names = c('Number', 'Features'))
testSubject<-read.table(file.path(filepath,"test","subject_test.txt"),col.names=c("Subject"))
testLabels<-read.table(file.path(filepath,"test","y_test.txt"),col.names=c("Number"))
testData<-read.table(file.path(filepath,"test","X_test.txt"))
trainSubject<-read.table(file.path(filepath,"train","subject_train.txt"),col.names=c("Subject"))
trainLabels<--read.table(file.path(filepath,"train","y_train.txt"),col.names=c("Number"))
trainData<-read.table(file.path(filepath,"train","X_train.txt"))

#4. Appropriately labels the data set with descriptive variable names.
# Fix features names to be used as column names 
features$Feature <- gsub('\\(|\\)', '', features$Feature)
features$Feature <- gsub('-|,', '.', features$Feature)
features$Feature <- gsub('BodyBody', 'Body', features$Feature)
features$Feature <- gsub('^f', 'Frequency.', features$Feature)
features$Feature <- gsub('^t', 'Time.', features$Feature)
features$Feature <- gsub('^angle', 'Angle.', features$Feature)
features$Feature <- gsub('mean', 'Mean', features$Feature)
features$Feature <- gsub('tBody', 'TimeBody', features$Feature)

# Change the name of the data sets using the features data
colnames(testData) <- features$Feature
colnames(trainData) <- features$Feature

#3. Uses descriptive activity names to name the activities in the data set
# Replace train and test labels by the names in the activity file
labels <- activity$Activity
testFactors <- factor(testLabels$Number)
trainFactors <- factor(trainLabels$Number)
testActivity <- data.frame(Activity=as.character(factor(testFactors, labels=labels)))
trainActivity <- data.frame(Activity=as.character(factor(trainFactors, labels=labels)))

#1. Merges the training and the test sets to create one data set.
#Perform cbind to get a single test and train data
testMergedData <- cbind(testSubject, testActivity, testData)
trainMergedData <- cbind(trainSubject, trainActivity, trainData)

#PErform rbind to get one dataset
mergedData <- rbind(testMergedData, trainMergedData)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Select columns that do not contain Angle or MeanFreq ####
# This columns are not considered as mean or std meassurements
cols <- c()
colNames <- colnames(mergedData)
for (i in seq_along(colNames)){
  name <- colNames[i]
  check1 <- grep('Angle', x=name)
  check2 <- grep('MeanFreq', x=name)
  if (!(any(check1) | any(check2))){
    cols <- c(cols, i)
  }
} 

mergedData <- mergedData[,cols]
mergedDataSubset <- mergedData[,grep('Subject|Activity|Mean|std',x=colnames(mergedData))]

#5. From the data set in step 4, creates a second, independent tidy data set with the average
#   of each variable for each activity and each subject.
library(data.table)
tidyData <- data.table(mergedDataSubset)
tidyData <- tidyData[,lapply(.SD, mean), by=c('Subject', 'Activity')]
tidyData <- tidyData[order(tidyData$Subject, tidyData$Activity),]
tidyFileName <- 'tidyData.txt'
write.table(tidyData, file=tidyFileName, row.names=FALSE)



