preprocess <- function(data) {
  # input: h2o data frame
  # output: processed frame
  
  colnames <- h2o.colnames(data)
  
  # encode missing values
  for (f in colnames) {
    data[data[f] == -1, f] <- NA
  }
  
  # set data types 
  if ("target" %in% colnames) {
    data["target"] <- h2o.asfactor(data["target"])
  }
    
  cats <- colnames[grepl("_cat", colnames, fixed = TRUE)]
  
  for (f in cats) {
    data[f] <- h2o.asfactor(data[f])
  }
  
  # cols to exclude from frame
  exclude <- c("")

  return(data[setdiff(colnames, exclude)])
  
}

