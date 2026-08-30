# 01_fetch_data.R ----------------------------------------------------------- #
# Author: Louis Trocellier
# Description: Helper functions for data fetching step.

#' Define parameters for fetching data
fetch_data_settings <- function() {
  list(
    data_source = "raw_sample",
    max_records = 1000
  )
}

#' Execute data retrieval
fetch_data_execution <- function(settings) {
  log_debug("Fetching records from source: {settings$data_source}")
  
  # Placeholder for actual data retrieval (DB query, API call, CSV read)
  data <- data.frame(
    id = 1:10,
    timestamp = Sys.time(),
    value = runif(10, 10, 100)
  )
  
  return(data)
}

#' Save fetched data to intermediate storage
fetch_data_exports <- function(data) {
  output_path <- file.path(cfg$paths$data, "01_raw_data.rds")
  saveRDS(data, file = output_path)
  log_debug("Raw data saved to: {output_path}")
}