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

#' Change the label or icon of an action button on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param icon The icon to set for the input object. To remove the current icon, use icon=character(0)
#' @export
updateActionButton <- function(session, inputId, label = NULL, icon = NULL) {
  message <- list(label = label, icon = as.character(icon))
  message <- message[!vapply(message, is.null, FUN.VALUE = logical(1))]

  session$sendInputMessage(inputId, message)
}
