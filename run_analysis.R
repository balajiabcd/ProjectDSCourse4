
# You can see all my commits if you click "balajiabcd" which is just abouve the README.md file.
# the final summarised mean output variable name is  ===  "newtidy"
# the middle data set that is decorated, variable name is  ===  "finaldf"


# Downloading and unzipping

filename <- "getdata_dataset.zip"
if (!file.exists(filename)){
       fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
       download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
       unzip(filename) 
}


# just reading 6 files in to R

testsub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
trainsub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
testy <- read.table("./UCI HAR Dataset/test/y_test.txt")
trainy <- read.table("./UCI HAR Dataset/train/y_train.txt")
testx <- read.table("./UCI HAR Dataset/test/X_test.txt")
trainx <- read.table("./UCI HAR Dataset/train/X_train.txt")


# trying to change names of following

names(testy) <- "activity"
names(testsub) <- "subject"


# binding all 6 togather

library(dplyr)
testbind <- bind_cols(testsub,testy,testx)
trainbind <- bind_cols(trainsub,trainy,trainx)
names(testbind) -> names(trainbind)
allbind <- bind_rows(testbind,trainbind)


# selecting all required cols from allbind

colsnames <- read.table( "./UCI HAR Dataset/features.txt")
posismean <- grep("mean()",colsnames$V2)
posisstd <- grep("std()",colsnames$V2)
newpos <- c(posismean,posisstd)
allposis <- c(1,2,posismean+2,2+posisstd)
finaldf <- select(allbind,allposis)


# removing all unwanted variables

rm("testsub","trainsub","testx","testy","trainx","trainy","testbind",
   "trainbind","allbind")


# replacing activity variables in selectmeanstd

activitylabel <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activitylabel) <- c("abx", "activity")
finaldf <- merge(activitylabel,finaldf,by.x = "abx",by.y = "activity") %>% select(-abx)
rm("activitylabel")


# replacing col names of selectmeanstd i.e, instead of v1,v2,v3.... replacing names

names(finaldf) <- c("activity", "subject", colsnames$V2[newpos])


# summirising mean to all variables and assigning it to another variable ttble.

ttbl <- tbl_df(finaldf)
newtidy <- ttbl %>% group_by(subject,activity) %>% summarise_each(mean)


# changing t's and f's of names of newtidy

library(stringr)
nms <- names(newtidy)
b <- str_detect(nms, "^f.*")
a <- str_detect(nms, "^t.*")
for( i in 1:length(a)){ 
       if(a[i])     { nms[i] <- sub("t","time",nms[i]) }
       if(b[i])     { nms[i] <- sub("f","freq",nms[i]) }
}
names(newtidy) <- nms
names(finaldf) <- nms


write.table(newtidy,"newtidy",row.names = FALSE)
# the final summarised mean output variable name is  ===  "newtidy"
# the middle data set that is decorated, variable name is  ===  "finaldf"
