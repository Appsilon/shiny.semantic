#' Define simple date input with Semantic UI styling
#'
#' @param input_id Input id.
#' @param label Label to be displayed with date input.
#' @param value Default date chosen for input.
#' @param min Minimum date that can be selected.
#' @param max Maximum date that can be selected.
#' @param style Css style for widget.
#' @param icon_name Icon that should be displayed on widget.
#'
#' @example inst/examples/date_input.R
#'
#' @export
#' @rdname date_input
date_input <- function(input_id, label = NULL, value = NULL, min = NULL, max = NULL,
                       style = NULL, icon_name = "calendar") {
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
               icon(icon_name))
    )
}

#' @param inputId Input id.
#' @param label Label to be displayed with date input.
#' @param value Default date chosen for input.
#' @param min Minimum date that can be selected.
#' @param max Maximum date that can be selected.
#' @param icon Icon that should be displayed on widget.
#' @param width character width of the object
#' @param ... other arguments
#'
#' @rdname date_input
#' @export
dateInput <- function(inputId, label = NULL, icon = NULL, value = NULL,
                      min = NULL, max = NULL, width = NULL, ...) {
  # TODO match arguments with shiny::dateInput
  args_list <- list(...)
  args_list$input_id <- inputId
  args_list$label <- label
  args_list$icon_name <- icon
  args_list$value <- value
  args_list$min <- min
  args_list$max <- max
  args_list$style <- if (!is.null(width)) paste0("width: ", width, "; ", args_list$style) else args_list$style
  do.call(date_input, args_list)
}
