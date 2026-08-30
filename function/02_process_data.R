# 02_process_data.R --------------------------------------------------------- #
# Author: Louis Trocellier
# Description: Helper functions for data processing step.

#' Define parameters for processing data
process_data_settings <- function() {
  list(
    input_file = file.path(cfg$paths$data, "01_raw_data.rds"),
    threshold = 50
  )
}

#' Execute data processing and transformations
process_data_execution <- function(settings) {
  log_debug("Reading raw data from: {settings$input_file}")
  raw_data <- readRDS(settings$input_file)
  
  log_debug("Applying transformations and filtering with threshold: {settings$threshold}")
  processed <- raw_data %>%
    dplyr::mutate(status = dplyr::if_else(value >= settings$threshold, "HIGH", "LOW")) %>%
    dplyr::arrange(dplyr::desc(value))
  
  return(processed)
}

#' Save processed data to intermediate storage
process_data_exports <- function(data) {
  output_path <- file.path(cfg$paths$data, "02_processed_data.rds")
  saveRDS(data, file = output_path)
  log_debug("Processed data saved to: {output_path}")
}