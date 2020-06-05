context("digits2words")

test_that("test digit2word parsing", {
  # test wrong inputs
  expect_error(digits2words(0))
  expect_error(digits2words(11))
  expect_error(digits2words("11"))
  # test correct inputs
  expect_equal(digits2words(2), "two")
})

test_that("test render_menu_link", {
  # type
  expect_is(render_menu_link("sub1", "title"), "shiny.tag")
  # simple input
  si_str <- as.character(render_menu_link("sub1", "title"))
  expect_true(any(grepl("<a class=\"item\" href=\"sub1\">\n",
                        si_str, fixed = TRUE)))
})

test_that("test horizontal_menu", {
  # empty input
  expect_error(horizontal_menu(data.frame()))
  # no icon input
  menu_content <- data.frame(
    name = paste("Menu", 1:4),
    link = paste("subpage", 1:4)
  )
  si_str <- as.character(horizontal_menu(menu_content))
  expect_true(any(grepl("<div class=\"ui four item menu\" ",
                        si_str, fixed = TRUE)))
  menu_content <- data.frame(
    name = paste("Menu", 1:7),
    link = paste("subpage", 1:7)
  )
  si_str <- as.character(horizontal_menu(menu_content))
  expect_true(any(grepl("<div class=\"ui seven item menu\" ",
                        si_str, fixed = TRUE)))
  # with icon
  menu_content <- data.frame(
    name = paste("Menu", 1:3),
    link = paste("subpage", 1:3),
    icon = c("home", "car", 'tree')
  )
  si_str <- as.character(horizontal_menu(menu_content))
  expect_true(any(grepl("icon", si_str)))
})
