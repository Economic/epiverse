#' List all epiverse packages
#'
#' Returns the names of all packages included in epiverse, read from the
#' package DESCRIPTION file at runtime.
#'
#' @param include_self If `TRUE`, includes "epiverse" itself in the list.
#'   Defaults to `TRUE`.
#' @return A character vector of package names.
#' @export
#' @examples
#' epiverse_packages()
epiverse_packages <- function(include_self = TRUE) {
  raw <- utils::packageDescription("epiverse")$Imports
  imports <- strsplit(raw, ",")[[1]]
  parsed <- gsub("^\\s+|\\s+$", "", imports)
  parsed <- gsub("\\s*\\(.*\\)", "", parsed)
  parsed <- parsed[parsed != ""]

  # Exclude non-sub-packages
  parsed <- setdiff(parsed, c("cli"))

  if (include_self) {
    parsed <- c(parsed, "epiverse")
  }

  sort(parsed)
}
