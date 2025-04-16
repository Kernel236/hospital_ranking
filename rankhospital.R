# Rankhospital funtion
####################################################################
# This function take three arguments:
# 1. state: a two-character abbreviation for a state
# 2. outcome: a character string indicating the outcome
# 3. num: a character string indicating the ranking of the hospital
#return the name of the hospital with the specified rank in the specified state

rankhospital <- function(state, outcome, num = "best") {
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
  # Convert the outcome column to numeric
  filtered_data[, outcome_col] <- as.numeric(filtered_data[, outcome_col])
  
  #order data
  filtered_data <- filtered_data[order(filtered_data[, outcome_col], 
                                        filtered_data$Hospital.Name), ]
  
  # Remove rows with NA values in the outcome column
  filtered_data <- filtered_data[!is.na(filtered_data[, outcome_col]), ]
  
  # Create a new data frame with the hospital names and their ranks
  selected_data <- data.frame(
    Hospital.Name = filtered_data$Hospital.Name,
    rank = rank(filtered_data[, outcome_col], ties.method = "first"),
    outcome = filtered_data[, outcome_col]
  )
  
  #Rank to output
  
  if (num != "best" && num != as.numeric(num) && num != "worst") {
    stop("Invalid rank: Rank should be 'best' or a numeric value.")
  }
  
  if (num == "best") {
    num <- 1
  } else if (num == "worst") {
    num <- max(selected_data$rank)
  } else {
    num <- as.numeric(num) 
  }
  
  # Get the hospital name for the specified rank
  if (num > max(selected_data$rank)) {
    return(NA)
  } else {
    hospital_name <- selected_data[selected_data$rank == num, "Hospital.Name"]
  }
  
  return(hospital_name)
}
  
# Test the function
#rankhospital("TX", "heart attack", 4)
#rankhospital("TX", "heart failure", 4)  
#rankhospital("MD", "heart attack", "worst")
#rankhospital("TX", "pneumonia", "best")


#Test error handling
#rankhospital("AAA", "heart attack", 4) #Should output invalid state
#rankhospital("TX", "Dizziness", 4) #Should output invalid outcome
#rankhospital("MD", "heart attack", 1000) #Should output NA (out of range)
