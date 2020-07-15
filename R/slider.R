#' Create Semantic UI Slider
#'
#' @description
#' This creates a slider input using Semantic UI. Slider is already initialized and
#' available under \code{input[[input_id]]}. Use Range for range of values.
#'
#' @param input_id Input name. Reactive value is available under \code{input[[input_id]]}.
#' @param value The initial value to be selected for the sldier (lower value if using range).
#' @param min The minimum value allowed to be selected for the slider.
#' @param max The maximum value allowed to be selected for the slider.
#' @param step The interval between each selectable value of the slider.
#' @param class UI class of the slider. Can include \code{"Labeled"} and \code{"ticked"}.
#'
#' @details
#' Use \code{\link{update_slider}} to update the slider/range within the shiny session.
#'
#' @rdname slider
#'
#' @examples
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shiny.semantic)
#'
#'   # Slider example
#'   ui <- shinyUI(
#'     semanticPage(
#'       title = "Slider example",
#'       tags$br(),
#'       slider_input("slider", 10, 0, 20),
#'       p("Selected value:"),
#'       textOutput("slider")
#'     )
#'   )
#'
#'    server <- shinyServer(function(input, output, session) {
#'      output$slider <- renderText(input$slider)
#'    })
#'
#'    shinyApp(ui = ui, server = server)
#'
#'    # Range example
#'    ui <- shinyUI(
#'      semanticPage(
#'        title = "Range example",
#'        tags$br(),
#'        range_input("range", 10, 15, 0, 20),
#'        p("Selected values:"),
#'        textOutput("range")
#'     )
#'   )
#'
#'    server <- shinyServer(function(input, output, session) {
#'      output$range <- renderText(paste(input$range, collapse = " - "))
#'    })
#'
#'    shinyApp(ui = ui, server = server)
#'
#'  }
#'
#' @seealso update_slider for input updates,
#' \url{https://fomantic-ui.com/modules/slider.html} for preset classes.
#'
#' @export
slider_input <- function(input_id, value, min, max, step = 1, class = NULL) {
  div(
    id = input_id, class = paste("ui slider", class),
    `data-min` = min, `data-max` = max, `data-step` = step, `data-start` = value
  )
}

#' @rdname slider
#' @export
sliderInput <- function(inputId, label, min, max, value, step = 1, width = NULL, ...) {
  check_extra_arguments(list(...))
  form(
    style = if (!is.null(width)) glue::glue("width: {shiny::validateCssUnit(width)};"),
    label(label),
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

#' @rdname slider
#' @export
rangeInput <- function(inputId, label, min, max, value, step = 1, width = NULL, ...) {
  check_extra_arguments(list(...))
  form(
    style = if (!is.null(width)) glue::glue("width: {shiny::validateCssUnit(width)};"),
    label(label),
    range_input(inputId, value, min, max, step = step)
  )
}

#' Update slider Semantic UI component
#'
#' Change the value of a \code{\link{uislider}} input on the client.
#'
#' @param session The \code{session} object passed to function given to \code{shinyServer}.
#' @param name The id of the input object
#' @param value The value to be selected for the sldier (lower value if using range).
#'
#' @seealso slider
#'
#' @rdname update_slider
#' @export
update_slider <- function(session, input_id, value) {
  message <- list(value = jsonlite::toJSON(value))
  session$sendInputMessage(input_id, message)
}

#' @rdname update_slider
#' @param value2 The upper value of the slider.
#'
#' @export
update_range <- function(session, input_id, value, value2) {
  message <- list(value = jsonlite::toJSON(c(value, value2)))
  session$sendInputMessage(input_id, message)
}

#' @rdname update_slider
#' @export
updateSliderInput <- function(session, inputId, value,  ...) {
  check_extra_arguments(list(...))
  update_slider(session, inputId, value)
}

#' @rdname update_slider
#' @export
updateRangeInput <- function(session, inputId, value, value2) {
  update_range(session, inputId, value, value2)
}
