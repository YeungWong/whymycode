#########################################################################################
# Description: This file is to generate common features in Customer Input
#########################################################################################

# Setup enviroment
if(!require(base)) install.packages("base")
library(base)
if(!require(openxlsx)) install.packages("openxlsx")
library(openxlsx)
if(!require(Matrix)) install.packages("Matrix")
library(Matrix)
if(!require(plyr)) install.packages("plyr")
library(plyr)

rm(list=ls())

Data <- read.csv(file="CommonFeatures.csv", header=TRUE )

message("Loading the demostration data.")
# Read in full input
CS = read.table(file = paste0("sequel.txt"), header = TRUE, sep = "\t", as.is =TRUE, encoding = "UTF-8",
                colClasses=c(rep("character", 5)))
names(CS)[1] <- "Category"

Category = CS[,'Category']
Data <- Data[Data$Category == Category,]

Gender = CS[,'Gender']
Data <- Data[Data$Gender == Gender,]

Material = CS[,'Material']
# Not-complete
#Data <- Data[Data$Material == Material,]

Type = CS[,'Type']
# Not-complete
#Data <- Data[Data$Type ==Type,]

SEASON <- read.table(file = "Season_mapping.txt", 
                         header = TRUE, sep = "\t", as.is =TRUE, encoding="UTF-8")
names(SEASON)[1] <- "Season"
Sea = CS[,'Season']
Sea = matrix(Sea)
Csea = matrix(SEASON[,1]);
Cvalue = matrix(SEASON[,2]);
Cvalue = as.numeric(Cvalue)
f_seamap = function(sea){
  idx = which(Csea==sea)
  if (length(idx)==0)  return('0')   # "Missing value" is '0'
  else return(Cvalue[idx])
} 
# Use in later step
Season = apply(Sea,1,f_seamap)

#Origin <- data.frame(unique(Data$Origin))
#names(Origin)[1] <- "Origin"
#Row_Origin <- nrow(Origin)

Origin <- aggregate(Data[, 5:11], list(Data$Origin),mean)
names(Origin)[1] <- "Origin"

#mapping_Art_Cost <- data.frame(unique(Data$Art_Cost))
#mapping_Art_Cost <- cbind(mapping_Art_Cost, rank(mapping_Art_Cost))
#Data <- cbind(Data, rank_Art_Cost=rank(Data$Art_Cost))

Origin_name <- data.frame(Origin[,1])
names(Origin_name)[1] <- "Origin"
Origin <- Origin[,-1]
Origin_Sum <- colSums(Origin)
Fabric_Cost <- round(Origin[,1],1)
CM_Cost <- round(Origin[,2],1)
Trim_Cost <- round(Origin[,3],1)
Art_Cost <- round(Origin[,4],1)
Wash_Cost <- round(Origin[,5],1)
Other_Cost <- round(Origin[,6],1)
Origin_Cost <- round(Origin[,7],1)
Fabric_Cost_Index = data.frame(round(((1 - (Origin[,1] / Origin_Sum[1])) * 10),1))
CM_Cost_Index = data.frame(round(((1 - (Origin[,2] / Origin_Sum[2])) * 10),1))
Trim_Cost_Index = data.frame(round(((1 - (Origin[,3] / Origin_Sum[3])) * 10),1))
Art_Cost_Index = data.frame(round(((1 - (Origin[,4] / Origin_Sum[4])) * 10),1))
Wash_Cost_Index = data.frame(round(((1 - (Origin[,5] / Origin_Sum[5])) * 10),1))
Other_Cost_Index = data.frame(round(((1 - (Origin[,6] / Origin_Sum[6])) * 10),1))
Total_Cost_Index = data.frame(round(((1 - (Origin[,7] / Origin_Sum[7])) * 10),1))

Origin_Result <- cbind(Origin_name,Fabric_Cost_Index)
names(Origin_Result)[2] <- "Fabric_Cost_Index"

Origin_Result <- cbind(Origin_Result,CM_Cost_Index)
names(Origin_Result)[3] <- "CM_Cost_Index"

Origin_Result <- cbind(Origin_Result,Trim_Cost_Index)
names(Origin_Result)[4] <- "Trim_Cost_Index"

Origin_Result <- cbind(Origin_Result,Art_Cost_Index)
names(Origin_Result)[5] <- "Art_Cost_Index"

Origin_Result <- cbind(Origin_Result,Wash_Cost_Index)
names(Origin_Result)[6] <- "Wash_Cost_Index"

Origin_Result <- cbind(Origin_Result,Other_Cost_Index)
names(Origin_Result)[7] <- "Other_Cost_Index"

Origin_Result <- cbind(Origin_Result,Total_Cost_Index)
names(Origin_Result)[8] <- "Production_Cost_Index"

Origin_Result <- cbind(Origin_Result,Origin_Cost)
names(Origin_Result)[9] <- "Origin_Cost"

Origin_Result <- cbind(Origin_Result,Fabric_Cost)
names(Origin_Result)[10] <- "Fabric_Cost"

Origin_Result <- cbind(Origin_Result,CM_Cost)
names(Origin_Result)[11] <- "CM_Cost"

Origin_Result <- cbind(Origin_Result,Trim_Cost)
names(Origin_Result)[12] <- "Trim_Cost"

Origin_Result <- cbind(Origin_Result,Art_Cost)
names(Origin_Result)[13] <- "Art_Cost"

Origin_Result <- cbind(Origin_Result,Wash_Cost)
names(Origin_Result)[14] <- "Wash_Cost"

Origin_Result <- cbind(Origin_Result,Other_Cost)
names(Origin_Result)[15] <- "Other_Cost"

cotton <- read.csv(file="Cotton Prices by Index_vF.csv", header=TRUE )

# Write all output into a file
write.csv(Origin_Result, file = paste0("Result.csv"), row.names=FALSE)


