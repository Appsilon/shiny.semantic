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
  # empty input gives error
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

test_that("test vertical_layout", {
  # empty input gives error
  expect_error(vertical_layout())
  # simple input
  si_str <- as.character(vertical_layout(h1("H"), p("a")))
  expect_true(any(grepl("<h1>H</h1>", si_str, fixed = TRUE)))
  expect_true(any(grepl("<p>a</p>", si_str, fixed = TRUE)))
  expect_true(any(grepl("row1", si_str, fixed = TRUE)))
  expect_false(any(grepl("row22", si_str, fixed = TRUE)))

  # check parameters passed to cell
  si_str <- as.character(vertical_layout(
    cell_args = "padding: 6px; background: red;",
    p("p1")
  ))
  expect_true(any(grepl("background: red", si_str, fixed = TRUE)))

  # test row_heights param
  si_str <- as.character(vertical_layout(h1("H"), p("a"), rows_heights = "20px"))
  expect_true(any(grepl("grid-template-rows: 20px 20px;", si_str, fixed = TRUE)))
  si_str <- as.character(vertical_layout(h1("H"), p("a"),
                                         rows_heights = c("20px", "40px")))
  expect_true(any(grepl("grid-template-rows: 20px 40px;", si_str, fixed = TRUE)))
})


test_that("test verticalLayout", {
  v1 <- vertical_layout(p("a"), adjusted_to_page = F)
  v2 <- verticalLayout(p("a"))
  expect_equal(v1,v2)
})

test_that("test flow_layout", {
  actual <- as.character(flow_layout(
    cell_args = list(class = "cell"),
    cell_width = "30%",
    column_gap = "15px",
    row_gap = 10,
    shiny::tags$p("a"),
    shiny::tags$p("b")
  ))
  has <- function(expected) {
    any(grepl(expected, actual, fixed = TRUE))
  }
  expect_true(has("display: grid"))
  expect_true(has("align-self: start"))
  expect_true(has('class="cell"'))
  expect_true(has("grid-template-columns: repeat(auto-fill, 30%)"))
  expect_true(has("column-gap: 15px"))
  expect_true(has("row-gap: 10px"))
  expect_true(has("<p>a</p>"))
  expect_true(has("<p>b</p>"))
})

test_that("test flowLayout", {
  actual <- as.character(flowLayout(
    cellArgs = list(class = "cell"),
    shiny::tags$p("a")
  ))
  expected <- as.character(flow_layout(
    cell_args = list(class = "cell"),
    shiny::tags$p("a")
  ))
  expect_equal(actual, expected)
})
