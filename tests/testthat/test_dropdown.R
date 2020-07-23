context("dropdown")

test_that("test dropdown_input", {
  # type
  expect_is(dropdown_input("a", c(1,2,3)), "shiny.tag")
  # wrong input
  expect_error(dropdown_input("a"),
               "argument \"choices\" is missing, with no default")
  # simple input
  si_str <- as.character(dropdown_input("a", c(1,2,3)))
  expect_true(any(grepl("<div class=\"item\" data-value=\"1\">1</div>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("<div class=\"item\" data-value=\"2\">2</div>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("<div class=\"item\" data-value=\"3\">3</div>",
                        si_str, fixed = TRUE)))
  expect_false(any(grepl("<div class=\"item\" data-value=\"0\">0</div>",
                        si_str, fixed = TRUE)))
})
