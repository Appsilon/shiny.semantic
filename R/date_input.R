#' Define simple date input with semantic ui styling
#'
#' @param input_id Input id.
#' @param label Label to be displayed with date input.
#' @param value Default date chosen for input.
#' @param min Minimum date that can be selected.
#' @param max Maximum date that can be selected.
#' @param style Css style for widget.
#' @param icon Icon that should be displayed on widget.
#'
#' @examples
#' if (interactive()) {
#' # Below example shows how to imlement simple date range input using \code{date_input}
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
date_input <- function(input_id, label = NULL, value = NULL, min = NULL, max = NULL,
                       style = NULL, icon = uiicon("calendar")) {
  class <- paste(input_id, "ui input")
  if (!is.null(icon))
    class <- paste(class, "icon")

  shiny::tagList(
    shiny::div(class = class,
               style = style,
               label,
               shiny.semantic::shiny_text_input(
                 input_id,
                 shiny::tags$input(type = "date", name = input_id, min = min, max = max),
                 value = value),
               icon))
}

#' @rdname date_input
dateInput <- function(inputId, label = NULL, icon = NULL, value = NULL,
                      min = NULL, max = NULL, width = NULL, ...) {
  # TODO match arguments with shiny::dateInput
  args_list <- list(...)
  args_list$input_id <- inputId
  args_list$label <- label
  args_list$icon <- icon
  args_list$value <- value
  args_list$min <- min
  args_list$max <- max
  args_list$style <- if (!is.null(width)) paste0("width: ", width, "; ", args_list$style) else args_list$style
  do.call(date_input, args_list)
}
