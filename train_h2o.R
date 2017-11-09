library(h2o)

h2o.init(max_mem_size = "16g")

train <- h2o.importFile("data/train.csv")
test <- h2o.importFile("data/test.csv")

train$target <- as.factor(train$target)

y <- "target"
features <- h2o.colnames(train)[!h2o.colnames(train) %in% c("id","target")]

model <- h2o.gbm(x = features,
                 y = y,
                 training_frame = train,
                 nfolds = 5,
                 ntrees = 500,
                 stopping_metric = "auc",
                 stopping_rounds = 5,
                 learn_rate = 0.01)

preds <- h2o.predict(model, newdata = test)
test$target <- preds$p1

h2o.exportFile(test[c("id","target")], path = "data/submission_h2o.csv")
