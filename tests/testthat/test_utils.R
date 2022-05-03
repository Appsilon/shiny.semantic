context("utils")

test_that("test parse_val", {
  expect_equal(parse_val(NULL), "")
  p <- parse_val("{\"a\":3, \"b\":4}")
  expect_equal(p$a, 3)
  expect_equal(p$b, 4)
  expect_equal(names(p), c("a", "b"))
})

test_that("test check_proper_color", {
  expect_error(check_proper_color("blue1"))
  expect_silent(check_proper_color("blue"))
})

test_that("test warn_unsupported_args", {
  expect_null(warn_unsupported_args(NULL))
  expect_error(warn_unsupported_args(1), "Wrong input type!")
  expect_warning(warn_unsupported_args(c("a","b")), "arguments: `a,b` are not supported yet")
  expect_warning(warn_unsupported_args(list(a=1,b=2)), "arguments: `a,b` are not supported yet")
  expect_failure(
    expect_warning(warn_unsupported_args(list()))
  )
})
