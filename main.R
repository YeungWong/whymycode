# Please enter your directories below
setwd("C:/Users/YeunG WonG/Google Drive/Hackathon/Prediction Model/Model")

message("Generating common features on dataset")
source("CommonFeatureGen.R")

message("Generating common features on customers")
source("CustCommonFeaturesGen.R")