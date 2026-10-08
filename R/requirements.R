
# Install dependencies ----------------------------------------------------
# Update to use `pak` when IT bug fixed
if (!requireNamespace("librarian")) install.packages("librarian", quiet = TRUE)

requirements <- c(
  "DataS-DHSC/DHSClogger",
  "yaml",
  "readr",
  "httr2",
  "purrr",
  "dplyr",
  "ggplot2",
  "afcharts"
)

# use suppress to prevent build warnings
suppressWarnings(librarian::stock(requirements))
