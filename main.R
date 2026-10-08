

# Install dependencies ----------------------------------------------------
source(file.path("R", "requirements.R"))


# Read secrets ------------------------------------------------------------
if (file.exists(".Renviron")) readRenviron(".Renviron")


# Read in configuration ---------------------------------------------------
config_path <- file.path("input", "config.yaml")
config <- yaml::read_yaml(config_path)

config["time_stamp"] <- format(Sys.Date(), "%Y%m%d")


# Setup logging -----------------------------------------------------------
logger <- DHSClogger::get_dhsc_logger()
logger$set_threshold("log.console", "INFO")


# Run code ----------------------------------------------------------------
logger$info("[Running...]")

print("Hello world!")

logger$info("[...Finished]")


# Save config -------------------------------------------------------------
file.copy(
  config_path,
  file.path("output", sprintf("%s_config.yaml", config["time_stamp"])),
  overwrite = TRUE
)
