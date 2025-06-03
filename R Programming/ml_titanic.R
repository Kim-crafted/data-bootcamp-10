install.packages("titanic")
library(titanic)
head(titanic_train)

#--------------------
#Drop NA
titanic_train <- na.omit(titanic_train)
  
#split data
set.seed(42)
n <- nrow(titanic_train)
id <- sample(1:n, n*0.5)
train_data <- titanic_train[id, ]
test_data <- titanic_train[-id, ]


 
#----------------------
#Train
model <- glm(Survived ~ Sex + Age, data = train_data, family = "binomial")
p_train <- predict(model, type = "response")
train_data$pred_survived <- ifelse(p_train > 0.5, 1, 0)

##Model Evaluation with Confusion Matrix
(conM <- table(Actual = train_data$Survived, 
               Predicted =  train_data$pred_survived,
               dnn= c("Actual", "Predicted" )))

train_acc <-(conM[1,1]+conM[2,2]) / sum(conM)
train_prec <-conM[2,2] / (conM[1, 2] + conM[2,2])
train_rec <- conM[2,2] / (conM[2, 1] + conM[2, 2])
train_F1 <- 2 * (train_prec*train_rec)/(train_prec+train_rec)

cat("Accuracy: ", train_acc,
   "\nPrecision: ", train_prec,
   "\nRecall: ", train_rec,
   "\nF1: ", train_F1)

#----------------------------------------------
#Test
p_test <- predict(model, newdata = test_data, type = "response")
test_data$pred_survived <- ifelse(p_test > 0.5, 1, 0)

##Model Evaluation
(conM_test <- table(Actual = test_data$Survived, 
               Predicted =  test_data$pred_survived,
               dnn= c("Actual", "Predicted" )))

test_acc <-(conM_test[1,1]+conM_test[2,2]) / sum(conM_test)
test_prec <-conM_test[2,2] / (conM_test[1, 2] + conM_test[2,2])
test_rec <- conM_test[2,2] / (conM_test[2, 1] + conM_test[2, 2])
test_F1 <- 2 * (test_prec*test_rec)/(test_prec+test_rec)

cat("Accuracy: ", test_acc,
    "\nPrecision: ", test_prec,
    "\nRecall: ", test_rec,
    "\nF1: ", test_F1)

##F1 Score For Train and Test
cat("F1 Score: ",
    "\nTraining: ", train_F1,
    "\nTesting: ", test_F1)

#F1 Score:  
#Training:  0.7027027 
#Testing:  0.7260274
#Difference: 0.0233 (≈ 2.3%) 
#Consider a good fit model
