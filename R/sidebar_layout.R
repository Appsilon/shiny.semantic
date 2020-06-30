#' Sidebar layout composed of main and sidebar panels
#'
#'
#' @export
#'
sidebar_panel <- function(..., width = 4) {
  div(style = glue::glue("flex-grow: {width}"),
      tags$form(class = "well",
                ...))
}
#'
#' @export
#'
main_panel <- function(..., width = 8) {
  div(style = glue::glue("flex-grow: {width}"),
      ...)
}
#'
#' @param text Some text
#'
#' @return Semantic layout composed of main and sidebar panels
#'
#' @examples
#' sidebar_layout()
#'
#' @export
#'
sidebar_layout <- function(sidebar_panel,
                           main_panel,
                           position = c("left", "right"),
                           fluid = TRUE) {
  position <- match.arg(position)
  if (position == "left") {
    first_panel <- sidebar_panel
    second_panel <- main_panel
  }
  else if (position == "right") {
    first_panel <- main_panel
    second_panel <- sidebar_panel
  }
  if (fluid)
    fluidRow(class = "sem-fluid", first_panel, second_panel)
  else
    fixedRow(class = "sem-fixed", first_panel, second_panel)
}
