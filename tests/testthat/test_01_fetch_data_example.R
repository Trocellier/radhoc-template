# tests/testthat/test_01_fetch_data_example.R ------------------------------- #
# Author: Louis Trocellier
# Description: Unit tests for 01_fetch_data_example functions.

test_that("fetch_data_settings returns valid default configuration", {
  settings <- fetch_data_settings()

  expect_type(settings, "list")
  expect_named(settings, c("data_source", "max_records"))
  expect_equal(settings$data_source, "raw_sample")
  expect_equal(settings$max_records, 1000)
})

test_that("fetch_data_execution returns a non-empty data.frame with expected structure", {
  settings <- fetch_data_settings()
  df <- fetch_data_execution(settings)

  expect_s3_class(df, "data.frame")
  expect_equal(nrow(df), 10)
  expect_named(df, c("id", "timestamp", "value"))
  expect_type(df$id, "integer")
  expect_type(df$value, "double")
})
