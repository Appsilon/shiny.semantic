context("navbar_page")

testthat::test_that("navbar_page creates UI page", {
  ui <- navbar_page(tab_panel("Panel"))

  testthat::expect_s3_class(ui, "shiny.tag.list")
})

testthat::test_that("navbar_page with no panels errors", {
  testthat::expect_error(navbar_page(), "No tabs detected")
})

testthat::test_that("navbar_page works with navbar_menu", {
  menu <- navbar_menu(
    "Menu",
    tab_panel("Panel 1"),
    tab_panel("Panel 2")
  )

  testthat::expect_s3_class(menu, "ssnavmenu")

  ui <- navbar_page(menu)

  testthat::expect_s3_class(ui, "shiny.tag.list")
})

testthat::test_that("selected works with tab name", {
  ui <- navbar_page(
    tab_panel("Panel 1"),
    tab_panel("Panel 2"),
    tab_panel("Panel 3"),
    selected = "Panel 3"
  )

  # Will check whole of ui menu for a tab to be classed as active
  body_tag <- which(sapply(ui, function(x) x$name == "body"))
  testthat::expect_true(grepl("active", ui[[body_tag]]))
})
