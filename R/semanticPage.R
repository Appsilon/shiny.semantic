#' Add dashboard dependencies to html
#'
#' Internal function that adds dashboard dependencies to html.
#'
#' @return Content with appended dependencies.
getDeps <- function() {
  if (getOption("shiny.minified", TRUE)) {
    javascriptFile <- "semantic.min.js"
    cssFiles <- c("semantic.min.css")
  } else {
    javascriptFile <- "semantic.js"
    cssFiles <- c("semantic.css")
  }

  shiny::tagList(
    htmltools::htmlDependency("semantic-ui", "2.1.8",
                   c(file = system.file("semantic", package = "shiny.semantic")),
                   script = javascriptFile,
                   stylesheet = cssFiles
    )
  )
}

#' Semantic UI page
#'
#' This creates a Semantic page for use in a Shiny app.
#'
#' @param title A title to display in the browser's title bar.
#' @param ... Other arguments to be added as attributes of the main div tag wrapper (e.g. style, class etc.)
#'
#' @export
semanticPage <- function(..., title = "") {
  content <- shiny::tags$div(class = "wrapper", ...)

  shiny::tagList(
    getDeps(),
    shiny::tags$head(shiny::tags$title(title)),
    shiny::tags$body(style = "min-height: 611px;", content)
  )
}

