# Rankall funtion
####################################################################
# This function take two arguments:
# 1. outcome: a character string indicating the outcome
# 2. num: a character string indicating the ranking of the hospital
#return the name of the hospital with the specified rank in overall

library(dyplr)

rankall <- function(outcome, num = "best") {
  # Read the data
  dataset_outcome <- read.csv(
    here::here("data", "outcome-of-care-measures.csv"), colClasses = "character"
  )
  
  # Check if the outcome is valid
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("Invalid outcome: heart attack, heart failure, pneumonia are valid outcomes. Please check your input.")
  }
  
  ######################################################################################
  #####################################################################################
  #CONTINUA DA QUI......
  # Convert the relevant columns to numeric
  if (outcome == "heart attack") {
    outcome_col <- 11
    dataset_outcome[, outcome_col] <- as.numeric(dataset_outcome[, outcome_col])
    datset_outcome <- dataset_outcome |>
      rename(
        Hospital.Name = `Hospital.Name`,
        State = `State`
      )
  } else if (outcome == "heart failure") {
    outcome_col <- 17
  } else if (outcome == "pneumonia") {
    outcome_col <- 23
  }
  # Convert the outcome column to numeric
  dataset_outcome[, outcome_col] <- as.numeric(dataset_outcome[, outcome_col])
  
  #order data
  dataset_outcome <- dataset_outcome[order(dataset_outcome[, outcome_col], 
                                       dataset_outcome$Hospital.Name), ]
  
  # Remove rows with NA values in the outcome column
  dataset_outcome <- dataset_outcome[!is.na(dataset_outcome[, outcome_col]), ]
  
  # Create a new data frame with the hospital names and their ranks
  selected_data <- data.frame(
    Hospital.Name = dataset_outcome$Hospital.Name,
    rank = dense_rank(dataset_outcome[, outcome_col]),
    state = dataset_outcome$State
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
    hospital_list <- selected_data |>
      filter(rank == num)
  }
  
  return(hospital_list)
}

# Test the function
rankall("heart attack", 4)
rankall("heart failure", 4)  
rankall("heart attack", "worst")
rankall("pneumonia", "best")


#Test error handling
rankall("Dizziness", 4) #Should output invalid outcome
rankall("heart attack", 1000) #Should output NA (out of range)
head(rankall("heart attack", 20), 10)
tail(rankall("heart failure", "worst"), 3)
