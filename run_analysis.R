
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
## for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, 
## creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

# download dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = "~/Documents/R/activity.zip", method = "curl")

# unzip file
activity.unzip = unzip("~/Documents/R/activity.zip")

# read file
## inspect zip file
activity.unzip 

activity.labels.dic = read.table(activity.unzip[1], stringsAsFactors = FALSE)
features.dic = read.table(activity.unzip[2], stringsAsFactors = FALSE) 
# 561 variables (col names) in test set, train set

test.set = read.table(activity.unzip[15]) # test set
act.label.test = read.table(activity.unzip[16]) # activity labels in test set
subject.test = read.table(activity.unzip[14]) # 2947 observations (row names) in test set


train.set = read.table(activity.unzip[27]) # training set
act.label.train = read.table(activity.unzip[28]) # activity labels in train set
subject.train = read.table(activity.unzip[26]) # 7352 observations (row names) in train set

rm("activity.unzip") # clean memory

# 1. Merges the training and the test sets to create one data set.
## order: test first, then train

total.set = rbind(test.set, train.set)
rm(list = c("test.set", "train.set")) # clean memory

total.subject = rbind(subject.test, subject.train)
rm(list = c("subject.test", "subject.train")) # clean memory

total.act.label = rbind(act.label.test, act.label.train)
rm(c("act.label.test", "act.label.train")) # clean memory

# 2. Extracts only the measurements on the mean and standard deviation 
## for each measurement. 

subset = features.dic[grep(x = features.dic[[2]], pattern = "mean()|std()"), 1]

mean.sd.set = total.set[subset]

# 4. Appropriately labels the data set with descriptive variable names

colnames(mean.sd.set) = features.dic[subset, 2]


# 3. Uses descriptive activity names to name the activities in the data set

## create vector activity names
total.act.names = rep(NA, nrow(total.act.label))

for (i in 1:length(total.act.names)) {
  total.act.names[i] = activity.labels.dic[
    activity.labels.dic[[1]] == total.act.label[[1]][i], 
    2]
}

## adding activity names to mean.sd.set
mean.sd.set = cbind(activity.names = total.act.names, mean.sd.set)

# 5. From the data set in step 4, 
## creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

# adding subject to mean.sd.set
mean.sd.set = cbind(subject = total.subject[[1]], mean.sd.set) 
## notes: as a result of read.table(), class(total.subject): data.frame 

# create tidy data set group by subject and activities
## load dplyr
library(dplyr)

## create tidy data set
tidy.set = mean.sd.set %>% 
  group_by(activity.names, subject) %>% # group by activity and subject
  summarise_each(funs(mean)) # calculate means of all var exept grouping var

## export tidy data set
write.table(tidy.set, 
            file = "~/Documents/R/course/Data cleaning/Assignment/tidy_set.txt", 
            row.names = FALSE) 


