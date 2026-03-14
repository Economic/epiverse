.onAttach <- function(...) {
  if (is_loading_for_tests()) {
    return(invisible())
  }

  attached <- epiverse_attach()

  if (isTRUE(getOption("epiverse.quiet"))) {
    return(invisible())
  }

  inform_startup(epiverse_attach_message(attached))

  if (is_attached("conflicted")) {
    return(invisible())
  }

  conflicts <- epiverse_conflicts()
  inform_startup(epiverse_conflict_message(conflicts))
}

is_attached <- function(x) {
  paste0("package:", x) %in% search()
}

is_loading_for_tests <- function() {
  !interactive() && identical(Sys.getenv("DEVTOOLS_LOAD"), "epiverse")
}

inform_startup <- function(msg) {
  if (is.null(msg)) {
    return(invisible())
  }
  packageStartupMessage(msg)
}
