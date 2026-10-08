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

  data_time_series <- raw_data |>
    transform_data(config$industry, config$growth_rate)

  data_time_series |>
    write_output(file.path(config$output_dir, config$data_file_name))

  plt <- data_time_series |>
    plot_timeseries_chart(
      config$chart_title,
      config$highlight_geography,
      config$chart_duration
    )

  plt |>
    save_timeseries_chart(
      file.path(config$output_dir, sprintf("%s.png", config$chart_file_name))
    ) |>
    save_timeseries_chart(
      file.path(config$output_dir, sprintf("%s.svg", config$chart_file_name))
    )

  print(plt)

}