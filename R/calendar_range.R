#' Create Semantic UI Calendar Range
#'
#' This is a wrapper for creating calendar ranges using Semantic UI calendars.
#' It creates a form composed of two calendars. The selected range values are
#' available under \code{input[[input_id]]}.
#'
#' @details The Semantic UI calendar range automatically pops up the end range
#' calendar when changing the start range. Therefore events are only sent on
#' changes done in the end range calendar.
#'
#' @param input_id Input name. Reactive value is available under \code{input[[input_id]]}.
#' @param type Select from \code{'year'}, \code{'month'}, \code{'date'} and \code{'time'}.
#' @param start_value Initial value of the calendar defining the start of the range.
#' @param end_value Initial value of the calendar defining the end of the range.
#' @param start_placeholder Text visible in the start calendar input when nothing is inputted.
#' @param end_placeholder Text visible in the end calendar input when nothing is inputted.
#' @param min Minimum allowed value in both calendars.
#' @param max Maximum allowed value in both calendars.
#' @param start_label Label text in the start calendar.
#' @param end_label Label text in the end calendar.
#'
#' @rdname calendar_range
#' @export
#'
calendar_range <- function(input_id, type = "date", start_value = NULL, end_value = NULL,
                           start_placeholder = NULL, end_placeholder = NULL, min = NA, max = NA,
                           start_label = NULL, end_label = NULL) {
  if (!is.null(start_value)) start_value <- format(as.Date(start_value), "%Y/%m/%d")
  if (!is.null(end_value)) end_value <- format(as.Date(end_value), "%Y/%m/%d")
  if (!is.na(min)) min <- format(as.Date(min), "%Y/%m/%d")
  if (!is.na(max)) max <- format(as.Date(max), "%Y/%m/%d")

  create_cal_widget <- function(type, value, placeholder, min, max) {
    cal_widget <- div(
      class = "ui calendar ss-input-date-range-item",
      `data-type` = type,
      `data-date` = start_value,
      div(
        class = "ui input left icon",
        tags$i(class = "calendar icon"),
        tags$input(type = "text", placeholder = start_placeholder)
      )
    )

    if (!is.na(min)) {
      cal_widget$attribs[["data-min-date"]] <- min
    }

    if (!is.na(max)) {
      cal_widget$attribs[["data-msx-date"]] <- max
    }

    cal_widget
  }

  start_cal_widget <- create_cal_widget(
    type = type,
    value = start_value,
    placeholder = start_placeholder,
    min = min,
    max = max
  )

  end_cal_widget <- create_cal_widget(
    type = type,
    value = end_value,
    placeholder = end_placeholder,
    min = min,
    max = max
  )

  cal_range_widget <- div(
    id = input_id,
    class = "ui form semantic-input-date-range",
    div(
      class = "two fields",
      div(
        class = "field",
        tags$label(start_label),
        start_cal_widget
      ),
      div(
        class = "field",
        tags$label(end_label),
        end_cal_widget
      )
    )
  )

  cal_range_widget
}

#'
#' Update UI calendar range
#'
#' This function updates the dates on a calendar range.
#'
#' @param session The \code{session} object passed to function given to
#'   \code{shinyServer}.
#'
#' @param input_id ID of the calendar range that will be updated
#'
#' @rdname calendar_range
#' @export
update_calendar_range <- function(session, input_id, start_value = NULL, end_value = NULL, min = NULL, max = NULL) {
  if (!is.null(start_value)) value <- format(as.Date(start_value), "%Y/%m/%d")
  if (!is.null(end_value)) value <- format(as.Date(end_value), "%Y/%m/%d")
  if (!is.null(min)) min <- format(as.Date(min), "%Y/%m/%d")
  if (!is.null(max)) max <- format(as.Date(max), "%Y/%m/%d")

  message <- list(
    start_value = start_value,
    end_value = end_value,
    min = min,
    max = max
  )

  session$sendInputMessage(input_id, message = message)
}
