
cat("\014")  # Clear console
rm(list=ls()) # Clear Workspace

message("Load in the dataset...")
Data <- read.csv(file="Cost Composition_Combined_VF.csv", header=TRUE )