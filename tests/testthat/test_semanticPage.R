context("semanticPage")

test_that("test get_cdn_path return default path", {
  # When
  options("shiny.custom.semantic.cdn" = NULL)
  # Then
  expect_equal(get_cdn_path(), "https://d335w9rbwpvuxm.cloudfront.net")
})

test_that("test get_cdn_path return path", {
  # When
  options("shiny.custom.semantic.cdn" = "shiny.semantic")

  # Then
  expect_equal(get_cdn_path(), "shiny.semantic")
})
