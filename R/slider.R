#' Create Semantic UI Slider / Range
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
#' Change the value of a \code{\link{slider_input}} input on the client.
#'
#' @param session The \code{session} object passed to function given to \code{shinyServer}.
#' @param input_id The id of the input object
#' @param value The value to be selected for the sldier (lower value if using range).
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#'   shinyApp(
#'     ui = semanticPage(
#'       p("The first slider controls the second"),
#'       slider_input("control", "Controller:", min = 0, max = 20, value = 10,
#'                    step = 1),
#'       slider_input("receive", "Receiver:", min = 0, max = 20, value = 10,
#'                    step = 1)
#'     ),
#'     server = function(input, output, session) {
#'       observe({
#'         update_slider(session, "receive", value = input$control)
#'       })
#'     }
#'   )
#' }
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

