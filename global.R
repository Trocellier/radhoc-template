# global.R ------------------------------------------------------------------- #
# Author: Louis Trocellier
# Description: Load packages, project configuration, logging, and helper functions.

# Packages ------------------------------------------------------------------- #
library(dotenv)
library(config)
library(logger)
library(dplyr)
library(purrr)
library(here)

# Environment & Configuration ----------------------------------------------- #
# Load environment variables from .env if present
env_file <- here::here(".env")
if (file.exists(env_file)) {
  dotenv::load_dot_env(env_file)
}

# Map APP_ENV from .env to R_CONFIG_ACTIVE for the config package
if (Sys.getenv("APP_ENV") != "") {
  Sys.setenv(R_CONFIG_ACTIVE = Sys.getenv("APP_ENV"))
}

cfg <- config::get(file = here::here("config.yml"))

# Sourcing Functions -------------------------------------------------------- #
source_dossier <- function(chemin, envir = .GlobalEnv, pattern = "\\.[Rr]$") {
  fichiers <- list.files(chemin, pattern = pattern, full.names = TRUE)
  invisible(lapply(fichiers, function(fichier) {
    source(fichier, local = envir)
  }))
}

source_dossier(here::here(cfg$paths$functions))