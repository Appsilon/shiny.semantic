#' Create Semantic UI checkbox
#' @aliases checkbox_input
#' @aliases toggle
#'
#' This creates a checkbox using Semantic UI styles.
#'
#' @param input_id Input name. Reactive value is available under `input[[name]]`.
#' @param label Text to be displayed with checkbox.
#' @param type Type of checkbox: NULL, 'toggle'
#' @param is_marked Defines if checkbox should be marked. Default TRUE.
#' @param style Style of the widget.
#' @param inputId same as `input_id`
#' @param value same as `is_marked`
#' @param width The width of the input (currently not supported, but check `style`)
#'
#' @example inst/examples/checkbox.R
#'
#' @details
#' The inputs are updateable by using [shiny::updateCheckboxInput()].
#'
#' The following `type`s are allowed:
#' \itemize{
#' \item{NULL}{ The standard checkbox (default)}
#' \item{toggle}{ Each checkbox has a toggle form}
#' \item{slider}{ Each checkbox has a simple slider form}
#' }
#'
#' @rdname checkbox
#' @export
checkbox_input <- function(input_id, label = "", type = NULL, is_marked = TRUE,
                           style = NULL) {
  div(
    class = paste("ui", type, if (is_marked) "checked", "checkbox"), style = style,
    tags$input(id = input_id, type = "checkbox", checked = if (is_marked) NA else NULL),
    tags$label(label)
  )
}

#' @rdname checkbox
#' @export
checkboxInput <- function(inputId, label = "", value = FALSE, width = NULL){
  warn_unsupported_args(c("width"))
  checkbox_input(inputId, label, is_marked = value)
}

#' @rdname checkbox
#' @export
toggle <- function(input_id, label = "", is_marked = TRUE, style = NULL) {
  checkbox_input(input_id, label, type = "toggle", is_marked = is_marked, style = style)
}

#' Create Semantic UI multiple checkbox
#'
#' This creates a multiple checkbox using Semantic UI styles.
#'
#' @param input_id Input name. Reactive value is available under `input[[input_id]]`.
#' @param label Text to be displayed with checkbox.
#' @param choices Vector of labels to show checkboxes for.
#' @param choices_value Vector of values that should be used for corresponding choice.
#'   If not specified, `choices` is used by default.
#' @param selected The value(s) that should be chosen initially.
#'   If `NULL` the first one from `choices` is chosen.
#' @param position Specified checkmarks setup. Can be `grouped` or `inline`.
#' @param type Type of checkbox or radio.
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, childrens etc.)
#'
#' @details
#' The following `type`s are allowed:
#' \itemize{
#' \item{NULL}{The standard checkbox (default)}
#' \item{toggle}{Each checkbox has a toggle form}
#' \item{slider}{Each checkbox has a simple slider form}
#' }
#'
#' @rdname multiple_checkbox
#'
#' @example inst/examples/multiple_checkbox.R
#'
#' @export
multiple_checkbox <- function(input_id, label, choices, choices_value = choices,
                              selected = NULL, position = "grouped", type = NULL, ...) {
  choices_html <- tagList(lapply(seq_along(choices), function(x) {
    div(
      class = "field",
      div(
        class = paste("ui checkbox", type, if (choices_value[x] %in% selected) "checked"),
        tags$input(
          type = "checkbox", name = input_id, tabindex = "0", value = choices_value[x],
          checked = if (choices_value[x] %in% selected) NA else NULL
        ),
        tags$label(choices[x])
      )
    )
  }))

  shiny::div(
    id = input_id, class = paste(position, "fields shiny-input-checkboxgroup"),
    tags$label(`for` = input_id, label),
    choices_html,
    ...
  )
}

#' @rdname multiple_checkbox
#'
#' @export
multiple_radio <- function(input_id, label, choices, choices_value = choices,
                           selected = choices_value[1], position = "grouped",
                           type = "radio", ...) {
  choices_html <- tagList(lapply(seq_along(choices), function(x) {
    div(
      class = "field",
      div(
        class = paste("ui checkbox", type,  if (choices_value[x] %in% selected) "checked"),
        tags$input(
          type = "radio", name = input_id, tabindex = "0", value = choices_value[x],
          checked = if (choices_value[x] %in% selected) NA else NULL
        ),
        tags$label(choices[x])
      )
    )
  }))

  shiny::div(
    id = input_id, class = paste(position, "fields shiny-input-radiogroup"),
    tags$label(`for` = input_id, label),
    choices_html,
    ...
  )
}
