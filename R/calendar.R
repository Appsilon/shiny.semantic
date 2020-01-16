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
#' @examples
#' # Basic calendar
#' uicalendar(name = "date_start")
#'
#' # Calendar with max and min
#' uicalendar(
#'   name = "date_finish",
#'   placeholder = "Select End Date",
#'   min = "2019-01-01",
#'   max = "2020-01-01"
#' )
#'
#' # Selecting month
#' ui_calendar(
#'   name = "month",
#'   type = "month"
#' )
#' @export
uicalendar <- function(name, value = NULL, placeholder = NULL, type = "date", min = NA, max = NA) {
  cal_widget <- div(
    id = name, class = "ui calendar ss-input-date", `data-type` = type, `data-date` = value,
    div(
      class = "ui input left icon",
      tags$i(class = "calendar icon"),
      tags$input(type = "text", placeholder = placeholder)
    )
  )

  if (!is.na(min)) cal_widget$attribs[["data-min-date"]] <- min
  if (!is.na(max)) cal_widget$attribs[["data-max-date"]] <- max

  cal_widget
}
