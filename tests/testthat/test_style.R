context("lintr")
install.packages("lintr")

library("lintr")
test_that("lintr", {
  lintr::expect_lint_free()
})
