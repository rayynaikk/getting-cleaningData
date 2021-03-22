# Step 1: Read all the relavant files
strain <- read.table(file="subject_train.txt")
head(strain)
str(strain)

stest <- read.table(file="subject_test.txt")
head(stest)
str(stest)

xtrain <- read.table(file="X_train.txt", header = FALSE) # We dont need the default header as we will add header from the feature
head(xtrain)
str(xtrain)

xtest <- read.table(file="X_test.txt", header = FALSE)
head(xtest)
str(xtest)

ytrain <- read.table(file="y_train.txt")
head(ytrain)
str(ytrain)

ytest <- read.table(file="y_test.txt")
head(ytest)
str(ytest)

alabels <- read.table(file="activity_labels.txt")
head(alabels)
str(alabels)

features <- read.table(file="features.txt")
head(features)
str(features)
features <- gsub("-","",features$V2) #Keep only the second column which will be the header and also removing the hyphen
head(features)
str(features) # This shows we have 561 headings to match the 561 columns in the train/test dataframes

# Step 2: Adding headings
colnames(strain) <- c("subject")
head(strain)
colnames(stest) <- c("subject")
head(stest)
colnames(ytrain) <- c("trainlabel")
head(ytrain)
tail(ytrain)
colnames(ytest) <- c("trainlabel")
head(ytest)
tail(ytest)
colnames(xtrain) <- c(features)
str(xtrain)
colnames(xtest) <- c(features)
str(xtest)
colnames(alabels) <- c("tlabel", "descrptvlables")
head(alabels)

# Step 3: Adding the subject & activity lable column to both the train and test dataframes. So now we will have 563 variables
newxtrain <- cbind(xtrain, strain, ytrain)
str(newxtrain)
head(newxtrain)
newxtest <- cbind(xtest, stest, ytest)
str(newxtest)
head(newxtest)

# Step 4: Merging the two dataframes. Train has 7352 obs, test has 2947. Each has 563 columns
# So after merging there should be 10299 records and 563 columns
final <- rbind(newxtrain, newxtest)
head(final)
str(final)

# Step 5: Extracting all with standard deviation and mean
final1 <- final[,grep("mean|std|subject|trainlabel",names(final))]
head(final1)
str(final1)

# Step 6: Adding the dexscriptive lables for the activities
install.packages("plyr")
library(plyr)
final2 <- merge(final1,alabels, by.x= "trainlabel", by.y = "tlabel", all = TRUE)
head(final2)
str(final2)

# Step 7: Creating the new dataframe of means by activity and subject
install.packages("reshape")
library(reshape2)
# Subsetting into a dataframe that has means and the subject and descriptive lables
final3 <- final2[,grep("mean|subject|descrptvlables",names(final2))]
head(final3)
str(final3)
namelist <- names(final3)
head(namelist)
tail(namelist)
# Seggregating the sub
rest <- select(final3, -(subject:descrptvlables))
str(rest)
final4 <- melt(final3, id=c("subject", "descrptvlables"), measure.vars=c(rest))
final5 <- dcast(final4, subject+descrptvlables~variable, mean)
head(final5)

# Step 8: Writing the dataframe to a text file:
write.table(final5, file = "Dataforchatper3week4.txt", row.names = FALSE)


