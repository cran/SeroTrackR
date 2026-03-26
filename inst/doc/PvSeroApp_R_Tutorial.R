## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(rmarkdown.html_vignette.check_title = FALSE)
setup <- function() {
  needed <- c("knitr", "rmarkdown", "tidyverse", "kableExtra")
  
  lapply(needed, function(pkg) {
    if (requireNamespace(pkg, quietly = TRUE)) {
      library(pkg, character.only = TRUE)
    }
  })
}

setup()
library(SeroTrackR)

knitr::opts_chunk$set(
  dpi = 72
)

knitr::opts_chunk$set(
  dpi = 72
)

## ----setup 1------------------------------------------------------------------
library(SeroTrackR)
library(tidyverse)

your_raw_data <- c(
  system.file("extdata", "example_MAGPIX_plate1.csv", package = "SeroTrackR"),
  system.file("extdata", "example_MAGPIX_plate2.csv", package = "SeroTrackR"), 
  system.file("extdata", "example_MAGPIX_plate3.csv", package = "SeroTrackR")
)
your_plate_layout <- system.file("extdata", "example_platelayout_1.xlsx", package = "SeroTrackR")

## ----exec=FALSE, eval=FALSE---------------------------------------------------
# your_raw_data <- c(
#   "PATH/TO/YOUR/FILE/plate1.csv",
#   "PATH/TO/YOUR/FILE/plate2.csv",
#   "PATH/TO/YOUR/FILE/plate3.csv"
# )
# your_plate_layout <- "PATH/TO/YOUR/FILE/plate_layout.xlsx"

## ----runPvSeroPipeline with classification------------------------------------
final_analysis <- runPvSeroPipeline(
  raw_data = your_raw_data, 
  plate_layout = your_plate_layout, 
  platform = "magpix", 
  location = "ETH", 
  experiment_name = "experiment1", 
  classify = "Yes", 
  algorithm_type = "antibody_model", 
  sens_spec = "balanced"
)

## ----classification tab 1-----------------------------------------------------
final_analysis[[1]] %>%
  head() %>% 
  kable()

## ----std curve plot tab 1-----------------------------------------------------
final_analysis[[2]]

## ----bead counts plot tab 1---------------------------------------------------
final_analysis[[3]] # Plot
final_analysis[[4]] # Samples to repeat 

## ----blanks qc plot tab 1-----------------------------------------------------
final_analysis[[5]]

## ----model output plot tab 1--------------------------------------------------
final_analysis[[6]]

## ----runPvSeroPipeline without classification---------------------------------
no_classification_final_analysis <- runPvSeroPipeline(
  raw_data = your_raw_data, 
  plate_layout = your_plate_layout, 
  platform = "magpix", 
  location = "ETH", 
  experiment_name = "experiment1", 
  classify = "No", ########################## key if you do NOT want any classification performed i.e., you do not have PvSeroTaT antigens 
  algorithm_type = "antibody_model", 
  sens_spec = "balanced"
)

## ----mfi and rau tab 2--------------------------------------------------------
no_classification_final_analysis[[1]]  %>%
  head() %>% 
  kable()

## ----std curve plot tab 2-----------------------------------------------------
#### Standard Curve Plot
no_classification_final_analysis[[2]]

#### Bead Counts QC Plot
no_classification_final_analysis[[3]] # Plot
no_classification_final_analysis[[4]] # Samples to repeat 

#### Blanks QC Plot
no_classification_final_analysis[[5]]

#### Model Output Plot
no_classification_final_analysis[[6]]

## ----create pdf output, exec=FALSE, eval=FALSE--------------------------------
# renderQCReport(
#   your_raw_data,
#   your_plate_layout,
#   "magpix",
#   location = "ETH",
#   path = "inst/tutorials/" # defaults to your current working directory
# )

