context("digits2words")

test_that("test digit2word parsing", {
  # test wrong inputs
  expect_error(digits2words(0))
  expect_error(digits2words(11))
  expect_error(digits2words(3.5))
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

test_that("test horizontal_menu edge cases", {
  # expect list
  expect_error(horizontal_menu(data.frame()))
  expect_error(horizontal_menu(matrix()))
  expect_error(horizontal_menu(c(1,2)))
  # empty input
  expect_error(horizontal_menu(list()),
               "Empty list! No menu elements detected.")
})

test_that("test horizontal_menu inputs", {
  # no icon input
  menu_content <- list(
    list(name = "Menu1", link = "#subpage1"),
    list(name = "Menu2", link = "#subpage2")
  )
  si_str <- as.character(horizontal_menu(menu_content))
  expect_true(any(grepl("<div class=\"ui two item menu\" ",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("Menu1", si_str, fixed = TRUE)))
  expect_true(any(grepl("#subpage2", si_str, fixed = TRUE)))
  # missing name
  menu_content <- list(
    list(link = "#"),
    list(name = "Menu2", link = "#subpage2")
  )
  expect_error(horizontal_menu(menu_content),
               "Menu list entry needs to have a name")
  # missing link
  menu_content <- list(
    list(name = "Menu1"),
    list(name = "Menu2", link = "#subpage2")
  )
  si_str <- as.character(horizontal_menu(menu_content))
  expect_true(any(grepl("<a class=\"item\" href=\"#\">",
                        si_str, fixed = TRUE)))
  # with icon
  menu_content <- list(
    list(name = "Menu1"),
    list(name = "Menu2", icon = "dog")
  )
  si_str <- as.character(horizontal_menu(menu_content))
  expect_true(any(grepl("dog icon", si_str)))
})
