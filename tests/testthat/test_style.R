context("lintr")

test_that("lintr", {
  lintr::expect_lint_free()
})
