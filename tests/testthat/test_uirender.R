context("uirender")

test_that("test uirender missing values", {
  expect_error(uirender())
})

test_that("test uirender output type", {
  expect_is(uirender(div(class = "demo", "p")), "uirender")
  expect_is(uirender(div(class = "demo", "p")), "htmlwidget")
})
