#' Create Semantic UI checkbox
#'
#' This creates a checkbox using Semantic UI styles.
#'
#' @param id Input name. Reactive value is available under input[[name]].
#' @param label Text to be displayed with checkbox.
#' @param type Type of checkbox. Please check \code{checkbox_types} for possibilities.
#' @param is_marked Defines if checkbox should be marked. Default TRUE.
#' @param style Style of the widget.
#'
#' @export
checkbox_ui <- function(id, label, type = "", is_marked = TRUE, style = NULL) {
  if (!(type %in% checkbox_types)) {
    stop("Wrong type selected. Please check checkbox_types for possibilities.")
  }
  value <- if (is_marked) {
    "true"
  } else {
    "false"
  }
  selector <- paste0('.checkbox.', id)
  tagList(
    shiny_text_input(id, tags$input(type = "text", style = 'display:none'), value = value),
    div(
      style = style,
      class = paste("ui toggle checkbox", id),
      tags$input(type="checkbox", tags$label(label))
    ),
    tags$script(js_for_toggle_input(selector, id)),
    if (value == "true") tags$script(paste0("$('", selector, "').checkbox('set checked')")) else NULL
  )
}

js_for_toggle_input <- function(selector, input_id) {
  paste0("$('", selector, "').checkbox({
         onChecked: function() {
         $('#", input_id, "').val('true');
         $('#", input_id, "').change();
         },
         onUnchecked: function() {
         $('#", input_id, "').val('false');
         $('#", input_id, "').change();
         }});")
}
