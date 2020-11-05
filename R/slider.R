#' Create Semantic UI Slider / Range
#'
#' @description
#' This creates a slider input using Semantic UI. Slider is already initialized and
#' available under `input[[input_id]]`. Use Range for range of values.
#'
#' @param input_id Input name. Reactive value is available under `input[[input_id]]`.
#' @param value The initial value to be selected for the sldier (lower value if using range).
#' @param min The minimum value allowed to be selected for the slider.
#' @param max The maximum value allowed to be selected for the slider.
#' @param step The interval between each selectable value of the slider.
#' @param class UI class of the slider. Can include `"Labeled"` and `"ticked"`.
#'
#' @details
#' Use [update_slider()] to update the slider/range within the shiny session.
#'
#' @rdname slider
#'
#' @example inst/examples/slider_input.R
#'
#' @seealso update_slider for input updates,
#' <https://fomantic-ui.com/modules/slider.html> for preset classes.
#'
#' @export
slider_input <- function(input_id, value, min, max, step = 1, class = NULL) {
  div(
    id = input_id, class = paste("ui slider", class),
    `data-min` = min, `data-max` = max, `data-step` = step, `data-start` = value
  )
}

#' @param inputId Input name.
#' @param label Display label for the control, or NULL for no label.
#' @param width character with width of slider.
#' @param ... additional arguments
#' @rdname slider
#' @export
sliderInput <- function(inputId, label, min, max, value, step = 1, width = NULL, ...) {
  warn_unsupported_args(list(...))
  form(
    style = if (!is.null(width)) glue::glue("width: {shiny::validateCssUnit(width)};"),
    tags$label(label),
    slider_input(inputId, value, min, max, step = step)
  )
}

#' @rdname slider
#' @param value2 The initial upper value of the slider.
#'
#' @export
range_input <- function(input_id, value, value2, min, max, step = 1, class = NULL) {
  div(
    id = input_id, class = paste("ui range slider", class),
    `data-min` = min, `data-max` = max, `data-step` = step, `data-start` = value, `data-end` = value2
  )
}

#' Update slider Semantic UI component
#'
#' Change the value of a [slider_input()] input on the client.
#'
#' @param session The `session` object passed to function given to `shinyServer`.
#' @param input_id The id of the input object
#' @param value The value to be selected for the sldier (lower value if using range).
#'
#' @example inst/examples/update_slider.R
#'
#' @seealso slider_input
#'
#' @rdname update_slider
#' @export
update_slider <- function(session, input_id, value) {
  message <- list(value = jsonlite::toJSON(value))
  session$sendInputMessage(input_id, message)
}

#' @rdname update_slider
#' @param value2 The upper value of the range.
#'
#' @export
update_range_input <- function(session, input_id, value, value2) {
  message <- list(value = jsonlite::toJSON(c(value, value2)))
  session$sendInputMessage(input_id, message)
}

#' @param inputId Input name.
#' @param ... additional arguments
#' @rdname update_slider
#' @export
updateSliderInput <- function(session, inputId, value,  ...) {
  warn_unsupported_args(list(...))
  update_slider(session, inputId, value)
}

