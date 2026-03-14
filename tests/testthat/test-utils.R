test_that("epiverse_packages returns all 6 sub-packages", {
  pkgs <- epiverse_packages(include_self = FALSE)
  expect_equal(
    pkgs,
    sort(c(
      "epidatatools",
      "epiextractr",
      "epitargets",
      "prefab",
      "realtalk",
      "swadlr"
    ))
  )
})

test_that("epiverse_packages includes self when requested", {
  pkgs <- epiverse_packages(include_self = TRUE)
  expect_true("epiverse" %in% pkgs)
})

test_that("epiverse_packages excludes self when requested", {
  pkgs <- epiverse_packages(include_self = FALSE)
  expect_false("epiverse" %in% pkgs)
})
