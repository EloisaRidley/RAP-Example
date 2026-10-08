
library(dplyr)
library(purrr)
library(httr2)
library(readr)

# ensure logger
logger <- if (!exists("logger")) DHSClogger::get_dhsc_logger() else logger

#' Get ONS data catalogue
#'
#' Return a tibble with the API's data catalogue from the URL.
#'
#' @param data_catalogue_url URL of ONS data catalogue.
#'
#' @return Catalogue of items with title, id, and latest link.
#'
download_ons_api_data_catalogue <- function(data_catalogue_url) {
  logger$info(
    "Reading ONS data catalogue from %s",
    data_catalogue_url
  )

  data_catalogue_list <- data_catalogue_url |>
    request() |>
    req_perform() |>
    resp_body_json()

  get_catalogue_item <- function(x) {
    list(
      "id" = pluck(x, "id"),
      "title" = pluck(x, "title"),
      "href" = pluck(x, "links", "latest_version", "href")
    )
  }

  data_catalogue <- data_catalogue_list |>
    pluck("items") |>
    map(get_catalogue_item) |>
    bind_rows()

  return(data_catalogue)
}


#' Download a dataset from ONS
#'
#' Read a dataset from the API based on the catalogue.
#'
#' @param data_catalogue Catalogue of latest links to ONS datasets.
#' @param data_id Identifier of dataset to download.
#'
#' @return Downloaded dataset.
#'
download_ons_api_dataset <- function(data_catalogue, data_id) {
  data_url <- data_catalogue |>
    filter(id == data_id) |>
    pull(href) |>
    first()

  logger$info(
    "Downloading %s data from %s",
    data_id, data_url
  )

  data_info_list <- request(data_url) |>
    req_perform() |>
    resp_body_json()

  raw_data <- data_info_list |>
    pluck("downloads", "csv", "href") |>
    read_csv(
      col_types = cols(.default = col_character())
    )

  return(raw_data)
}