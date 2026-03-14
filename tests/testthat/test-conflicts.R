test_that("epiverse_conflicts returns epiverse_conflicts class", {
  conflicts <- epiverse_conflicts()
  expect_s3_class(conflicts, "epiverse_conflicts")
})

test_that("epiverse_conflict_message returns NULL when no conflicts", {
  x <- structure(list(), class = "epiverse_conflicts")
  expect_null(epiverse_conflict_message(x))
})
