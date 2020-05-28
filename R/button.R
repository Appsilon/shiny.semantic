#' Create Semantic UI Button
#'
#' @param name The \code{input} slot that will be used to access the value.
#' @param label The contents of the button or link
#' @param icon An optional \code{\link{uiicon}()} to appear on the button.
#' @param type An optional attribute to be added to the button's class. If used
#' paramters like \code{color}, \code{size} are ignored.
#' @param ... Named attributes to be applied to the button
#'
#' @examples
#' uibutton("simple_button", "Press Me!")
#'
#' @export
uibutton <- function(name, label, icon = NULL, type = NULL, ...) {
  tags$button(id = name, class = paste("ui", type, "button"), icon, " ", label, ...)
}

#' Action button
#'
#' Creates an action button  whose value is initially zero, and increments by one each time it is pressed.
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label The contents of the button - a text label, but you could also use any other HTML, like an image.
#' @param icon An optional \link{icon} to appear on the button.
#' @param width The width of the input.
#' @param ... Named attributes to be applied to the button or remaining parameters passed to uibutton, like \code{type}.
#'
#' @export
actionButton <- function(inputId, label, icon = NULL, width = NULL, ...) {
  args_list <- list(...)
  args_list$type = paste(args_list$class, args_list$type)
  args_list$class <- NULL
  args_list$name <- inputId
  args_list$label <- label
  args_list$icon <- icon
  args_list$style <- if (!is.null(width)) paste0("width: ", width, "; ", args_list$style) else args_list$style
  do.call(uibutton, args_list)
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
#' ui <- function() {
#'   semanticPage(
#'     shinyUI(
#'       actionbutton("button", "My button", icon = uiicon("user"),
#'                    size = "huge", color = "orange")
#'     )
#'   )
#' }
#' server <- function(input, output) {
#'   observeEvent(input$button,{
#'     print("Action")
#'   })
#' }
#' shinyApp(ui, server)
#' }
actionbutton <- function(name, label, icon = NULL, size = "medium",
                         color = NULL, ...) {
  value <- shiny::restoreInput(id = name, default = NULL)
  type <- paste(c(size, color, "action-button"), collapse = " ")
  uibutton(name = name, label = label,
           icon = icon,
           type = type,
           `data-val` = value,
           ...)
}
