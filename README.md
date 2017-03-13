# tidydata

From the unpacked data retrieved from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, with the working directory set to where the data were unpacked, the script takes the following actions:

1. Pulls in the descriptive labels for the features from "features.txt" and for the activities from "activity_labels.txt"
2. Reads in the training set from "./train/X_train.txt"
3. Names the columns according to the features
4. Appends a subject variable column from "./train/subject_train.txt"
5. Appends the descriptive activities in a variable column from applying the activity labels to "./train/y_train.txt"
6. Reads the test set from "./test/X_test.txt"
7. Names the columns according to the features
8. Appends a subject variable column from "./test/subject_test.txt"
9. Appends the descriptive activities in a variable column from applying the activity labels to "./test/y_test.txt"
10. Row binds the test and train set together to make a single data frame
11. Finds only the measurement columns corresponding to mean and std variables
12. Subsets the data to include only the columns found in step 11, along with subject and activity
13. Groups the data from 12 by subject and activity and calculates the mean for each numeric variable
14. Outputs the result