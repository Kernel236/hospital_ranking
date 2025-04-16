# Import file 
library(readr)
library(dplyr)

#Read coulmns as character and change when use it
dataset_outcome <- read.csv(
  here::here("data", "outcome-of-care-measures.csv"), colClass = "character"
)

### HEART ATTACK ###
# Exctract the Heart attack mortality in overall databse.
dataset_outcome_heart_attack <- as.numeric(dataset_outcome[, 11])

#Histogram of mortality in heart attack 
hist(dataset_outcome_heart_attack, 
     main = "Histogram of Heart Attack Mortality Rate",
     xlab = "Heart Attack Mortality Rate",
     ylab = "Frequency",
     col = "steelblue",
     border = "black",
     breaks = 60)

### HEART FAILURE ###
# Exctract the Heart failure mortality in overall databse.
dataset_outcome_heart_failure <- as.numeric(dataset_outcome[, 17])

# Histogram of mortality in heart failure
hist(dataset_outcome_heart_failure, 
     main = "Histogram of Heart Failure Mortality Rate",
     xlab = "Heart Failure Mortality Rate",
     ylab = "Frequency",
     col = "steelblue",
     border = "black",
     breaks = 60)

###PNEUMONIA###
# Exctract the Pneumonia mortality in overall databse.
dataset_outcome_pneumonia <- as.numeric(dataset_outcome[, 23])

# Histogram of mortality in pneumonia
hist(dataset_outcome_pneumonia, 
     main = "Histogram of Pneumonia Mortality Rate",
     xlab = "Pneumonia Mortality Rate",
     ylab = "Frequency",
     col = "steelblue",
     border = "black",
     breaks = 60)

#Looking at the best hospital for a given disease in term of 30 days mortality rate
source("best.R")
best("SC", "heart attack")
best("NY", "pneumonia")
best("MD", "heart attack")
best("AK", "pneumonia")

#Looking at the best hospital for a given disease in term of 30 days mortality rate in a specific State
source("rankhospital.R")
rankhospital("NJ", "pneumonia", "worst")
rankhospital("NV", "heart failure", 10)  
rankhospital("NY", "heart attack", 7)
rankhospital("HI", "pneumonia", 4)

#Overall ranking for a given disease in terms of 30 days Mortality rate
source("rankall.R")
rankall("heart attack", 4)
rankall("heart failure", 4)  
rankall("heart attack", "worst")
rankall("pneumonia", "best")
head(rankall("heart attack", 20), 10)
sour

rankall("heart attack", 4)
