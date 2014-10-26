library(stringr)

train_data <- read.table("UCI HAR Dataset//train//X_train.txt")
train_data_y <- read.table("UCI HAR Dataset//train//y_train.txt")
train_data <- cbind(train_data_y, train_data)

test_data <- read.table("UCI HAR Dataset//test//X_test.txt")
test_data_y <- read.table("UCI HAR Dataset//test//y_test.txt")
test_data <- cbind(test_data_y, test_data)

data <- rbind(train_data, test_data)

activity_labels <- read.table("UCI HAR Dataset//activity_labels.txt")
data[,1] <- factor(data[,1], labels = activity_labels[,2])

features <- read.table("UCI HAR Dataset//features.txt")
colnames(data) <- c("Activity", as.character(features[,2]))
means_and_stds <- grepl("mean()", features[,2], fixed = TRUE) | grepl("std()", features[,2], fixed = TRUE)

data <- data[, c(TRUE, means_and_stds)]
write.table(data, "tidy_data.txt", row.names = FALSE)