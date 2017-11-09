library(h2o)

h2o.init(max_mem_size = "16g")

train <- h2o.importFile("data/train.csv")
test <- h2o.importFile("data/test.csv")

train$target <- as.factor(train$target)

y <- "target"
features <- h2o.colnames(train)[!h2o.colnames(train) %in% c("id","target")]

model <- h2o.automl(x = features,
                    y = y,
                    training_frame = train,
                    max_runtime_secs = 60*60*7)

preds <- h2o.predict(model, newdata = test)
test$target <- preds$p1

h2o.exportFile(test[c("id","target")], path = "data/submission_aml.csv")
