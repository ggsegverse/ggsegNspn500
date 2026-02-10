# Create NSPN500 Cortical Atlas
#
# Recreates the nspn500 cortical atlas from fsaverage5 annotation
# files using ggsegExtra.
#
# Requirements:
#   - FreeSurfer installed with fsaverage5 subject
#   - ggsegExtra package
#   - ggseg.formats package
#
# Run with: Rscript data-raw/make_atlas.R

library(dplyr)
library(ggsegExtra)
library(ggseg.formats)

options(freesurfer.verbose = FALSE)
future::plan(future::multisession(workers = 4))
progressr::handlers("cli")
progressr::handlers(global = TRUE)

Sys.setenv(FREESURFER_HOME = "/Applications/freesurfer/7.4.1")

annot_files <- c(
  here::here("data-raw", "fsaverage5", "lh.nspn500.annot"),
  here::here("data-raw", "fsaverage5", "rh.nspn500.annot")
)

for (f in annot_files) {
  if (!file.exists(f)) {
    cli::cli_abort("Annotation not found: {.path {f}}")
  }
}

cli::cli_h1("Creating nspn500 cortical atlas")

atlas_raw <- create_cortical_atlas(
  input_annot = annot_files,
  atlas_name = "nspn500",
  output_dir = "data-raw",
  tolerance = 1,
  smoothness = 2,
  skip_existing = TRUE,
  cleanup = FALSE
)

cli::cli_h2("Regions found:")
print(sort(unique(atlas_raw$core$region)))

atlas_raw <- atlas_raw |>
  atlas_region_contextual("unknown", "label")

atlas_raw <- atlas_raw |>
  atlas_view_gather()

nspn500 <- atlas_raw

cli::cli_alert_success("Atlas created with {nrow(nspn500$core)} regions")
print(nspn500)

brain_pals <- stats::setNames(
  list(nspn500$palette),
  nspn500$atlas
)
save(brain_pals, file = here::here("R/sysdata.rda"), compress = "xz")

usethis::use_data(nspn500, overwrite = TRUE, compress = "xz")
cli::cli_alert_success("Saved to data/nspn500.rda")
