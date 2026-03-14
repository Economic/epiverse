#' Conflicts between epiverse packages and other packages
#'
#' Lists all function conflicts between epiverse packages and other packages
#' that you have loaded.
#'
#' @param only Set this to a character vector to restrict to conflicts only
#'   with these packages.
#' @return An object of class `epiverse_conflicts`, invisibly. Printed output
#'   shows which epiverse functions mask functions from other packages.
#' @export
#' @examples
#' \dontrun{
#' epiverse_conflicts()
#' }
epiverse_conflicts <- function(only = NULL) {
  envs <- grep("^package:", search(), value = TRUE)
  names(envs) <- envs

  if (!is.null(only)) {
    only <- union(only, core)
    envs <- envs[names(envs) %in% paste0("package:", only)]
  }

  objs <- invert(lapply(envs, ls_env))

  conflicts <- Filter(function(x) length(x) > 1, objs)

  epi_names <- paste0("package:", epiverse_packages())
  conflicts <- Filter(function(pkg) any(pkg %in% epi_names), conflicts)

  conflict_funs <- Map(confirm_conflict, conflicts, names(conflicts))
  conflict_funs <- Filter(Negate(is.null), conflict_funs)

  class(conflict_funs) <- "epiverse_conflicts"
  conflict_funs
}

epiverse_conflict_message <- function(x) {
  if (length(x) == 0) {
    return(NULL)
  }

  header <- cli::rule(
    left = cli::style_bold("Conflicts"),
    right = "epiverse_conflicts()"
  )

  pkgs <- lapply(x, function(p) gsub("^package:", "", p))
  others <- lapply(pkgs, function(p) p[-1])
  other_calls <- vapply(
    seq_along(others),
    function(i) {
      paste0(
        cli::col_blue(others[[i]]),
        "::",
        names(others)[i],
        "()",
        collapse = ", "
      )
    },
    character(1)
  )

  winner <- vapply(pkgs, function(p) p[[1]], character(1))
  funs <- format(paste0(
    cli::col_blue(winner),
    "::",
    cli::col_green(paste0(names(x), "()"))
  ))
  bullets <- paste0(
    cli::col_red(cli::symbol$cross),
    " ",
    funs,
    " masks ",
    other_calls,
    collapse = "\n"
  )

  conflicted_msg <- paste0(
    cli::col_cyan(cli::symbol$info),
    " ",
    "Use the ",
    cli::format_inline(
      "{.href [conflicted package](https://conflicted.r-lib.org/)}"
    ),
    " to force all conflicts to become errors"
  )

  paste0(header, "\n", bullets, "\n", conflicted_msg)
}

#' @export
print.epiverse_conflicts <- function(x, ...) {
  cli::cat_line(epiverse_conflict_message(x))
  invisible(x)
}

confirm_conflict <- function(packages, name) {
  objs <- lapply(packages, function(pkg) get(name, pos = pkg))
  is_fun <- vapply(objs, is.function, logical(1))
  objs <- objs[is_fun]
  packages <- packages[is_fun]

  if (length(objs) <= 1) {
    return(NULL)
  }

  # Remove identical functions
  dups <- duplicated(objs)
  objs <- objs[!dups]
  packages <- packages[!dups]
  if (length(objs) == 1) {
    return(NULL)
  }

  packages
}

ls_env <- function(env) {
  ls(pos = env)
}

invert <- function(x) {
  if (length(x) == 0) {
    return(list())
  }
  stacked <- data.frame(
    name = unlist(x, use.names = FALSE),
    pkg = rep(names(x), lengths(x)),
    stringsAsFactors = FALSE
  )
  split(stacked$pkg, stacked$name)
}
