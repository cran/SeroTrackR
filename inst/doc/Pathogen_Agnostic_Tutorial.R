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

## ----setup 1------------------------------------------------------------------
library(SeroTrackR)
library(tidyverse)

your_raw_data <- c(
  system.file("extdata", "example_MAGPIX_plate1.csv", package = "SeroTrackR"),
  system.file("extdata", "example_MAGPIX_plate2.csv", package = "SeroTrackR"), 
  system.file("extdata", "example_MAGPIX_plate3.csv", package = "SeroTrackR")
)
your_plate_layout <- system.file("extdata", "example_platelayout_1.xlsx", package = "SeroTrackR")

## ----eval=FALSE---------------------------------------------------------------
# your_raw_data <- c(
#   "PATH/TO/YOUR/FILE/plate1.csv",
#   "PATH/TO/YOUR/FILE/plate2.csv",
#   "PATH/TO/YOUR/FILE/plate3.csv"
# )
# your_plate_layout <- "PATH/TO/YOUR/FILE/plate_layout.xlsx"

## -----------------------------------------------------------------------------
sero_data <- readSeroData(
  raw_data = your_raw_data, 
  platform = "magpix",        # default 
  version = "4.2"             # default 
)

## -----------------------------------------------------------------------------
sero_data$results

## -----------------------------------------------------------------------------
plate_list <- readPlateLayout(
  plate_layout = your_plate_layout, 
  sero_data  = sero_data
)

## -----------------------------------------------------------------------------
qc_results  <- runQC(
  sero_data = sero_data,       # load in your serological data variable 
  plate_list = plate_list      # load your plate list variable 
)

## ----eval=FALSE---------------------------------------------------------------
# qc_results$getCountsQC_output

## ----echo=FALSE---------------------------------------------------------------
qc_results$getCountsQC_output %>% head()

## -----------------------------------------------------------------------------
plotStds(sero_data, location = "PNG", experiment_name = "experiment1")

## -----------------------------------------------------------------------------
plotCounts(qc_results, experiment_name = "experiment1")

## -----------------------------------------------------------------------------
getRepeats(qc_results, plate_list)

## -----------------------------------------------------------------------------
plotBlanks(sero_data, experiment_name = "experiment1")

## ----warning=FALSE, message=FALSE---------------------------------------------
mfi_to_rau_output <- MFItoRAU(
  sero_data = sero_data, 
  plate_list = plate_list,
  qc_results = qc_results, 
  std_point = 10
)

## ----eval=FALSE---------------------------------------------------------------
# mfi_to_rau_output[[2]]

## ----echo=FALSE---------------------------------------------------------------
mfi_to_rau_output[[2]] %>% head()

## -----------------------------------------------------------------------------
plotModel(mfi_to_rau_output, sero_data)

## ----runPvSeroPipeline-without-classification, eval=FALSE---------------------
# no_classification_final_analysis <- runPvSeroPipeline(
#   raw_data = your_raw_data,
#   plate_layout = your_plate_layout,
#   platform = "magpix",
#   location = "ETH",
#   experiment_name = "experiment1",
#   classify = "No", ########################## key if you do NOT want any classification performed i.e., you do not have PvSEM antigens
#   algorithm_type = "antibody_model",
#   sens_spec = "balanced"
# )

## ----eval=FALSE---------------------------------------------------------------
# # MFI and RAU data
# no_classification_final_analysis[[1]]
# 
# # QC plots
# #### Standard Curve Plot
# no_classification_final_analysis[[2]]
# 
# #### Bead Counts QC Plot
# no_classification_final_analysis[[3]] # Plot
# no_classification_final_analysis[[4]] # Samples to repeat
# 
# #### Blanks QC Plot
# no_classification_final_analysis[[5]]
# 
# #### Model Output Plot
# no_classification_final_analysis[[6]]

## ----eval=FALSE---------------------------------------------------------------
# library(SeroTrackR)
# library(tidyverse)
# 
# your_raw_data <- c(
#   system.file("extdata", "example_MAGPIX_plate1.csv", package = "SeroTrackR"),
#   system.file("extdata", "example_MAGPIX_plate2.csv", package = "SeroTrackR"),
#   system.file("extdata", "example_MAGPIX_plate3.csv", package = "SeroTrackR")
# )
# your_plate_layout <- system.file("extdata", "example_platelayout_1.xlsx", package = "SeroTrackR")
# 
# # read serology data
# sero_data <- readSeroData(raw_data = your_raw_data, platform = "magpix", version = "4.2")
# 
# # read plate data
# plate_list <- readPlateLayout(plate_layout = your_plate_layout, sero_data  = sero_data)
# 
# # run quality control checks
# qc_results  <- runQC(sero_data = sero_data, plate_list = plate_list)
# 
# # visualise quality control
# plotStds(sero_data, location = "PNG", experiment_name = "experiment1")
# 
# # bead counts plot
# plotCounts(qc_results, experiment_name = "experiment1")
# 
# # get repeats
# getRepeats(qc_results, plate_list)
# 
# # blank well plot
# plotBlanks(sero_data, experiment_name = "experiment1")
# 
# # perform MFI to RAU conversion
# mfi_to_rau_output <- MFItoRAU(
#   sero_data = sero_data,
#   plate_list = plate_list,
#   qc_results = qc_results,
#   std_point = 10
# )
# 
# # visualise MFI to RAU conversion
# plotModel(mfi_to_rau_output, sero_data)

