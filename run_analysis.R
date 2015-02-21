## read in files from test folder:
setwd("C:/Users/Nancy/Dropbox/coursera/getting and using data/project/data/UCI HAR Dataset/test")
subjecttest <- read.table("subject_test.txt")
xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")
##repeat with training files
setwd("C:/Users/Nancy/Dropbox/coursera/getting and using data/project/data/UCI HAR Dataset/train")
xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")

## name the columns
colnames(subjecttest) <- "subject_num"
colnames(ytest) <- "test_label"
colnames(ytrain) <- "test_label"

setwd("C:/Users/Nancy/Dropbox/coursera/getting and using data/project/data/UCI HAR Dataset")
features <- read.table("features.txt")

##subset just the names
names <- features[,2]

names <- as.character(names)


##assign names to activities
ytest$test_label <- factor(ytest$test_label, levels = c(1, 2, 3, 4, 5, 6), labels = c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying"))

## combine all the test files together
test <- cbind(subjecttest, xtest)
test <- cbind(test, ytest)

##repeat with training files
setwd("C:/Users/Nancy/Dropbox/coursera/getting and using data/project/data/UCI HAR Dataset/train")
xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")
ytrain$test_label <- factor(ytrain$test_label, levels = c(1, 2, 3, 4, 5, 6), labels = c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying"))

##assign names to xtest file
colnames(xtrain) <- names
colnames(ytrain) <- "test_label"

subjecttrain <- read.table("subject_train.txt")
train <- cbind(subjecttrain, xtrain)
train <- cbind(train, ytrain)

##name variables
colnames(test) <- names
colnames(train) <- names

##combine training and test files
data <- rbind(test, train)

##extract mean and sd
names <- colnames(data)
meannames <- grep("Mean", names)
stdnames <- grep("std", names)
meanstdnames <- c(meannames, stdnames)

mstddata <- subset(data, select=c(1, meanstdnames, 563))
##compute mean of the variables with mean in the name
mstddata$Mean <- rowMeans(data[,c(meannames)])

##compute mean of the variables with std in the name
mstddata$std <- rowMeans(data[,c(stdnames)])

##subset data into a new data set
tidy <- subset(mstddata, select=c("subject_num", "test_label", "Mean", "std"))


##write to file
write.table(tidy, "tidy.txt")
