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

init_driver <- function(app) {
  shinytest2::AppDriver$new(app)
}

test_app <- function(value, initial, multiple, choices = NULL) {
  type <- if (multiple) "multiple" else ""
  shiny::shinyApp(
    ui = semanticPage(
      dropdown_input("dropdown", LETTERS, value = initial, type = type),
      shiny::actionButton("trigger", "Trigger")
    ),
    server = function(input, output, session) {
      shiny::observeEvent(input$trigger, {
        update_dropdown_input(session, "dropdown", value = value, choices = choices)
      })
    }
  )
}

describe("update_dropdown_input", {
  skip_on_cran()
  local_edition(3)

  it("is a no-op with NULL value", {
    # Arrange
    initial_value <- "A"
    app <- init_driver(test_app(value = NULL, initial = initial_value, multiple = FALSE))
    withr::defer(app$stop())

    # Act
    app$click("trigger")

    # Assert
    expect_equal(
      app$get_value(input = "dropdown"),
      initial_value
    )
  })

  it("is a no-op with a value not in choices", {
    # Arrange
    initial_value <- "A"
    app <- init_driver(test_app(value = "asdf", initial = initial_value, multiple = FALSE))
    withr::defer(app$stop())

    # Act
    app$click("trigger")

    # Assert
    expect_equal(
      app$get_value(input = "dropdown"),
      initial_value
    )
  })

  it("updates a single-selection dropdown with a new value", {
    # Arrange
    value <- "A"
    app <- init_driver(test_app(value = value, initial = NULL, multiple = FALSE))
    withr::defer(app$stop())

    # Act
    app$click("trigger")

    # Assert
    expect_equal(
      app$get_value(input = "dropdown"),
      value
    )
  })

  it("updates a multi-selection dropdown with new values", {
    # Arrange
    value <- c("A", "B")
    app <- init_driver(test_app(value = value, initial = NULL, multiple = TRUE))
    withr::defer(app$stop())

    # Act
    app$click("trigger")

    # Assert
    expect_equal(
      app$get_value(input = "dropdown"),
      value
    )
  })

  it("clears a single-selection dropdown with \"\" (empty string)", {
    # Arrange
    app <- init_driver(test_app(value = "", initial = "A", multiple = FALSE))
    withr::defer(app$stop())

    # Act
    app$click("trigger")

    # Assert
    expect_equal(
      app$get_value(input = "dropdown"),
      ""
    )
  })

  it("clears a multi-selection dropdown with \"\" (empty string)", {
    # Arrange
    app <- init_driver(test_app(value = "", initial = "A", multiple = TRUE))
    withr::defer(app$stop())

    # Act
    app$click("trigger")

    # Assert
    expect_null(
      app$get_value(input = "dropdown")
    )
  })

  it("clears a single-selection dropdown with character(0)", {
    # Arrange
    app <- init_driver(test_app(value = character(0), initial = "A", multiple = FALSE))
    withr::defer(app$stop())

    # Act
    app$click("trigger")

    # Assert
    expect_equal(
      app$get_value(input = "dropdown"),
      ""
    )
  })

  it("clears a multi-selection dropdown with character(0)", {
    # Arrange
    app <- init_driver(test_app(value = character(0), initial = "A", multiple = TRUE))
    withr::defer(app$stop())

    # Act
    app$click("trigger")

    # Assert
    expect_null(
      app$get_value(input = "dropdown")
    )
  })

  it("updates choices and clears selection in a single-selection dropdown when provided with choices and a NULL value", {
    # Arrange
    app <- init_driver(test_app(value = NULL, initial = "abc", multiple = FALSE, choices = c("abc", "xyz")))
    withr::defer(app$stop())

    # Act
    app$click("trigger")

    # Assert
    expect_equal(
      app$get_value(input = "dropdown"),
      ""
    )
  })

  it("updates choices and clears selection in a multi-selection dropdown when provided with choices and a NULL value", {
    # Arrange
    app <- init_driver(test_app(value = NULL, initial = "abc", multiple = TRUE, choices = c("abc", "xyz")))
    withr::defer(app$stop())

    # Act
    app$click("trigger")

    # Assert
    expect_null(
      app$get_value(input = "dropdown")
    )
  })

  it("updates choices and sets selection in a single-selection dropdown when provided with both choices and a value", {
    # Arrange
    value <- "xyz"
    app <- init_driver(test_app(value = value, initial = NULL, multiple = FALSE, choices = c("abc", "xyz")))
    withr::defer(app$stop())

    # Act
    app$click("trigger")

    # Assert
    expect_equal(
      app$get_value(input = "dropdown"),
      value
    )
  })

  it("updates choices and sets selection in a multi-selection dropdown when provided with both choices and a value", {
    # Arrange
    value <- c("abc", "xyz")
    app <- init_driver(test_app(value = value, initial = NULL, multiple = TRUE, choices = c("abc", "xyz")))
    withr::defer(app$stop())

    # Act
    app$click("trigger")

    # Assert
    expect_equal(
      app$get_value(input = "dropdown"),
      value
    )
  })
})
