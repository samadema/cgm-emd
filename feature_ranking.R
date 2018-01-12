#The example below loads the Pima Indians Diabetes dataset and constructs an Learning Vector Quantization(LVQ) model. 
#The varImp is then used to estimate the variable importance, which is printed and plotted. It shows that the glucose, 
#mass and age attributes are the top 3 most important attributes in the dataset and the insulin attribute is the least important

# ensure results are repeatable
set.seed(7)
# load the library
library(mlbench)
library(caret)
# load the dataset

df_cgmEMD <- read.csv('cgmEMD.csv')
df_cgmEMD <- data.frame(df_cgmEMD)

#df_cgmEMD = subset(df_nhanes, select = -c(LBDLDL, LBDLDLSI, LBDTRSI, LBXTR, BMXSAD1, BMXARMC, SEQN, BMXWT, RIDAGEMN, BPXCHR, PAQ706, PAQ722, PAQ677)) #drop cols BMXSAD1,BMXARMC, due to hi corr and RIDAGEMN, BPXCHR, PAQ706, PAQ722, PAQ677 due to zero/near zero variance

#df_cgmEMD2 = subset(df_cgmEMD, select = c(meanFreq_IMF1, bandPower_IMF1, period_IMF1, freq_IMF1, AngularFreq_IMF1, mean_IMF2, std_IMF2, MAGE_Category))



#df_cgmEMD2 = subset(df_cgmEMD, select = c(MAGE_Category, ApEn_X, SampEn_X, meanFreq_X, bandPower_X, meanIMF1, stdIMF1, ApEn_IMF1, SampEn_IMF1, meanFreq_IMF1, bandPower_IMF1, period_IMF1, freq_IMF1, AngularFreq_IMF1, mean_IMF2, std_IMF2, ApEn_IMF2, SampEn_IMF2, meanFreq_IMF2, bandPower_IMF2, period_IMF2, freq_IMF2, AngularFreq_IMF2, mean_IMF3, std_IMF3, ApEn_IMF3, SampEn_IMF3, meanFreq_IMF3, bandPower_IMF3, period_IMF3, freq_IMF3, AngularFreq_IMF3, mean_IMF4, std_IMF4, ApEn_IMF4, SampEn_IMF4, meanFreq_IMF4, bandPower_IMF4, period_IMF4, freq_IMF4, AngularFreq_IMF4, mean_IMF5, std_IMF5, ApEn_IMF5, SampEn_IMF5, meanFreq_IMF5, bandPower_IMF5, period_IMF5, freq_IMF5, AngularFreq_IMF5))


df_cgmEMD2 = subset(df_cgmEMD, select = c(MAGE_Category, meanFreq_X, std_IMF3, bandPower_IMF3, stdIMF1, bandPower_IMF1, bandPower_IMF2, std_IMF2, bandPower_IMF4, std_IMF4, ApEn_X, meanFreq_IMF1, period_IMF3, AngularFreq_IMF3, freq_IMF3, mean_IMF2, std_IMF5, freq_IMF2, period_IMF2, AngularFreq_IMF2, SampEn_IMF3))


# mean_IMF6, std_IMF6, ApEn_IMF6, SampEn_IMF6, meanFreq_IMF6, bandPower_IMF6, period_IMF6, freq_IMF6, AngularFreq_IMF6

df_cgmEMD2 = data.frame(df_cgmEMD2)



View(df_cgmEMD)

df_cgmEMD2$MAGE_Category <- as.factor(df_cgmEMD2$MAGE_Category) # converts LDLRISK to categorical variable


# prepare training scheme
control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)


# train the model
model <- train(MAGE_Category ~ ., data = df_cgmEMD2, method = "lvq", preProcess = "scale", trControl = control, na.action = na.exclude)

# estimate variable importance
importance <- varImp(model, scale = FALSE)
# summarize importance
print(importance)
# plot importance
plot(importance)