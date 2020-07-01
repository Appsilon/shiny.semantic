#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
#' Sidebar layout composed of main and sidebar panels
#'
#' @param ... Content of sidebar panel
#' @param width Specified with of sidebar panel
#'
#' @export
#'
sidebar_panel <- function(..., width = 4) {
  div(style = glue::glue("flex-grow: {width}"),
      tags$form(class = "well",
                ...))
}
#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
#' @param ... Content of main panel
#' @param width Specified with of main panel
#'
#' @export
#'
main_panel <- function(..., width = 8) {
  div(style = glue::glue("flex-grow: {width}"),
      ...)
}
#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
#' @param sidebar_panel Sidebar panel component
#' @param main_panel Main Panel component
#' @param position Position of sidebar panel in regards to main panel
#' @param fluid If TRUE - fluid, else - fixed
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
    divider <- glue::glue("<div class='ui inverted divider'></div>")
    second_panel <- main_panel
  }
  else if (position == "right") {
    first_panel <- main_panel
    second_panel <- sidebar_panel
  }
  if (fluid)
    fluidRow(class = "sem-fluid", first_panel, divider, second_panel)
  else
    fixedRow(class = "sem-fixed", first_panel, second_panel)
}
