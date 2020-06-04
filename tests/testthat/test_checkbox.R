context("checkbox")

test_that("test simple_checkbox input values", {
  # type
  expect_is(simple_checkbox("check"), "shiny.tag")
  # empty input
  si_str <- as.character(simple_checkbox("check"))
  expect_true(any(grepl("<div class=\"ui  checked checkbox\">\n  <input id=\"check\"",
                        si_str, fixed = TRUE)))
  # labels
  si_str <- as.character(simple_checkbox("check", "My Label"))
  expect_true(any(grepl("<label>My Label</label>",
                        si_str, fixed = TRUE)))
  # is_marked
  si_str <- as.character(simple_checkbox("check", is_marked = FALSE))
  expect_false(any(grepl("ui  checked checkbox",
                        si_str, fixed = TRUE)))
})

test_that("test toggle alias for simple_checkbox", {
  si_str1 <- as.character(simple_checkbox("check", "My Label", is_marked = FALSE))
  si_str2 <- as.character(toggle("check", "My Label", is_marked = FALSE))
  expect_equal(si_str1, si_str2)
})
