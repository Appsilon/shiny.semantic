context("ui slider")

test_that("test slider_input", {
  # type
  expect_is(slider_input("slider_input", 10, 0, 20), "shiny.tag")
  # empty input
  expect_error(slider_input())
  # number input
  si_str <- as.character(slider_input("slider_input", 10, 0, 20))
  expect_true(grepl(
    "<div id=\"slider_input\" class=\"ui slider \" data-min=\"0\" data-max=\"20\" data-step=\"1\" data-start=\"10\">",
    si_str
  ))
})

test_that("test sliderInput", {
  expect_error(sliderInput("slider_input"), "\"label\" is missing")
  si_str <- as.character(sliderInput("slider_input", "Label", 10, 0, 20))
  expect_true(grepl(
    "<form class=\"ui form \">\n  <label>Label</label>\n",
    si_str
  ))
  expect_true(grepl(
    "data-max=\"0\" data-step=\"1\" data-start=\"20\"></div>",
    si_str
  ))
})

test_that("test range_input", {
  # type
  expect_is(range_input("range_input", 10, 15, 0, 20), "shiny.tag")
  # empty input
  expect_error(uicalendar())
  # number input
  si_str <- as.character(range_input("range_input", 10, 15, 0, 20))
  expect_true(grepl(paste(
    "<div id=\"range_input\" class=\"ui range slider \" data-min=\"0\" data-max=\"20\"",
    "data-step=\"1\" data-start=\"10\" data-end=\"15\">"
  ), si_str))
})
