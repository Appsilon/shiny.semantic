context("rating")

test_that("test basic rating_input behaviour", {
  # type
  expect_is(rating_input("rating"), "shiny.tag")
  # empty input
  expect_error(rating_input())
  # number input
  si_str <- as.character(rating_input("rating"))
  expect_true(grepl("<div class=\"ui form\">\n  <div class=\"field\">\n    <label for=\"rating\">",
                    si_str))
})
test_that("test extract_icon_name", {
  expect_equal(extract_icon_name(icon("cat")), "cat")
  expect_error(extract_icon_name("error"))
})

test_that("test rating_input parameters", {
  # label
  si_str <- as.character(rating_input("rating", "My label"))
  expect_true(grepl("<label for=\"rating\">My label</label>",
                    si_str))
  # default color
  expect_true(grepl("yellow", si_str))
  # color
  si_str <- as.character(rating_input("rating", color = "red"))
  expect_true(grepl("red", si_str))
  # size
  si_str <- as.character(rating_input("rating", size = "huge"))
  expect_true(grepl("huge", si_str))
  expect_warning(rating_input("rating", size = "xAb"))
})
