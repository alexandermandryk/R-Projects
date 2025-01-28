#libraries i needed to load
library(randomForest)
library(caret)

#training set
party_train <- read.csv("C:\\Users\\alexm\\Downloads\\PartyTrain24.csv")

#factor the columns to clean out errors
party_train$Music <- as.factor(party_train$Music)
party_train$Day <- as.factor(party_train$Day)
party_train$DJ <- as.factor(party_train$DJ)

#sample size 80% of training set
sample_size <- floor(0.8 * nrow(party_train))
train_indices <- sample(seq_len(nrow(party_train)), size = sample_size)

#split into testing and training dataset for random forest model
train_data <- party_train[train_indices, ]
test_data <- party_train[-train_indices, ]

#tuneRF which checks mtry values and their OOB error
  #mtry = 1  --> 0.07500  
  #mtry = 2  --> 0.00049
  #mtry = 4  --> 0.00021
  #mtry = 8  --> 0.00020
  #mtry = 16 --> 0.00020
  #mtry = 0  --> 0.08118
set.seed(42)
tuneRF(train_data[, -ncol(train_data)], train_data$Rating,
       stepFactor = 0.5,
       improve = 0.05,
       ntreeTry = 500,
       trace = TRUE,
       plot = TRUE)

# Manual tuning step - I Ran tuneRF and observed the suggested best mtry value from the output
best_mtry <- 8

# Train a new Random Forest model using the observed best mtry value (4, 8, or 16)
rf_model_optimized <- randomForest(Rating ~ ., data = train_data, ntree = 500, mtry = best_mtry)

# Predict on the test set with the optimized model
predictions_optimized <- predict(rf_model_optimized, newdata = test_data)

# Calculate RMSE for the optimized model
rmse_optimized <- sqrt(mean((predictions_optimized - test_data$Rating)^2))
print(paste("Optimized RMSE:", rmse_optimized))

#check my predictions compared to the actual
    #performing the eye test
#predictions_optimized_rounded <- round(predictions_optimized, 2)
#predictions_optimized_rounded
#test_data$RatingsPre <- predictions_optimized_rounded

#run same prediction on test data
party_submission <- read.csv("C:\\Users\\alexm\\Downloads\\PartyTest-Students.csv")

#same factor of columns
party_submission$Music <- as.factor(party_submission$Music)
party_submission$Day <- as.factor(party_submission$Day)
party_submission$DJ <- as.factor(party_submission$DJ)

# Ensure that the factor levels match the training data
party_submission$Music <- factor(party_submission$Music, levels = levels(train_data$Music))
party_submission$Day <- factor(party_submission$Day, levels = levels(train_data$Day))
party_submission$DJ <- factor(party_submission$DJ, levels = levels(train_data$DJ))

#same prediction
party_submission_predictions <- predict(rf_model_optimized, newdata = party_submission)

#make Rating column for predictions
party_submission$Rating <- round(party_submission_predictions, 2)

write.csv(party_submission, "C:/R/Prediction Challenge/3/submission.csv", row.names=FALSE)

#value   RMSE
#mtyr4:  0.0228769952867569
#mtyr8:  0.0237306087073216
#mtyr16: 0.0200825461248902
         #.00868781534912897