# Create NSPN500 Cortical Atlas
#
# Recreates the nspn500 cortical atlas from fsaverage5 annotation
# files using ggseg.extra vertex projection pipeline.
#
# Requirements:
#   - FreeSurfer installed with fsaverage5 subject
#   - ggseg.extra (>= 2.0.0.9000)
#   - ggseg.formats
#
# Run with: Rscript data-raw/make_atlas.R

library(ggseg.extra)
library(ggseg.formats)

Sys.setenv(FREESURFER_HOME = "/Applications/freesurfer/7.4.1")

annot_files <- file.path(
  here::here("data-raw", "fsaverage5"),
  c("lh.nspn500.annot", "rh.nspn500.annot")
)

nspn500 <- create_cortical_from_annotation(
  input_annot = annot_files,
  atlas_name = "nspn500",
  output_dir = "data-raw",
  skip_existing = TRUE,
  cleanup = FALSE
) |>
  atlas_region_contextual("unknown", "label")

print(nspn500)
plot(nspn500)

.nspn500 <- nspn500
usethis::use_data(.nspn500, overwrite = TRUE, compress = "xz", internal = TRUE)
