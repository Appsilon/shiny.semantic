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
  expect_true(any(grepl("<input id=\"text_input\" value=\"Text Input\" type = \"text\">", si_str, fixed = TRUE)))
  expect_true(any(grepl("Button!", si_str, fixed = TRUE)))
})
