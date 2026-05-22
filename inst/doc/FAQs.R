## -----------------------------------------------------------------------------
# install.packages("tidyverse")

## -----------------------------------------------------------------------------
# library(tidyverse)

## -----------------------------------------------------------------------------
# setup <- function(){
#   needed <- c(
#     # Imports: Required
#     "dplyr", "drc", "forcats", "ggplot2", "here", "janitor",
#     "kableExtra", "knitr", "magrittr", "openxlsx", "parsnip",
#     "purrr", "ranger", "readr", "readxl", "rmarkdown", "stats",
#     "stringr", "tidyr", "tidyselect", "utils", "workflows",
#     # Imports: Suggested
#     "glue", "htmltools", "httr", "jsonlite", "shiny.fluent",
#     "tidyverse", "zoo"
#     )
#   for(package in needed){
#     if(!sum(installed.packages() %in% package)){
#       install.packages(package)
#     }
# 
#     require(package, character.only = TRUE)
#   }
# }
# 
# setup()

## -----------------------------------------------------------------------------
# my_raw_data       <- "data/my_plate1.csv"
# my_plate_layout   <- "data/my_plate_layout.xlsx"

## -----------------------------------------------------------------------------
# getPlateLayout("your/folder/with/plate/layouts/")

## -----------------------------------------------------------------------------
# getPlateLayout("data/")

## -----------------------------------------------------------------------------
# getPlateLayout()

## -----------------------------------------------------------------------------
# getPlateLayout(folder_path = c("plate_layout_1.xlsx", "plate_layout_2.xlsx", "plate_layout_3.xlsx"))

## -----------------------------------------------------------------------------
library(SeroTrackR)
library(tidyverse)

bioplex_raw_plates <- c(
  system.file("extdata", "example_BioPlex_plate1.xlsx", package = "SeroTrackR"),
  system.file("extdata", "example_BioPlex_plate2.xlsx", package = "SeroTrackR")
)
all_plate_layout <- system.file("extdata", "example_platelayout_1.xlsx", package = "SeroTrackR")

## -----------------------------------------------------------------------------
# bioplex_raw_plates <- c(
#   "data/example_BioPlex_plate1.xlsx",
#   "data/example_BioPlex_plate2.xlsx"
# )
# all_plate_layout <- "data/example_platelayout_1.xlsx"

## -----------------------------------------------------------------------------
# magpix_raw_plate     <- system.file("extdata", "example_MAGPIX_plate3.csv", package = "SeroTrackR")

## -----------------------------------------------------------------------------
# magpix_raw_plate      <- "data/example_MAGPIX_plate3.csv"

## -----------------------------------------------------------------------------
# # Serological data
# bioplex_sero_data <- readSeroData(
#   raw_data = bioplex_raw_plates,
#   platform = "bioplex"
# )
# magpix_sero_data <- readSeroData(
#   raw_data = magpix_raw_plate,
#   platform = "magpix",
#   version = "4.2"
# )

## -----------------------------------------------------------------------------
# sero_data_merged <- NULL
# # data_raw
# sero_data_merged$data_raw <- bioplex_sero_data$data_raw %>%
#   bind_rows(magpix_sero_data$data_raw)
# 
# # results
# sero_data_merged$results <- bioplex_sero_data$results %>%
#   bind_rows(magpix_sero_data$results)
# 
# # counts
# sero_data_merged$counts <- bioplex_sero_data$counts %>%
#   bind_rows(magpix_sero_data$counts)
# 
# # blanks
# sero_data_merged$blanks <- bioplex_sero_data$blanks %>%
#   bind_rows(magpix_sero_data$blanks)
# 
# # stds
# sero_data_merged$stds <- bioplex_sero_data$stds %>%
#   bind_rows(magpix_sero_data$stds)
# 
# # run
# sero_data_merged$run <- bioplex_sero_data$run %>%
#   bind_rows(magpix_sero_data$run)

## -----------------------------------------------------------------------------
# plate_list_all  <- readPlateLayout(
#   plate_layout = all_plate_layout,
#   sero_data = sero_data_merged
# )
# 
# qc_results <- runQC(
#   sero_data = sero_data_merged,
#   plate_list = all_plate_layout
# )
# 
# mfi_to_rau_output <- MFItoRAU(
#   sero_data = sero_data_merged,
#   plate_list = all_plate_layout,
#   qc_results = qc_results,
#   std_point = 10
# )
# 
# # etc..

