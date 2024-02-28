#' Create Semantic DT Table
#'
#' This creates DT table styled with Semantic UI.
#'
#' @param ... datatable parameters, check \code{?DT::datatable} to learn more.
#' @param options datatable options, check \code{?DT::datatable} to learn more.
#' @param style datatable style, check \code{?DT::datatable} to learn more.
#' @param class datatable class, check \code{?DT::datatable} to learn more.
#'
#' @examples
#' if (interactive()){
#'  library(shiny)
#'  library(shiny.semantic)
#'
#'  ui <- semanticPage(
#'    semantic_DTOutput("table")
#'  )
#'  server <- function(input, output, session) {
#'    output$table <- DT::renderDataTable(
#'      semantic_DT(iris)
#'    )
#'  }
#'  shinyApp(ui, server)
#' }
#'
#' @export
semantic_DT <- function(..., options = list(), style = "semanticui", class = 'ui small compact table') {
  DT::datatable(
    ...,
    options = options,
    class = class,
    style = style,
    rownames = FALSE
  )
}

#' Semantic DT Output
#'
#' @param ... datatable parameters, check \code{?DT::datatable} to learn more.
#'
#' @return DT Output with semanitc style
#' @export
semantic_DTOutput <- function(...) {
  DT::DTOutput(...)
}
