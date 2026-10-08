source(file.path("R", "ons_api_data.R"))
source(file.path("R", "write_output.R"))
source(file.path("R", "transform_data.R"))
source(file.path("R", "timeseries_chart.R"))

# ensure logger
logger <- if (!exists("logger")) DHSClogger::get_dhsc_logger() else logger

#' Run analysis
#'
#' @param config The configuration used in the analysis.
#'
run_analysis <- function(config) {
  data_catalogue <- download_ons_api_data_catalogue(config$data_catalogue_url)

  raw_data <- download_ons_api_dataset(data_catalogue, config$data_id)

  raw_data |>
    write_output(
      file.path(config$output_dir, sprintf("%s.csv", config$data_id))
    )
}