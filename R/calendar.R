#' Create Semantic UI Calendar
#'
#' This creates a default calendar input using Semantic UI. The input is available
#' under \code{input[[input_id]]}.
#'
#' @param input_id Input name. Reactive value is available under \code{input[[input_id]]}.
#' @param value Initial value of the numeric input.
#' @param placeholder Text visible in the input when nothing is inputted.
#' @param type Select from \code{'year'}, \code{'month'}, \code{'date'} and \code{'time'}
#' @param min Minimum allowed value.
#' @param max Maximum allowed value.
#'
#' @examples
#' # Basic calendar
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shiny.semantic)
#'
#'   ui <- shinyUI(
#'     semanticPage(
#'       title = "Calendar example",
#'       calendar("date"),
#'       p("Selected date:"),
#'       textOutput("selected_date")
#'     )
#'   )
#'
#'    server <- shinyServer(function(input, output, session) {
#'      output$selected_date <- renderText(
#'        as.character(input$date)
#'      )
#'    })
#'
#'    shinyApp(ui = ui, server = server)
#'  }
#'
#' \dontrun{
#' # Calendar with max and min
#' calendar(
#'   name = "date_finish",
#'   placeholder = "Select End Date",
#'   min = "2019-01-01",
#'   max = "2020-01-01"
#' )
#'
#' # Selecting month
#' calendar(
#'   name = "month",
#'   type = "month"
#' )
#' }
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
#' @param session The \code{session} object passed to function given to
#'   \code{shinyServer}.
#' @param input_id ID of the calendar that will be updated
#'
#' @rdname calendar
#'
#' @export
update_calendar <- function(session, input_id, value = NULL, min = NULL, max = NULL) {
  message <- list(value = value, min = min, max = max)
  session$sendInputMessage(input_id, message = message)
}
