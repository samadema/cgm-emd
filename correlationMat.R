# ensure the results are repeatable
set.seed(7)
# load the library
library(mlbench)
library(caret)
# load the data


df_cgmEMD <- read.csv('cgmEMD.csv')
df_cgmEMD <- data.frame(df_cgmEMD)

#data(PimaIndiansDiabetes)

# calculate correlation matrix
correlationMatrix <- cor(df_cgmEMD[, 2:70])
# summarize the correlation matrix
print(correlationMatrix)
# find attributes that are highly corrected (ideally >0.75)
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff > 0.75)
# print indexes of highly correlated attributes
print(highlyCorrelated)