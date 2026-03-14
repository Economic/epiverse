test_that("core contains all 6 packages", {
  expect_equal(
    sort(core),
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

test_that("core_unloaded returns character vector", {
  expect_type(core_unloaded(), "character")
})
