context("button")

test_that("test uibutton", {
  # type
  expect_is(uibutton("simple_button", "Button!"), "shiny.tag")
  # empty input
  expect_error(uibutton())
  # text input
  si_str <- as.character(uibutton("simple_button", "Button!"))
  expect_true(any(grepl("<button id=\"simple_button\" class=\"ui  button\">", si_str, fixed = TRUE)))
  expect_true(any(grepl("Button!", si_str, fixed = TRUE)))
})
