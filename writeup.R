#library(caret)
#library(dplyr)
#library(ggplot2)
#library(randomForest)

#trainingRaw <- read.csv("pml-training.csv")
#testingRaw <- read.csv("pml-testing.csv")

#trainingRaw <- data.frame(trainingRaw)
#trainingRaw <- trainingRaw[, !is.na(colSums(trainingRaw != 0)) & colSums(trainingRaw != 0) > 0]

#trainRaw <- trainingRaw %>% select(-starts_with("kurtosis"),-starts_with("skewness"), -starts_with("max_yaw"),
#  -starts_with("min_yaw"), -starts_with("amplitude_yaw"), -starts_with("X"), -starts_with("user_name"),
#  -contains("timestamp"), -contains("window"))

#set.seed(1234)
#train <- createDataPartition(trainRaw$classe, p=0.75, list=FALSE)
#trainData <- trainRaw[train,]
#testData <- trainRaw[-train,]

trc = trainControl( method="cv", number=3, allowParallel=TRUE, verboseIter=TRUE) 
mtrain <- train(classe ~., trainData, method="rf", trControl=trc)

#mtrain <- randomForest( classe ~., trainData, importance = TRUE, ntree = 150 )  # should use 200
#varImpPlot(mtrain)  # shouldn't use

#pred <- predict(mtrain, testData)
#cm <- confusionMatrix(pred, testData$classe)

# need to check this point onwards


# IGNORE
#tr <- trainingRaw
#nzv <- nearZeroVar(trainingRaw)
#tr <- trainingRaw[-nzv]
#cc <- complete.cases(tr)
#tr <- tr[cc,]
#t1 <- train(classe ~., data=z, method="rf")
#nzv1 <- nearZeroVar(testingRaw)
#testDat <- testingRaw[-nzv1]
#cc <- complete.cases(testDat)
#testDat <- testDat[cc,]
