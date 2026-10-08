# Install dependencies ----------------------------------------------------
source(file.path("R", "requirements.R"))
source(file.path("R", "run_analysis.R"))

# Read secrets ------------------------------------------------------------
if (file.exists(".Renviron")) readRenviron(".Renviron")


# Read in configuration ---------------------------------------------------
config_path <- file.path("input", "config.yaml")
config <- yaml::read_yaml(config_path)

config["time_stamp"] <- format(Sys.Date(), "%Y%m%d")


# Setup logging -----------------------------------------------------------
logger <- DHSClogger::get_dhsc_logger()
logger$set_threshold("log.console", "INFO")


# Run analysis ------------------------------------------------------------
logger$info("[Running...]")
run_analysis(config)

# Save config -------------------------------------------------------------
file.copy(
  config_path,
  file.path(config$output_dir, sprintf("%s_config.yaml", config["time_stamp"])),
  overwrite = TRUE
)

logger$info("[...Finished]")
