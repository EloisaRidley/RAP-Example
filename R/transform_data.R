
library(dplyr)

#' Transform data
#'
#' Filter data by industry and growth metric removing NAs.
#' Then, tidy and sort.
#'
#' @param raw_data Raw data to be transformed.
#' @param industry_filter Industry of interest.
#' @param growth_rate_filter Growth rate of interest.
#'
#' @return Transformed data.
#'
transform_data <- function(raw_data, industry_filter, growth_rate_filter) {
  raw_data |>
    mutate(
      value = as.numeric(v4_1),
      year = as.numeric(Time),
    ) |>
    rename(
      geography = Geography,
      industry = UnofficialStandardIndustrialClassification,
      growth_rate = GrowthRate
    ) |>
    select(value, year, geography, industry, growth_rate) |>
    filter(
      !is.na(value),
      industry == industry_filter,
      growth_rate == growth_rate_filter
    ) |>
    arrange(geography, year)
}