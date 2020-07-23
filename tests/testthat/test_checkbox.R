context("checkbox")

test_that("test checkbox_input input values", {
  # type
  expect_is(checkbox_input("check"), "shiny.tag")
  # empty input
  si_str <- as.character(checkbox_input("check"))
  expect_true(any(grepl("<div class=\"ui  checked checkbox\">\n  <input id=\"check\"",
                        si_str, fixed = TRUE)))
  si_str <- as.character(checkbox_input("check", "My Label"))
  expect_true(any(grepl("<label>My Label</label>",
                        si_str, fixed = TRUE)))
  # is_marked
  si_str <- as.character(checkbox_input("check", is_marked = FALSE))
  expect_false(any(grepl("ui  checked checkbox",
                        si_str, fixed = TRUE)))
})

test_that("test toggle alias for checkbox_input", {
  si_str1 <- as.character(checkbox_input("check", "My Label",
                                          type = "toggle", is_marked = FALSE))
  si_str2 <- as.character(toggle("check", "My Label", is_marked = FALSE))
  expect_equal(si_str1, si_str2)
  expect_true(any(grepl("toggle",
                        si_str2, fixed = TRUE)))
})
