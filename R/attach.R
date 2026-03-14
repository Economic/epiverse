core <- c(
  "epidatatools",
  "epiextractr",
  "epitargets",
  "prefab",
  "realtalk",
  "swadlr"
)

core_unloaded <- function() {
  search <- paste0("package:", core)
  core[!search %in% search()]
}

same_library <- function(pkg) {
  loc <- if (pkg %in% loadedNamespaces()) {
    dirname(getNamespaceInfo(pkg, "path"))
  }
  library(pkg, lib.loc = loc, character.only = TRUE, warn.conflicts = FALSE)
}

epiverse_attach <- function() {
  to_load <- core_unloaded()

  suppressPackageStartupMessages(
    lapply(to_load, same_library)
  )

  invisible(to_load)
}

epiverse_attach_message <- function(to_load) {
  if (length(to_load) == 0) {
    return(NULL)
  }

  header <- cli::rule(
    left = cli::style_bold("Attaching epiverse packages"),
    right = paste0("epiverse ", package_version_h("epiverse"))
  )

  to_load <- sort(to_load)
  versions <- vapply(to_load, package_version_h, character(1))

  packages <- paste0(
    cli::col_green(cli::symbol$tick),
    " ",
    cli::col_blue(format(to_load)),
    " ",
    cli::ansi_align(versions, max(cli::ansi_nchar(versions)))
  )

  if (length(packages) %% 2 == 1) {
    packages <- append(packages, "")
  }
  col1 <- seq_len(length(packages) / 2)
  info <- paste0(packages[col1], "     ", packages[-col1])

  paste0(header, "\n", paste(info, collapse = "\n"))
}

package_version_h <- function(pkg) {
  as.character(utils::packageVersion(pkg))
}
