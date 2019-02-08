context("dsl")

test_that("test date_input missing input", {
  expect_error(date_input())
})

test_that("test date_input output type", {
  expect_is(date_input("date_from", value = Sys.Date()),
            "shiny.tag.list")
})

test_that("test date_input basic input", {
  si_str <- as.character(
    date_input("date_from", value = Sys.Date())
  )
  expect_true(any(grepl(paste0("data-value=\"", as.character(Sys.Date()), "\""),
                        si_str, fixed = TRUE)))
  # here we chaeck if style param is passed correctly
  si_str <- as.character(
    date_input("date_from", value = Sys.Date(), style = "width: 10%;")
  )
  expect_true(any(grepl("style=\"width: 10%;\"",
                        si_str, fixed = TRUE)))
})
