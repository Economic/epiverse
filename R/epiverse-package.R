#' @keywords internal
"_PACKAGE"

# Suppress R CMD check notes about unused imports.
# Each sub-package is listed in Imports but not directly called in epiverse
# code — they are attached via library() in .onAttach. This dummy function
# references one symbol per import to satisfy the check.
ignore_unused_imports <- function() {
  epidatatools::averaged_median
  epiextractr::cps_files
  epitargets::tar_age_date
  prefab::claude_r_analysis
  realtalk::get_price_index
  swadlr::get_swadl
}
