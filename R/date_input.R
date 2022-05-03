#' Define simple date input with Semantic UI styling
#'
#' @param input_id Input id.
#' @param label Label to be displayed with date input.
#' @param value Default date chosen for input.
#' @param min Minimum date that can be selected.
#' @param max Maximum date that can be selected.
#' @param style Css style for widget.
#'
#' @examples
#' if (interactive()) {
#' # Below example shows how to implement simple date range input using \code{date_input}
#'
#' library(shiny)
#' library(shiny.semantic)
#'
#' ui <- shinyUI(
#'   semanticPage(
#'     title = "Date range example",
#'     uiOutput("date_range"),
#'     p("Selected dates:"),
#'     textOutput("selected_dates")
#'   )
#' )
#'
#' server <- shinyServer(function(input, output, session) {
#'   output$date_range <- renderUI({
#'     tagList(
#'       tags$div(tags$div(HTML("From")),
#'                date_input("date_from", value = Sys.Date() - 30, style = "width: 10%;")),
#'       tags$div(tags$div(HTML("To")),
#'                date_input("date_to", value = Sys.Date(), style = "width: 10%;"))
#'     )
#'   })
#'
#'   output$selected_dates <- renderPrint({
#'     c(input$date_from, input$date_to)
#'   })
#' })
#'
#'shinyApp(ui = ui, server = server)
#'}
#'
#' @export
#' @rdname date_input
date_input <- function(input_id, label = NULL, value = NULL, min = NULL, max = NULL, style = NULL) {
  if (is.null(min)) min <- NA
  if (is.null(max)) max <- NA

    shiny::div(
      class = paste(input_id, "ui input"),
      style = style,
      tags$label(label),
      calendar(input_id, value, min = min, max = max)
    )
}

#' @param inputId Input id.
#' @param width character width of the object
#' @param ... other arguments
#'
#' @rdname date_input
#' @export
dateInput <- function(inputId, label = NULL, value = NULL, min = NULL, max = NULL, width = NULL, ...) {
  # TODO match arguments with shiny::dateInput
  args_list <- list(...)
  args_list$input_id <- inputId
  args_list$label <- label
  args_list$value <- value
  args_list$min <- min
  args_list$max <- max
  args_list$style <- if (!is.null(width)) paste0("width: ", width, "; ", args_list$style) else args_list$style
  do.call(date_input, args_list)
}
