#' Create Semantic DT Table
#'
#' This creates DT table styled with Semantic UI.
#'
#' @param ... datatable parameters, check \code{?DT::datatable} to learn more.
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
semantic_DT <- function(...) {
  DT::datatable(..., options = list(),
                class = 'ui small compact table',
                style = "semanticui",
                rownames = FALSE)
}

#' Semantic DT Output
#'
#' @param ... datatable parameters, check \code{?DT::datatable} to learn more.
#'
#' @return DT Output with semanitc style
semantic_DTOutput <- function(...) {
    DT::DTOutput(...)
}
