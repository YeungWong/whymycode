message("--------Feature engineering on dataset--------")
rm(list=ls())
QN <- read.csv(file="Cost Composition - Combined_CL_FInalv2.csv", header=TRUE )
names(QN)[1]<-"ID"
QcommonFeatrues <- QN[, c("ID")]
QcommonFeatrues <- as.data.frame(QcommonFeatrues)
colnames(QcommonFeatrues)[1] <- "ID"

#----Category
QcommonFeatrues <- cbind(QcommonFeatrues, "Category" = QN$Category)

#----Gender
QcommonFeatrues <- cbind(QcommonFeatrues, "Gender" = QN$Gender)

#------Origin
QcommonFeatrues <- cbind(QcommonFeatrues, "Origin" = QN$Origin)

#----Fabric_Cost
QcommonFeatrues <- cbind(QcommonFeatrues, "Fabric_Cost" = QN$Fabric_Cost)

#----CM_Cost
QcommonFeatrues <- cbind(QcommonFeatrues, "CM_Cost" = QN$CM_Cost)

#----Trim_Cost
QcommonFeatrues <- cbind(QcommonFeatrues, "Trim_Cost" = QN$Trim_Cost)

#----Art_Cost
QcommonFeatrues <- cbind(QcommonFeatrues, "Art_Cost" = QN$Art_Cost)

#----Wash_Cost
QcommonFeatrues <- cbind(QcommonFeatrues, "Wash_Cost" = QN$Wash_Cost)

#----Other_Cost
QcommonFeatrues <- cbind(QcommonFeatrues, "Other_Cost" = QN$Other_Cost)

#----Total_Cost
QcommonFeatrues <- cbind(QcommonFeatrues, "Total_Cost" = QN$Total_Cost)

#----Season
QcommonFeatrues <- cbind(QcommonFeatrues, "Season" = QN$Season)

#---------write out the results---------
write.table(x=QcommonFeatrues, file="CommonFeatures.csv", sep=",", col.names=TRUE, row.names =FALSE)

message("Features are output into: CommonFeatures.csv")
message("--------Feature engineering on Questionnaire dataset is done--------")