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

test_that("test actionButton", {
  # type
  expect_is(actionButton("action_button", "AB!"), "shiny.tag")
  # empty input
  expect_error(uibutton())
  # text input
  si_str <- as.character(actionButton("action_button", "AB!"))
  expect_true(any(grepl("<button id=\"action_button\" class=\"ui  button\">",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("AB!", si_str, fixed = TRUE)))
  # input with parameters
  si_str <- as.character(actionButton("action_button", "AB!", icon = uiicon("user"),
                                      type = "huge orange"))
  expect_true(any(grepl("<button id=\"action_button\" class=\"ui  huge orange button\">",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("AB!", si_str, fixed = TRUE)))
  expect_true(any(grepl("icon", si_str, fixed = TRUE)))
})

