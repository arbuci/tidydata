require("dplyr")
require("readr")
require("tidyr")

# Read in feature and activity labels for descriptive variables and columns
features <- read.delim("features.txt", sep = " ", header = FALSE)
act_labels <- read.delim("activity_labels.txt", 
                         sep = " ", 
                         header = FALSE, 
                         col.names = c("index", "activity"))

# Training set
train <- read_fwf("./train/X_train.txt", 
                col_positions = fwf_empty("./train/X_train.txt"))
names(train) <- features[, 2]
subj <- read.delim("./train/subject_train.txt", header = FALSE, col.names = "subject")
train <- cbind(train, subj)
act_train <- read.delim("./train/y_train.txt", header = FALSE, col.names = "index") %>%
  left_join(act_labels, by = "index") %>%
  select(2)
train <- cbind(train, act_train)

# Test set
test <- read_fwf("./test/X_test.txt", 
                 col_positions = fwf_empty("./test/X_test.txt"))
names(test) <- features[, 2]
subj <- read.delim("./test/subject_test.txt", header = FALSE, col.names = "subject")
test <- cbind(test, subj)
act_test <- read.delim("./test/y_test.txt", header = FALSE, col.names = "index") %>%
  left_join(act_labels, by = "index") %>%
  select(2)
test <- cbind(test, act_test)

# Combine into a single data set, subsetting only mean and std columns
dat <- rbind(train, test)
cols <- grep("mean\\(\\)|std\\(\\)", names(dat))
dat <- dat[, c(cols, 562, 563)]

# Make the grouped/averaged dataset
avg <- dat %>%
  group_by(subject, activity) %>%
  summarize_each(funs(mean))

avg
