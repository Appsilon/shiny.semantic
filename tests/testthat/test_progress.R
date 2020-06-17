context("ui progress")

test_that("test uiprogress", {
  # type
  expect_is(uiprogress("progress_input", 10, 100), "shiny.tag")
  # empty input
  expect_error(uiprogress())
  # value higher than total
  expect_error(uiprogress("progress_input", 100, 10))
  # value and percent
  expect_error(uiprogress("progress_input", 100, 10, 50))
  # value input
  si_str <- as.character(uiprogress("progress_input", 10, 100))
  expect_true(grepl("data-value", si_str))
  expect_true(grepl("data-total", si_str))

  # percent input
  si_str <- as.character(uiprogress("progress_input", percent = 50, progress_lab = TRUE))
  expect_true(grepl("data-percent", si_str))
  expect_true(grepl("<div class=\"progress\">", si_str))
})
