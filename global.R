# global.R ------------------------------------------------------------------- #
# Author: Louis Trocellier
# Description: Load packages, project configuration, logging, and helper functions.

# Packages ------------------------------------------------------------------- #
library(dotenv)
library(config)
library(logger)
library(dplyr)
library(purrr)

# Environment & Configuration ----------------------------------------------- #
# Load environment variables from .env if present
if (file.exists(".env")) {
  dotenv::load_dot_env(".env")
}

# Map APP_ENV from .env to R_CONFIG_ACTIVE for the config package
if (Sys.getenv("APP_ENV") != "") {
  Sys.setenv(R_CONFIG_ACTIVE = Sys.getenv("APP_ENV"))
}

cfg <- config::get()
env_app <- environment()

# Logging Setup ------------------------------------------------------------- #
# Set log threshold dynamically based on configuration (INFO, WARN, etc.)
log_threshold(cfg$logging$level)

# Configure file logging if enabled
if (isTRUE(cfg$logging$log_to_file)) {
  log_dir <- cfg$paths$logs %||% "logs"
  if (!dir.exists(log_dir)) dir.create(log_dir, recursive = TRUE)
  
  # appender_tee logs to both console and file simultaneously
  log_appender(appender_tee(file.path(log_dir, "pipeline.log")))
}

# Sourcing Functions -------------------------------------------------------- #
source_dossier <- function(chemin, envir = env_app, pattern = "\\.[Rr]$") {
  fichiers <- list.files(chemin, pattern = pattern, full.names = TRUE)
  invisible(lapply(fichiers, function(fichier) {
    sys.source(fichier, envir = envir, keep.source = TRUE)
  }))
}

source_dossier(cfg$paths$functions)