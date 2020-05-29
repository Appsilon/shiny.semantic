#' Create Semantic UI Button
#'
#' @param name The \code{input} slot that will be used to access the value.
#' @param label The contents of the button or link
#' @param icon An optional \code{\link{uiicon}()} to appear on the button.
#' @param class An optional attribute to be added to the button's class. If used
#' paramters like \code{color}, \code{size} are ignored.
#' @param ... Named attributes to be applied to the button
#'
#' @examples
#' uibutton("simple_button", "Press Me!")
#'
#' @export
uibutton <- function(name, label, icon = NULL, class = NULL, ...) {
  tags$button(id = name, class = paste("ui", class, "button"), icon, " ", label, ...)
}


#' Action Button
#'
#' Creates an action button whose value is initially zero, and increments by one
#' each time it is pressed.
#'
#' @inheritParams uibutton
#' @param icon icon type, use \code{uiicon} to insert icon
#' @param size character with button size, accepted values: "mini", "tiny", "small"
#' "medium", "large", "big", "huge", "massive"
#' @param color character with semantic color
#'
#' @return action button object
#' @export
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#' library(shiny.semantic)
#' ui <-
#'   semanticPage(
#'     shinyUI(
#'       actionbutton("button", "My button", icon = uiicon("user"),
#'                    size = "huge", color = "orange")
#'     )
#'   )
#' server <- function(input, output) {
#'   observeEvent(input$button,{
#'     print("Action")
#'   })
#' }
#' shinyApp(ui, server)
#' }
actionbutton <- function(name, label, icon = NULL, size = "medium",
                         color = NULL, ...) {
  class <- paste(c(size, color, "action-button"), collapse = " ")
  uibutton(name = name, label = label,
           icon = icon,
           class = class,
           ...)
}
