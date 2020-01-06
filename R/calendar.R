#' Create Semantic UI Calendar
#'
#' This creates a default calendar input using Semantic UI. The input is available
#' under \code{input[[name]]}.
#'
#' @param name Input name. Reactive value is available under \code{input[[name]]}.
#' @param value Initial value of the numeric input.
#' @param placeholder Text visible in the input when nothing is inputted.
#' @param type Select from \code{'year'}, \code{'month'}, \code{'date'} and \code{'time'}
#' @param min Minimum allowed value.
#' @param max Maximum allowed value.
#'
#' @details
#' The inputs are updateable by using \code{\link[shiny]{updateNumericInput}}.
#'
#' @examples
#' # Text input
#' uiinput(
#'   tags$label("Numeric Input"),
#'   uinumberinput("ex", 10)
#' )
#'
#' @export
uicalendar <- function(name, value = NULL, placeholder = NULL, type = "date", min = NA, max = NA) {
  div(
    id = name, class = "ui calendar", `data-type` = type, `data-date` = value,
    `data-min-date` = min, `data-max-date` = max,
    div(
      class = "ui input left icon",
      tags$i(class = "calendar icon"),
      tags$input(type = "text", placeholder = placeholder)
    )
  )
}
