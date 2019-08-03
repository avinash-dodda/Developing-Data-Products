library(caret)
library(randomForest)
library(e1071)
library(scales)
library(plyr)

set.seed(100)

#read data from UCI machine learning repo
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/breast-cancer-wisconsin.data"

bc_data <- read.table(url,sep = ",", na.strings=c("?"), colClasses=c("factor"))

colnames(bc_data) <- c("id", "Clump Thickness", "Uniformity of Cell Size", "Uniformity of Cell Shape", "Marginal Adhesion", "Single Epithelial Cell Size", "Bare Nuclei", "Bland Chromatin", "Normal Nucleoli", "Mitoses", "Class")

#clean data
bc_data <- bc_data[complete.cases(bc_data),]

levels(bc_data$Mitoses) <- c(levels(bc_data$Mitoses),9)

bc_data$Class <- as.factor(revalue(bc_data$Class, c("2" = "Not Breast Cancer", "4"="Yes Breast Cancer")))

bc_data$id <- NULL

#train model                      
inTrain <- createDataPartition(bc_data$Class, p=0.7,list = FALSE)
traindata <- bc_data[inTrain,]
testdata <- bc_data[-inTrain,]

rf <- train(Class~., data=traindata, method = "rf", trControl = trainControl(method = "cv", number = 3))

rf.pred <- predict(rf,testdata)

cm <- confusionMatrix(testdata$Class, rf.pred)

bc_predict <- function(x){
    predict(rf, newdata = x)
}

library(shiny)

# Define server logic required output prediction
shinyServer(function(input, output) {

  output$prediction <- renderText(as.character(bc_predict(x= data.frame("Clump Thickness" = as.factor(input$Clump_Thickness),     
                                                            "Uniformity of Cell Size"=as.factor(input$Uniformity_of_Cell_Size), 
                                                            "Uniformity of Cell Shape"=as.factor(input$Uniformity_of_Cell_Shape),     "Marginal Adhesion" = as.factor(input$Marginal_Adhesion), 
                                                            "Single Epithelial Cell Size" = as.factor(input$Single_Epithelial_Cell_Size), 
                                                            "Bare Nuclei" = as.factor(input$Bare_Nuclei), 
                                                            "Bland Chromatin" = as.factor(input$Bland_Chromatin), 
                                                            "Normal Nucleoli" = as.factor(input$Normal_Nucleoli), 
                                                            "Mitoses" = as.factor(input$mitoses), check.names = FALSE))))
  
  output$accuracy <- renderText(percent(cm$overall[["Accuracy"]]))
})
