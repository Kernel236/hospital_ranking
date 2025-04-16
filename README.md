# Hospital Ranking

This project is part of the **Programming Assignment** from the course *R Programming for Data Science*. The goal is to analyze and rank hospitals in the United States based on 30-day mortality rates for three medical conditions: heart attack, heart failure, and pneumonia.

The data is sourced from the [Hospital Compare website](http://hospitalcompare.hhs.gov), maintained by the U.S. Department of Health and Human Services.

## Project Structure

The GitHub repository is organized as follows:

hospital_ranking/ │

├── README.md \# Project overview and instructions

├── Hospital_Revised_Flatfiles.pdf \# Codebook with variable descriptions │

├── data/ \# Folder containing the original datasets │ ├── outcome-of-care-measures.csv │ └── hospital-data.csv │

└── code/ \# R scripts for analysis and custom functions

## Objectives

### 1. **Plotting 30-Day Mortality Rates for Heart Attack**

-   Load and inspect the dataset using `read.csv()`.
-   Convert the target column to numeric to handle mortality rates.
-   Generate a histogram to visualize the distribution of rates.

### 2. **Function: `best(state, outcome)`**

-   Returns the hospital with the **lowest** 30-day mortality rate for a specific outcome in a given state.
-   Validates input parameters:
    -   Returns `"invalid state"` for unrecognized state abbreviations.
    -   Returns `"invalid outcome"` for unsupported outcomes.
-   Handles ties by returning the first hospital in **alphabetical order**.

### 3. **Function: `rankhospital(state, outcome, num)`**

-   Returns the hospital that ranks at position `num` for the specified outcome in a state.
-   Supports:
    -   `"best"`: lowest mortality rate
    -   `"worst"`: highest mortality rate
    -   A positive integer for a specific rank
-   Ties are broken alphabetically by hospital name.

### 4. **Function: `rankall(outcome, num)`**

-   Returns a **data frame** listing the hospital of the given rank for the specified outcome in **every** U.S. state.
-   Works similarly to `rankhospital()` but processes **all states**.
-   Handles `"best"`, `"worst"`, or numeric ranking inputs.
-   Does **not** call `rankhospital()` internally for performance reasons.

## Requirements

-   R (latest version recommended)
-   Uses only base R (no additional packages required)

## Notes

-   The CSV files must be located in the `data/` folder.

-   Use the `Hospital_Revised_Flatfiles.pdf` to understand variable definitions, especially for **Table 19** and **Table 11**.

    Each function should be tested by sourcing the file in R:

    ```         
    source("code/best.R") best("TX", "heart attack")
    ```
