
# ensure logger
logger <- if (!exists("logger")) DHSClogger::get_dhsc_logger() else logger

#' Write data to csv
#'
#' This is probably overkill but nice for logging and if you wanted
#' any consistent behaviour e.g. date formatting.
#'
#' @param data Data to write to file.
#' @param output_path Path of csv file to write to.
#'
write_output <- function(data, output_path) {
  logger$info("Writing outputs to %s", output_path)
  readr::write_csv(data, output_path)
}