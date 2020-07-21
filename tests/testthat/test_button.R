context("button")

test_that("test button", {
  # type
  expect_is(button("simple_button", "Button!"), "shiny.tag")
  # empty input
  expect_error(button())
  # text input
  si_str <- as.character(button("simple_button", "Button!"))
  expect_true(any(grepl("<button id=\"simple_button\" class=\"ui  button\">", si_str, fixed = TRUE)))
  expect_true(any(grepl("Button!", si_str, fixed = TRUE)))
})

test_that("test actionButton", {
  # type
  expect_is(actionButton("action_button", "AB!"), "shiny.tag")
  # empty input
  expect_error(actionButton())
  # text input
  si_str <- as.character(actionButton("action_button", "AB!"))
  expect_true(any(grepl("<button id=\"action_button\" class=\"ui  button\">",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("AB!", si_str, fixed = TRUE)))
  # input with parameters
  si_str <- as.character(actionButton("action_button", "AB!", icon = icon("user"),
                                      class = "huge orange"))
  expect_true(any(grepl("<button id=\"action_button\" class=\"ui huge orange button\">",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("AB!", si_str, fixed = TRUE)))
  expect_true(any(grepl("icon", si_str, fixed = TRUE)))
})


test_that("test counter_button", {
  # type
  expect_is(counter_button("cb"), "shiny.tag")
  # empty input
  expect_error(counter_button())
  # simple input
  si_str <- as.character(counter_button("cb", "CB"))
  # is JS code included?
  expect_true(any(grepl("function", si_str, fixed = TRUE)))
  expect_true(any(grepl("html((value + 1).toString()", si_str, fixed = TRUE)))

  # input with parameters
  si_str <- as.character(counter_button("cb", "CB", icon = icon("user"),
                                       size = "huge", color = "orange"))
  expect_true(any(grepl("orange", si_str, fixed = TRUE)))
  expect_true(any(grepl("huge", si_str, fixed = TRUE)))
  expect_true(any(grepl("icon", si_str, fixed = TRUE)))
})
