#' Define simple date input with semantic ui styling
#'
#' @param name Input id.
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
date_input <- function(name, label = NULL, value = NULL, min = NULL, max = NULL,
                       style = NULL, icon = uiicon("calendar")) {
  class <- paste(name, "ui input")
  if (!is.null(icon))
    class <- paste(class, "icon")

  shiny::tagList(
    shiny::div(class = class,
               style = style,
               label,
               shiny.semantic::shiny_text_input(
                 name,
                 shiny::tags$input(type = "date", name = name, min = min, max = max),
                 value = value),
               icon))
}
