#' Create Semantic UI Button
#'
#' @param name The \code{input} slot that will be used to access the value.
#' @param label The contents of the button or link
#' @param icon An optional \code{\link{uiicon}()} to appear on the button.
#' @param type An optional attribute to be added to the button's class.
#' @param ... Named attributes to be applied to the button
#'
#' @examples
#' uibutton("simple_button", "Press Me!")
#'
#' @export
uibutton <- function(name, label, icon = NULL, type = NULL, ...) {
  tags$button(id = name, class = paste("ui", type, "button"), label, icon, ...)
}
