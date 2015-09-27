library(caret)
library(dplyr)
library(randomForest)

trainingRaw <- read.csv("pml-training.csv")
testingRaw <- read.csv("pml-testing.csv")

trainingRaw <- data.frame(trainingRaw)
trainingRaw <- trainingRaw[, !is.na(colSums(trainingRaw != 0)) & colSums(trainingRaw != 0) > 0]

trainRaw <- trainingRaw %>% select(-starts_with("kurtosis"),-starts_with("skewness"), -starts_with("max_yaw"),
                                   -starts_with("min_yaw"), -starts_with("amplitude_yaw"), -starts_with("X"), -starts_with("user_name"),
                                   -contains("timestamp"), -contains("window"))

##Modeling using Random Forest and Cross Validation

# Set seed so we results are reproducible
set.seed(1234)
train <- createDataPartition(trainRaw$classe, p=0.75, list=FALSE)
trainData <- trainRaw[train,]
testData <- trainRaw[-train,]

# remove unwanted variables
trc = trainControl( method="cv", number=3, allowParallel=TRUE, verboseIter=TRUE) 

# create the model
mtrain <- train(classe ~., trainData, method="rf", trControl=trc)

# get predictions and create Confusion matrix to see how well classifier performance is
pred <- predict(mtrain, testData)
cm <- confusionMatrix(pred, testData$classe)

##Results
print(mtrain)
print(cm)

##Predict the test cases

testingRaw <- data.frame(testingRaw)
testingRaw <- testingRaw[, !is.na(colSums(testingRaw != 0)) & colSums(testingRaw != 0) > 0]

# Remove unwanted columns
testRaw <- testingRaw %>% select(-starts_with("X"), -contains("timestamp"), -contains("window"), -contains("user_name"))

#Predict the classe outcome using our model
pred2 <- predict(mtrain, testRaw)
print(pred2)

##Conclusion
The answers were sumbitted to Coursera and our model predicted all 20 cases 100% correctly.

# This code is used to create the 20 .txt files for project submission
if (0) {
  answers <- as.character(pred2);
  pml_write_files = function(x){
    n = length(x)
    for(i in 1:n){
      filename = paste0("problem_id_",i,".txt")
      write.table(x[i], file=filename, quote=FALSE, row.names=FALSE, 
      col.names=FALSE)
    }
  }
pml_write_files(answers);
}
