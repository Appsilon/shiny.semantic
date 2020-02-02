#' Create Semantic UI Slider
#'
#' @description
#' This creates a slider input using Semantic UI. Slider is already initialized and
#' available under \code{input[[name]]}.
#'
#' @param name Input name. Reactive value is available under \code{input[[name]]}.
#' @param value The initial value to be selected for the sldier (lower value if using range).
#' @param min The minimum value allowed to be selected for the slider.
#' @param max The maximum value allowed to be selected for the slider.
#' @param step The interval between each selectable value of the slider.
#' @param type UI class of the slider. Can include \code{"Labeled"} and \code{"ticked"}.
#'
#' @details
#' Use \code{\link{update_slider}} to update the slider/range within the shiny session.
#'
#' @rdname uislider
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
#'       uislider("slider", 10, 0, 20),
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
#'        uirange("range", 10, 15, 0, 20),
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
uislider <- function(name, value, min, max, step = 1, type = NULL) {
  div(
    id = name, class = paste("ui slider", type),
    `data-min` = min, `data-max` = max, `data-step` = step, `data-start` = value
  )
}

#' @rdname uislider
#' @param value2 The initial upper value of the slider.
#'
#' @export
uirange <- function(name, value, value2, min, max, step = 1, type = NULL) {
  div(
    id = name, class = paste("ui range slider", type),
    `data-min` = min, `data-max` = max, `data-step` = step, `data-start` = value, `data-end` = value2
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
#' @seealso uislider
#'
#' @rdname update_slider
#' @export
update_slider <- function(session, name, value) {
  message <- list(value = jsonlite::toJSON(value))
  session$sendInputMessage(name, message)
}

#' @rdname update_slider
#' @param value2 The upper value of the slider.
#'
#' @export
update_range <- function(session, name, value, value2) {
  message <- list(value = jsonlite::toJSON(c(value, value2)))
  session$sendInputMessage(name, message)
}
