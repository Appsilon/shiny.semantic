context("dropdown")

test_that("test dropdown", {
  # test missing input
  expect_error(dropdown_input())
  expect_error(dropdown_input("dd"))
  # test output
  si_str <- as.character(
    dropdown_input("simple_dropdown", LETTERS, value = "A")
  )
  expect_true(any(grepl("<div class=\"item\" data-value=\"C\">C</div>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl(
    "<input type=\"hidden\" name=\"simple_dropdown\" value=\"A\"", si_str, fixed = TRUE
  )))
})

test_that("test dropdown header", {
  # test output
  si_str <- as.character(
    dropdown_input(name = "header_dropdown",
             list("LETTERS" = LETTERS, "month.name" = month.name),
             value = "A")
  )

  expect_true(any(grepl("<div class=\"item\" data-value=\"C\">C</div>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl(
    "<input type=\"hidden\" name=\"header_dropdown\" value=\"A\"", si_str, fixed = TRUE
  )))
  expect_true(any(grepl("<div class=\"header\">month.name</div>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("<div class=\"divider\"></div>",
                        si_str, fixed = TRUE)))
})
