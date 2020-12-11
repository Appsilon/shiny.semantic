#' Create Semantic UI Calendar
#'
#' This creates a default calendar input using Semantic UI. The input is available
#' under `input[[input_id]]`.
#'
#' @param input_id Input name. Reactive value is available under `input[[input_id]]`.
#' @param value Initial value of the numeric input.
#' @param placeholder Text visible in the input when nothing is inputted.
#' @param type Select from `'year'`, `'month'`, `'date'` and `'time'`
#' @param min Minimum allowed value.
#' @param max Maximum allowed value.
#'
#' @example inst/examples/calendar.R
#' @rdname calendar
#' @export
calendar <- function(input_id, value = NULL, placeholder = NULL, type = "date", min = NA, max = NA) {
  cal_widget <-
    div(
      id = input_id, class = "ui calendar ss-input-date", `data-type` = type, `data-date` = value,
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

#' Update UI calendar
#'
#' This function updates the date on a calendar
#'
#' @param session The `session` object passed to function given to
#'   `shinyServer`.
#' @param input_id ID of the calendar that will be updated
#'
#' @rdname calendar
#'
#' @export
update_calendar <- function(session, input_id, value = NULL, min = NULL, max = NULL) {
  message <- list(value = value, min = min, max = max)
  session$sendInputMessage(input_id, message = message)
}
