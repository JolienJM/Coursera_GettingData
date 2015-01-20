# The data
The data in this dataset represents activity from several accelerometers from the Samsung Galaxy S smartphone. The activities consisted of walking, walking upstairs, walking downstairs, sitting, standing and laying. The data has been normalized (range = [-1, 1]) and is therefore unitless.

# Source of data
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - UniversitÃ  degli Studi di Genova, Genoa I-16145, Italy.
activityrecognition '@' smartlab.ws
www.smartlab.ws 

The dataset can be downloaded from the UCI Machine Learning Repository: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Analysis
The files subject_train.txt, X_train.txt and y_train.txt from the UCI HAR Dataset/train folder were merged with subject_test.txt, X_test.txt and y_test.txt from the UCI HAR Dataset/test folder, respectively. 

The file 'features.txt' contains all variable names from X_train and X_test. It was read in and a regular expression was used to get all features with 'mean' or 'std' in the variable name. A second regular expression was used to filter out features with 'meanFreq' in the name. Next the variable names were tidied up. The starting 't' was replaced with 'time', 'f' with 'freq' (frequency) and brackets (e.g. 'mean()') were removed.

Next, the dataframe resulting from the merged subject files, X files and y files were combined in one big dataframe. Activity labels were changed from numeric (1 = walking, 2 = walking upstairs) to strings. Finally, the dataset was grouped first by subject and then by activity, after which it was summarized.

# Information about preprocessing and features (from source)
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

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
