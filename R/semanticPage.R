# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

# Add an html dependency, without overwriting existing ones
appendDependencies <- function(x, newDependencies) {
  if (inherits(newDependencies, "html_dependency")) newDependencies <- list(newDependencies)
  existingDependencies <- attr(x, "html_dependencies", TRUE)
  htmltools::htmlDependencies(x) <- c(existingDependencies, newDependencies)
  x
}

# Add dashboard dependencies to a tag object
addDeps <- function(x) {
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

  appendDependencies(x, dashboardDeps)
}

#' Semantic-ui page
#'
#' This creates a semantic-ui page for use in a Shiny app.
#'
#' @param header A header created by \code{dashboardHeader}.
#' @param sidebar A sidebar created by \code{dashboardSidebar}.
#' @param body A body created by \code{dashboardBody}.
#' @param title A title to display in the browser's title bar. If no value is
#'   provided, it will try to extract the title from the \code{dashboardHeader}.
#'
#' @export
semanticPage <- function(title = "", ...) {
  content <- div(class = "wrapper", ...)

  addDeps(
    shiny::tags$body(style = "min-height: 611px;", shiny::bootstrapPage(content, title = title))
  )
}

input <- function(class = "ui input", placeholder = "") {
  div(class = class,
    tags$input(type="text", placeholder = placeholder)
  )
}

menu <- function(class = "ui item menu", ...) {
  div(class = class, ...)
}

menuItem <- function(..., class = "item") {
  tags$a(class = class, ...)
}
divMenuItem <- function(content, class = "item") {
  div(class = class, content)
}
img <- function(src, ...) {
  tags$img(src = src, ...)
}
uiicon <- function(type) {
  tags$i(class = paste(type, "icon"))
}
