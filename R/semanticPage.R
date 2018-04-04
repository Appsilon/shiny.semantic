#' Add dashboard dependencies to html
#'
#' Internal function that adds dashboard dependencies to html.
#'
#' @return Content with appended dependencies.
get_dependencies <- function() {
  if (getOption("shiny.minified", TRUE)) {
    javascript_file <- "semantic.min.js"
    css_files <- c("semantic.min.css")
  } else {
    javascript_file <- "semantic.js"
    css_files <- c("semantic.css")
  }

  file <- system.file("semantic", package = "shiny.semantic")
  shiny::tagList(
    htmltools::htmlDependency("semantic-ui",
                              "2.1.8",
                              c(file = file),
                              script = javascript_file,
                              stylesheet = css_files
    ),
    htmltools::htmlDependency("semantic-range",
                              "1.0.0",
                              c(file = system.file("semantic-range", package = "shiny.semantic")),
                              script = "range.js",
                              stylesheet = "range.css"
    )
  )
}

#' Semantic UI page
#'
#' This creates a Semantic page for use in a Shiny app.
#'
#' @param title A title to display in the browser's title bar.
#' @param ... Other arguments to be added as attributes of the main div tag
#' wrapper (e.g. style, class etc.)
#'
#' @export
semanticPage <- function(..., title = "") { # nolint
  content <- shiny::tags$div(class = "wrapper", ...)

  shiny::tagList(
    get_dependencies(),
    shiny::tags$head(
      shiny::tags$title(title),
      shiny::tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0")
    ),
    shiny::tags$body(style = "min-height: 611px;", content)
  )
}
