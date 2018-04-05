context("lintr")
install.packages("lintr", repos = "http://cran.us.r-project.org")

library("lintr")
test_that("lintr", {
  lintr::expect_lint_free()
})
