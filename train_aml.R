library(h2o)
source("preprocess.R")

h2o.init(max_mem_size = "16g")

train <- h2o.importFile("data/train.csv")
test <- h2o.importFile("data/test.csv")

train <- preprocess(train)
test <- preprocess(test)

features <- setdiff(h2o.colnames(train), c("target", "id"))

model <- h2o.automl(x = features,
                    y = "target",
                    training_frame = train,
                    max_runtime_secs = 60*60*7)

preds <- h2o.predict(model, newdata = test)
test["target"] <- preds["p1"]

h2o.exportFile(test[c("id","target")], path = "data/submission_aml.csv")
