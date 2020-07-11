context("modal")

test_that("test modal created", {
  si_str <- as.character(modal())
  expect_true(any(grepl("class=\"ui modal \"",
                        si_str, fixed = TRUE)))
})

test_that("test modal created with no header", {
  si_str <- as.character(modal())
  expect_true(any(grepl("<div class=\"header\"></div>",
                        si_str, fixed = TRUE)))
})

test_that("test modal created with given header", {
  si_str <- as.character(modal(header = "this is a test header"))
  expect_true(any(grepl("this is a test header",
                        si_str, fixed = TRUE)))
})

test_that("test modal created with no content", {
  si_str <- as.character(modal())
  expect_true(any(grepl("<div class=\"content\"></div>",
                        si_str, fixed = TRUE)))
})

test_that("test modal created with given content", {
  si_str <- as.character(modal("this is a test content"))
  expect_true(any(grepl("this is a test content",
                        si_str, fixed = TRUE)))
})

test_that("test modal created with default footer", {
  si_str <- as.character(modal())
  expect_true(any(grepl("<div class=\"ui button negative\">Cancel</div>",
                        si_str, fixed = TRUE)))
  expect_true(any(grepl("<div class=\"ui button positive\">OK</div>",
                        si_str, fixed = TRUE)))
})

test_that("test modal created with given footer", {
  si_str <- as.character(modal(footer = "this is a test footer"))
  expect_true(any(grepl("this is a test footer",
                        si_str, fixed = TRUE)))
})

test_that("test modal created with given target", {
  si_str <- as.character(modal(id = "test-modal", target = "targetelement"))
  expect_true(any(
    grepl(
      "$('#test-modal').modal('attach events', '#targetelement', 'show')",
      si_str,
      fixed = TRUE
    )
  ))
})

test_that("test modal created with given settings", {
  si_str <-
    as.character(modal(id = "test-modal", settings = list(
      c("transition", "fade"), c("closable", "false")
    )))
  expect_true(any(
    grepl(
      "$('#test-modal').modal('setting', 'closable', false)",
      si_str,
      fixed = TRUE
    )
  ))
  expect_true(any(
    grepl(
      "$('#test-modal').modal('setting', 'transition', 'fade')",
      si_str,
      fixed = TRUE
    )
  ))
})

test_that("test modal created with arguments list", {
  si_str <- as.character(modal(
    header = list(class = "ui icon", icon("archive")),
    content = div(class = "children", "content"),
    footer = list(id = "footer_modal_id", "footer")
  ))
  expect_true(any(grepl(
    "<div class=\"actions\" id=\"footer_modal_id\">footer</div>",
    si_str, fixed = TRUE)))
  expect_true(any(grepl(
    "<div class=\"content\">\n    <div class=\"children\">content</div>",
    si_str, fixed = TRUE)))
  expect_true(any(grepl(
    "<div class=\"header ui icon\">\n    <i class=\"archive icon\"></i>",
    si_str, fixed = TRUE)))
})
