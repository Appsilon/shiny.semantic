context("ui slider")

test_that("test uislider", {
  # type
  expect_is(uislider("slider_input", 10, 0, 20), "shiny.tag")
  # empty input
  expect_error(uislider())
  # number input
  si_str <- as.character(uislider("slider_input", 10, 0, 20))
  expect_true(grepl(
    "<div id=\"slider_input\" class=\"ui slider \" data-min=\"0\" data-max=\"20\" data-step=\"1\" data-start=\"10\">",
    si_str
  ))
})

test_that("test uirange", {
  # type
  expect_is(uirange("range_input", 10, 15, 0, 20), "shiny.tag")
  # empty input
  expect_error(uicalendar())
  # number input
  si_str <- as.character(uirange("range_input", 10, 15, 0, 20))
  expect_true(grepl(paste(
    "<div id=\"range_input\" class=\"ui range slider \" data-min=\"0\" data-max=\"20\"",
    "data-step=\"1\" data-start=\"10\" data-end=\"15\">"
  ), si_str))
})
