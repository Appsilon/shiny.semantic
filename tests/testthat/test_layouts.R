context("layouts")

test_that("test sidebar_panel", {
  # type
  expect_is(sidebar_panel(), "list")
  # simple input
  si_str <- as.character(sidebar_panel(h1("abc"), p("qqq"))$children)
  expect_true(any(grepl("<h1>abc</h1>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("qqq",
                        si_str, fixed = TRUE)))
})

test_that("test main_panel", {
  # type
  expect_is(main_panel(), "list")
  # simple input
  si_str <- as.character(main_panel(h1("abc"), p("qqq"))$children)
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

test_that("test split_layout", {
  # empty imput gives error
  expect_error(sidebar_layout())
  # simple input
  si_str <- as.character(split_layout(p("a")))
  expect_true(any(grepl("<p>a</p>", si_str, fixed = TRUE)))
  expect_true(any(grepl("col1", si_str, fixed = TRUE)))
  expect_false(any(grepl("col2", si_str, fixed = TRUE)))

  # width of columns (number)
  si_str <- as.character(split_layout(
    cell_widths = 300,
    cell_args = "padding: 6px;",
    p("p1")
  ))
  expect_true(any(grepl("grid-template-columns: 300", si_str, fixed = TRUE)))
  # width of columns (vector)
  si_str <- as.character(
    split_layout(cell_widths = c("25%", "75%"), p("p1"), p("p2"))
  )
  expect_true(any(grepl("grid-template-columns: 25% 75%", si_str, fixed = TRUE)))
  si_str <- as.character(
    split_layout(p("p1"), p("p2"), style = "background:red;")
  )
  expect_true(any(grepl("background:red;", si_str, fixed = TRUE)))
})

test_that("test splitLayout", {
  # test equivalence
  expect_equal(split_layout(p("a")), splitLayout(p("a")))
  expect_equal(split_layout(p("a"), cell_widths = c("25%", "75%")),
               splitLayout(p("a"), cellWidths = c("25%", "75%")))
})
