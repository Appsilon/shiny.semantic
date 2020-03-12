context("semanticPage")

test_that("test get_cdn_path return default path", {
  # When
  options("shiny.custom.semantic.cdn" = NULL)
  # Then
  expect_true(
    grepl(
      "^(https:\\/\\/www\\.|https:\\/\\/)?[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,5}(:[0-9]{1,5})?(\\/.*)?$",
      get_cdn_path()
    )
  )
  expect_false(grepl("/$", get_cdn_path()))
})

test_that("test get_cdn_path return path", {
  # When
  options("shiny.custom.semantic.cdn" = "shiny.semantic")

  # Then
  expect_equal(get_cdn_path(), "shiny.semantic")
})

test_that("test get_dependencies warning", {
  # When
  options("shiny.custom.semantic.cdn" = NULL)
  options("shiny.semantic.local" = TRUE)

  # Then
  expect_warning(get_dependencies("darkly"), "It's not posible use local semantic version with themes. Using CDN")
})
