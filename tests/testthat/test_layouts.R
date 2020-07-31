context("layouts")

test_that("test get_row", {
  # wrong input
  expect_error(get_row())
  # simple html input generates html character
  expect_is(get_row(p("a")), "character")
  # test output
  si_str <- as.character(get_row(p("a")))
  expect_true(any(grepl("<div class='row' style='padding: 20px;'><p>a</p></div>",
                        si_str, fixed = TRUE)))
})

test_that("test sidebar_panel", {
  # type
  expect_is(sidebar_panel(), "list")
  # simple input
  si_str <- as.character(sidebar_panel(h1("abc"), p("qqq"))$panel)
  expect_true(any(grepl("<h1>abc</h1>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("qqq",
                        si_str, fixed = TRUE)))
})

test_that("test main_panel", {
  # type
  expect_is(main_panel(), "list")
  # simple input
  si_str <- as.character(main_panel(h1("abc"), p("qqq"))$panel)
  expect_true(any(grepl("<h1>abc</h1>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("qqq",
                        si_str, fixed = TRUE)))
})

test_that("test sidebar_layout", {
  # type
  expect_error(sidebar_layout(), "argument \"sidebar_panel\" is missing")
  expect_error(sidebar_layout(sidebar_panel()),
               "argument \"main_panel\" is missing")
  # empty input
  expect_is(sidebar_layout(sidebar_panel(),main_panel()), "list")
})
