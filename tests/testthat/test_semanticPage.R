context("semanticPage")

test_that("test get_cdn_path return path", {
  expect_equal(get_cdn_path(), "https://d335w9rbwpvuxm.cloudfront.net")
})
