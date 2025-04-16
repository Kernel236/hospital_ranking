# Best function 
###########################################################################
# Function to calculate the best hospital for Heart attack mortality rate

best <- function(state, outcome) {
  # Read the data
  dataset_outcome <- read.csv(
    here::here("data", "outcome-of-care-measures.csv"), colClasses = "character"
  )
  
  # Check if the state is valid
  if (!state %in% dataset_outcome$State) {
    stop("Invalid state: States are reported with double capital letters. Please check your input.")
  }
  
  # Check if the outcome is valid
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("Invalid outcome: heart attack, heart failure, pneumonia are valid outcomes. Please check your input.")
  }
  
  # Filter the data for the specified state and outcome
  filtered_data <- dataset_outcome[dataset_outcome$State == state, ]
  
  # Convert the relevant columns to numeric
  if (outcome == "heart attack") {
    outcome_col <- 11
  } else if (outcome == "heart failure") {
    outcome_col <- 17
  } else if (outcome == "pneumonia") {
    outcome_col <- 23
  }
  
  # Get the best hospital for heart attack mortality rate
  best_hospital <- filtered_data[which.min(filtered_data[, outcome_col]), "Hospital.Name"]
  
  return(best_hospital)
}


##########################################################################
# try it out #
#best("TX", "heart attack")
#best("TX", "heart failure")
#best("MD", "heart attack")
#best("TX", "pneumonia")

##################Test function error handling############################
#best("AAA", "heart attack") #Should output invalid state
#best("TX", "Dizziness") #Should output invalid outcome
