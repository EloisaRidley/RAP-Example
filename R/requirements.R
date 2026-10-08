
# Install dependencies ----------------------------------------------------
# Update to use `pak` when IT bug fixed
if (!requireNamespace("librarian")) install.packages("librarian", quiet = TRUE)

requirements <- c(
  "DataS-DHSC/DHSClogger",
  "yaml"
)

# use suppress to prevent build warnings
suppressWarnings(librarian::stock(requirements))
