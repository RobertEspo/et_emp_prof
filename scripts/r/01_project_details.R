# Project details -------------------------------------------------------------
#
# Author: Robert Esposito & Alexander Rogers
#
# - This scripts provides a Gantt chart of the project timeline
#   and a CREDiT contributors plot
#
# -----------------------------------------------------------------------------

# Source libraries ------------------------------------------------------------

source(here::here("scripts", "r","00_libs.R"))

# -----------------------------------------------------------------------------

# Gantt char of project timeline ----------------------------------------------

# This is proof of concept, will change
time_line_df <- tribble(
  ~"wp",                ~"activity",             ~"start_date",  ~"end_date",
  "Preparation phase",  "Read literature",       "2024-11-11",   "2024-11-25",
  "Preparation phase",  "Write summaries",       "2024-11-11",   "2024-11-25",
  "Preparation phase",  "Write research Q's",    "2024-11-25",   "2024-11-30",
  "Preparation phase",  "Write hypotheses",      "2024-11-25",   "2024-11-30",
  "Preparation phase",  "Review hypotheses",     "2024-11-30",   "2024-12-7",
  "Preparation phase",  "Draft of methods",      "2024-11-30",   "2024-12-7",
  "Preparation phase",  "Make sample stimuli",   "2024-11-30",   "2024-12-7",
  "Prepration phase",   "Propose project",       "2024-12-7",    "2024-12-14"
)

# "Spots" can be used to mark when things actually occur on expected timeline
# Not used for now ("X" implies something is finished)
time_line_spots <- tribble(
  ~"activity",          ~"spot_type",    ~"spot_date", 
  "example",             "example",       "2024-11-28", 
)

# Generate plot 
p_project_timeline <- ganttrify(
  project = time_line_df,
  spots = time_line_spots,
  by_date = TRUE,
  exact_date = TRUE,
  size_text_relative = 1,
  month_number = FALSE,
  font_family = "Times")

# -----------------------------------------------------------------------------

# Contributors plot -----------------------------------------------------------

# Create df 
contributor_list <- list(
  "RE" = tibble(role = 1:14, weight = "high"),
  "AR" = tibble(role = 1:14, weight = "high")
)

p_project_contributors <- contributor(
  contributor_list, weight = T, begin = 0.2, end = 0.8)

# -----------------------------------------------------------------------------

# Save plots ------------------------------------------------------------------

devices           <- c('pdf', 'png')
path_gantt        <- file.path(here("figs"), "project_timeline.")
path_contributors <- file.path(here("figs"), "project_contributors.")

walk(devices, ~ ggsave(filename = glue(path_gantt, .x), 
                       plot = p_project_timeline, device = .x, 
                       height = 5, width = 13, units = "in"))

walk(devices, ~ ggsave(filename = glue(path_contributors, .x), 
                       plot = p_project_contributors, device = .x, 
                       height = 4, width = 7, units = "in"))

# -----------------------------------------------------------------------------