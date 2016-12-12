#' Internal function that adds an html dependency, without overwriting existing ones.
#'
#' @param content Content to which dependencies need to be added.
#' @param newDependencies Dependencies to be added.
#'
#' @return Content with appended dependencies.
appendDependencies <- function(content, newDependencies) {
  if (inherits(newDependencies, "html_dependency")) newDependencies <- list(newDependencies)
  existingDependencies <- attr(content, "html_dependencies", TRUE)
  htmltools::htmlDependencies(content) <- c(existingDependencies, newDependencies)
  content
}

#' Internal function that adds dashboard dependencies to html.
#'
#' @param content Content to which dependencies need to be added.
#'
#' @return Content with appended dependencies.
addDeps <- function(content) {
  if (getOption("shiny.minified", TRUE)) {
    javascriptFile <- "semantic.min.js"
    cssFiles <- c("semantic.min.css")
  } else {
    javascriptFile <- "semantic.js"
    cssFiles <- c("semantic.css")
  }

  dashboardDeps <- list(
    htmltools::htmlDependency("semantic-ui", "2.1.8",
                   c(file = system.file("semantic", package = "semanticui")),
                   script = javascriptFile,
                   stylesheet = cssFiles
    )
  )

  appendDependencies(content, dashboardDeps)
}

#' Semantic UI page
#'
#' This creates a Semantic page for use in a Shiny app.
#'
#' @param title A title to display in the browser's title bar.
#'
#' @export
semanticPage <- function(title = "", ...) {
  content <- div(class = "wrapper", ...)

  addDeps(
    shiny::tags$body(style = "min-height: 611px;", shiny::bootstrapPage(content, title = title))
  )
}

