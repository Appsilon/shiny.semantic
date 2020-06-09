context("tables")

test_that("test semantic table UI (semantic_DTOutput)", {
  # type
  expect_is(semantic_DTOutput("iris"), "shiny.tag.list")
  # standard semantic_DTOutput call
  si_str <- as.character(semantic_DTOutput("iris"))
  expect_true(any(grepl("datatables html-widget html-widget-output",
                         si_str, fixed = TRUE)))
  expect_true(any(grepl("iris",
                         si_str, fixed = TRUE)))
})
