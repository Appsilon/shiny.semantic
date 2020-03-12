context("lintr")

test_that("lintr", {
  print(getwd())
  lintr::expect_lint_free(
    path = "../../00_pkg_src/shiny.semantic",
    relative_path = TRUE,
    lintr::line_length_linter(120)
  )
})
