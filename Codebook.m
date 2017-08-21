
The goal of the project was to produce a tidy data set from the files provided. The commands which were used to produce the tidy setare stored in "run_analysis.R" file.

Downloading and unzipping of appropriate files were done prior to coding.

EXPERIMENTAL DESIGN AND BACKGROUND
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

DATASET ATTRIBUTE INFORMATION
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its ,activity label. 
- An identifier of the subject who carried out the experiment.

RAW DATA
- 'features.txt': List of all features.
Sample: tBodyAcc-mean()-X/Y/Z , tBodyAcc-sdv()-X/Y/Z, tBodyAcc-mad()-X/Y/Z ...
- 'activity_labels.txt': Links the class labels with their activity name.
Sample: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,SITTING, STANDING, LAYING
- 'train/X_train.txt': Training set.
Sample: -7.4441253e-001  8.5294738e-001
- 'train/y_train.txt': Training labels.
Sample: 3,4,5
- 'test/X_test.txt': Test set.
Sample: -7.4441253e-001  8.5294738e-001
- 'test/y_test.txt': Test labels.
Sample: 3,4,5

PROCESSED DATA

Values of Varible 'Activity' consist of data from “Y_train.txt” and “Y_test.txt”
values of Varible 'Subject' consist of data from “subject_train.txt” and subject_test.txt"
Values of Varibles 'Features' consist of data from “X_train.txt” and “X_test.txt”
Names of Varibles Features come from “features.txt”
Levels of Varible Activity come from “activity_labels.txt”


- activityTest,activityTrain,subjectTest,subjectTrain are data frames with one variable
- featuresTest,featuresTrain are data frames with 561 variables
- Data is a data frame of 68 variables that contains extracted measurements on mean and sdv on each measurement.
  It also contains descriptive variable names.
- Data2 is a data frame that contains an independent tidy data set with the average of each variable for each activity 
  and each subject based on Data







