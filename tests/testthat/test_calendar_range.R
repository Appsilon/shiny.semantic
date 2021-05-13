context("ui calendar range")

test_that("test calendar range", {
  # type
  expect_is(calendar_range("calendar_range_input"), "shiny.tag")
  # empty input
  expect_error(calendar_range())
  # calendar range input
  si_str <- as.character(calendar_range("calendar_range_input"))
  expect_true(grepl("<div id=\"calendar_range_input\" class=\"ui form semantic-input-date-range\">",
                    si_str))
  # calendar range input contains two calendars
  expect_equal(stringr::str_count(
    si_str,
    "<div class=\"ui calendar ss-input-date-range-item\" data-type=\"date\">"
  ), 2)
})
