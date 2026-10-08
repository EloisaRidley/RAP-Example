library(dplyr)
library(ggplot2)

# ensure logger
logger <- if (!exists("logger")) DHSClogger::get_dhsc_logger() else logger

#' Create a timeseries chart
#'
#' Creates a scatter graph of year against annual growth rate with a
#' particular geography highlighted as a line.
#'
#' @param data_ts Time series data to plot.
#' @param chart_title Overall title for plot.
#' @param highlight_geography Geography to highlight with line.
#' @param chart_duration Number of historical years to plot.
#'
#' @return ggplot object of data.
#'
plot_timeseries_chart <- function(
    data_ts,
    chart_title,
    highlight_geography,
    chart_duration
) {
  logger$info("Creating plot %s", chart_title)

  max_year <- max(data_ts$year)
  min_year <- max(max_year - chart_duration, min(data_ts$year))

  plt <- ggplot() +
    geom_line(
      data = data_ts |> filter(geography == highlight_geography),
      aes(x = year, y = value, colour = geography),
      linewidth = 1
    ) +
    geom_point(
      data = data_ts,
      aes(x = year, y = value, colour = geography),
      size = 3
    ) +
    labs(
      title = chart_title,
      subtitle = sprintf("%s, %d-%d", highlight_geography, min_year, max_year),
      x = "Year",
      y = "Annual growth rate (%)"
    ) +
    afcharts::theme_af() +
    scale_x_continuous(breaks = seq(min_year, max_year, 1))

  return(plt)
}


#' Save a chart
#'
#' Save chart with sensible defaults for embedding in PowerPoint.
#'
#' @param plt Time series plot object.
#' @param output_path File to write the plot to.
#'
#' @return ggplot object of data.
#'
save_timeseries_chart <- function(
    plt,
    output_path
) {
  logger$info("Saving plot to %s", output_path)

  ggsave(
    output_path,
    plot = plt,
    height = 8.3,
    width = 11.7,
    units = "in",
    dpi = 300
  )

  return(plt)
}