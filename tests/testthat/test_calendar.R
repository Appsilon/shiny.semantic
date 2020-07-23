context("ui calendar")

test_that("test uicalendar", {
  # type
  expect_is(calendar("calendar_input"), "shiny.tag")
  # empty input
  expect_error(calendar())
  # number input
  si_str <- as.character(calendar("calendar_input"))
  expect_true(grepl("<div id=\"calendar_input\" class=\"ui calendar ss-input-date\" data-type=\"date\">",
                    si_str))
  # all parameters
  expect_is(
    calendar("calendar_input", Sys.Date(),
             "Select tomorrow",
             min = Sys.Date() - 3,
             max = Sys.Date() + 4),
    "shiny.tag"
  )
})
