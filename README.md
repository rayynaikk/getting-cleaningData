The R script aims at reading a set of training and test data from a group of text files; merging them and then creating a new tidy dataset of means by subject and activity and then creating a text output of the tidy dataset

Step 1: Here we read all the relevant files and create the various dataframes:
1. strain is a dateframe that has the list of all the subject on whom the test was carried out
2. stest is a similar dateframe as above but contains the subjects in the test set of data
3. xtrain is the main dataframe that has the list of all the variables measured. This dataframe pertains to the training part of the data
4. xtest is the main dataframe that has the list of all the variables measured but pertains to the test part of the data
5. ytrain/ytest has the activities performed. There are 6 activities. train/test pertain to the training andtesting data respectively.
6. alabels is the dataframe that has the description of the above activities
7. features contains the names of all the variables measured in the xtrain/xtest dataframe

Step 2: In this we are adding headers to the dataframes where needed. For instance the features dataframe is used to add the names to the variables in the xtrain/xtest datasets. Similarly, a subject heading is added to the strain and stest dataset. The column names are necessary for the subsequent operations

Step 3: In step 3 we are creating a complete training and test data set by combining the variables in the xtrain/xtest data set with the subjects and the activities

Step 4: Here we merge the training and the test data sets created in the above step to get the complete list of all the record into one dataframe. The new dataframe created is called final

Step 5: Here we are creating a new dataframe - final - with only the relevant variables that measure the standard deviations or means. We are also retianing the subject and activity columns

Step 6: Here we are adding a new column call descriptions of the activities. This is done by using the alables dataframe that has the activity code and the description. This final1 dataframe has tha activity codes. So the activity code is the common column that is used to add the activity description to the appropriate rows. The resulting dataframe is final2

Step 7: In step 7 we are doing several activities. We are first getting a subset with only the mnean variables. This is final3 dataframe. Now from this we are creating a new dataframe - final4 - that is organized by activity and subject. finally we are getting the final dataset - final5 - which has the mean of all the variables by subject and activity.

Step 8 : We are creating a text version of the final5 dataframe 

The appropriate packages have been installed wherever required 

