context("lintr")

test_that("lintr", {
  lintr::expect_lint_free(path = ".", relative_path = TRUE, lintr::line_length_linter(120))
})
