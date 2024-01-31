context("modal")

test_that("test modal created", {
  si_str <- as.character(modal())
  expect_true(any(grepl("class=\"ui modal \"",
                        si_str, fixed = TRUE)))
})

test_that("test modal created with no header", {
  si_str <- as.character(modal())
  expect_false(any(grepl("<div class=\"header\"></div>",
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
    header = list(class = "ui icon", shiny.semantic::icon("archive")),
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

test_that("test modalDialog", {
  si_str <- as.character(modalDialog(
    title = "Important message",
    "This is an important message!"
  ))
  expect_true(any(grepl(
    "<h2>Important message</h2>",
    si_str, fixed = TRUE)))
  expect_true(any(grepl(
    "<div class=\"content\">This is an important message!</div>",
    si_str, fixed = TRUE)))

  # warning when not supported arguments passed
  expect_warning(modalDialog(
    title = "Important message",
    "This is an important message!", easyClose = FALSE
  ))

})


testthat::test_that(
  "show_modal with asis as TRUE sends exactly the id passed to the
                    session$sendCustomMessage function",
  {
    # Prepare the stub to check what is passed to the
    # session$sendCustomMessage method
    stub_custom_message <-
      function(message, parameters) {
        list(message = message,
             parameters = parameters)
      }
    mockery::stub(where = show_modal, what = "session$sendCustomMessage", stub_custom_message)
    # Mocking the Shiny session
    session <- shiny::MockShinySession$new()
    # Mocking a module's session
    module_session <- session$makeScope("new")
    # Act
    result <- show_modal("id", session = module_session, asis = TRUE)
    
    # Assert
    testthat::expect_equal(result$message, "showSemanticModal")
    testthat::expect_equal(result$parameters$id, "id")
    testthat::expect_equal(result$parameters$action, "show")
  }
)

testthat::test_that(
  "show_modal with asis as FALSE namespaces the id passed to the
  session$sendCustomMessage function when it IS IN the context
  of a sessionproxy (shiny module)",
  {
    # Prepare the stub to check what is passed to the
    # session$sendCustomMessage method
    stub_custom_message <- function(message, parameters) {
        list(
          message = message,
          parameters = parameters
        )
    }
    mockery::stub(where = show_modal, what = "session$sendCustomMessage", stub_custom_message)
    # Mocking the Shiny session
    session <- shiny::MockShinySession$new()
    # Mocking a module's session
    module_session <- session$makeScope("new")
    # Act
    result <- show_modal("id", session = module_session, asis = FALSE)
    
    # Assert
    testthat::expect_equal(result$message, "showSemanticModal")
    testthat::expect_equal(result$parameters$id, "new-id")
    testthat::expect_equal(result$parameters$action, "show")
  }
)


testthat::test_that(
  "show_modal with asis as FALSE do not namespace the id passed to the
  session$sendCustomMessage function when it IS NOT in the context
  of a sessionproxy (shiny module)",
  {
    # Prepare the stub to check what is passed to the
    # session$sendCustomMessage method
    stub_custom_message <- function(message, parameters) {
      list(
        message = message,
        parameters = parameters
      )
    }
    mockery::stub(where = show_modal, what = "session$sendCustomMessage", stub_custom_message)
    # Mocking the Shiny session
    session <- shiny::MockShinySession$new()
    # Act
    result <- show_modal("id", session = session, asis = FALSE)
    
    # Assert
    testthat::expect_equal(result$message, "showSemanticModal")
    testthat::expect_equal(result$parameters$id, "id")
    testthat::expect_equal(result$parameters$action, "show")
  }
)
