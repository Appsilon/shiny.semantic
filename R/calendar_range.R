#' @export
calendar_range <- function(input_id, type = "date", start_value = NULL, end_value = NULL,
                           start_placeholder = NULL, end_placeholder = NULL, min = NA, max = NA) {
  if (!is.null(start_value)) start_value <- format(as.Date(start_value), "%Y/%m/%d")
  if (!is.null(end_value)) end_value <- format(as.Date(end_value), "%Y/%m/%d")
  if (!is.na(min)) min <- format(as.Date(min), "%Y/%m/%d")
  if (!is.na(max)) max <- format(as.Date(max), "%Y/%m/%d")

  start_cal_widget <- div(
    class = "ui calendar ss-input-date-range-item",
    `data-type` = type,
    `data-date` = start_value,
    div(
      class = "ui input left icon",
      tags$i(class = "calendar icon"),
      tags$input(type = "text", placeholder = start_placeholder)
    )
  )

  end_cal_widget <- div(
    class = "ui calendar ss-input-date-range-item",
    `data-type` = type,
    `data-date` = end_value,
    div(
      class = "ui input left icon",
      tags$i(class = "calendar icon"),
      tags$input(type = "text", placeholder = end_placeholder)
    )
  )

  if (!is.na(min)) {
    start_cal_widget$attribs[["data-min-date"]] <- min
    end_cal_widget$attribs[["data-min-date"]] <- min
  }

  if (!is.na(max)) {
    start_cal_widget$attribs[["data-max-date"]] <- max
    end_cal_widget$attribs[["data-max-date"]] <- max
  }

  cal_range_widget <- div(
    id = input_id,
    class = "ui form semantic-input-date-range",
    div(
      class = "two fields",
      div(
        class = "field",
        start_cal_widget
      ),
      div(
        class = "field",
        end_cal_widget
      )
    )
  )

  cal_range_widget
}

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
