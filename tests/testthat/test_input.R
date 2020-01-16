context("input")

test_that("test uiinput", {
  # type
  expect_is(uiinput(), "shiny.tag")
  # text input
  si_str <- as.character(uiinput())
  expect_true(any(grepl("<div class=\"ui  input\">", si_str, fixed = TRUE)))
})

test_that("test uitextinput", {
  # type
  expect_is(uitextinput("text_input", "Text Input"), "shiny.tag")
  # empty input
  expect_error(uitextinput())
  # text input
  si_str <- as.character(uitextinput("text_input", "Text Input"))
  expect_equal("<input id=\"text_input\" value=\"Text Input\" type=\"text\"/>", si_str)
})

test_that("test uinumericinput", {
  # type
  expect_is(uinumericinput("number_input", 20), "shiny.tag")
  # empty input
  expect_error(uinumericinput())
  # text input
  expect_error(uinumericinput("number input", "Text input"))
  # number input
  si_str <- as.character(uinumericinput("number_input", 20))
  expect_equal("<input id=\"number_input\" value=\"20\" type=\"number\"/>", si_str)
  # all parameters
  expect_is(uinumericinput("number_input", 20, min = 10, max = 40, step = 1), "shiny.tag")
})
