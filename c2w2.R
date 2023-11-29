pollutantmean <- function(directory, pollutant, id=1:332) {
  pollutant_values <- numeric()
  # Loop through each ID in the provided vector
  for (monitor_id in id) {
    # Construct the file path for the CSV file
    file_path <- file.path(directory, paste("", formatC(monitor_id, width = 3, flag = "0"), ".csv", sep = ""))
    
    # Read the data from the CSV file
    monitor_data <- read.csv(file_path)
    
    # Extract the pollutant values for the specified pollutant
    pollutant_values <- c(pollutant_values, monitor_data[[pollutant]])
  }
  
  # Calculate the mean of the pollutant values, ignoring NA values
  mean_pollutant <- mean(pollutant_values, na.rm = TRUE)
  
  return(mean_pollutant)
  
}

pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "sulfate", 34)
pollutantmean("specdata", "nitrate")


complete <- function(directory, id=1:332) {
  
  monitor_ids <- numeric()
  complete_case_counts <- numeric()
  
  # Loop through each ID in the provided vector
  for (monitor_id in id) {
    # Construct the file path for the CSV file
    file_path <- file.path(directory, paste("", formatC(monitor_id, width = 3, flag = "0"), ".csv", sep = ""))
    
    # Read the data from the CSV file
    monitor_data <- read.csv(file_path)
    
    # Count the number of complete cases and store the results
    complete_cases_count <- sum(complete.cases(monitor_data))
    monitor_ids <- c(monitor_ids, monitor_id)
    complete_case_counts <- c(complete_case_counts, complete_cases_count)
  }
  
  # Create a data frame with monitor IDs and complete case counts
  result_df <- data.frame(id = monitor_ids, nobs = complete_case_counts)
  
  return(result_df)
}

cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)
cc <- complete("specdata", 54)
print(cc$nobs)

corr <- function(directory, threshold=0) {
  # Get a list of all files in the specified directory
  files <- list.files(directory, full.names = TRUE)
  
  # Initialize an empty vector to store correlation values
  correlations <- numeric()
  
  # Loop through each file in the directory
  for (file in files) {
    # Read the data from the file
    data <- read.csv(file)
    
    if ("sulfate" %in% colnames(data) && "nitrate" %in% colnames(data)) {
      # Check if the number of complete cases is greater than the threshold
      if (sum(complete.cases(data)) > threshold) {
        # Calculate the correlation between sulfate and nitrate
        correlation <- cor(data$sulfate, data$nitrate, use = "complete.obs")
        
        # Store the correlation value
        correlations <- c(correlations, correlation)
      }
    }
  }
  
  # Return the vector of correlation values
  return(correlations)
  
}
cr <- corr("specdata")                
cr <- sort(cr)   
RNGversion("3.5.1")
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)
