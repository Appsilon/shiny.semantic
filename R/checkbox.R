#' Create Semantic UI checkox
#'
#' This creates a checkbox using Semantic UI styles.
#'
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, childrens etc.)
#' @param type Type of checkbox to be used See \code{\link{checkbox_types}} for possible values.
#'
#' @export
uicheckbox <- function(..., type = "") {
  shiny::div(class = paste("ui checkbox", type), ...)
}

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
#' @examples
#' simple_checkbox("example", "Check me", is_marked = FALSE)
#'
#' @details
#' The inputs are updateable by using \code{\link[shiny]{updateCheckboxInput}}.
#'
#' @export
simple_checkbox <- function(id, label, type = "", is_marked = TRUE, style = NULL) {
  div(
    class = paste("ui", type, if (is_marked) "checked", "checkbox"), style = style,
    tags$input(id = id, type = "checkbox", checked = if (is_marked) NA else NULL),
    tags$label(label)
  )
}

#' 'checkbox_ui' is deprecated. Use 'simple_checkbox' instead.
#'
#' @inherit simple_checkbox
#' @export
checkbox_ui <- function(id, label, type = "", is_marked = TRUE, style = NULL) {
  .Deprecated("simple_checkbox")
  simple_checkbox(id, label, type, is_marked, style)
}

#' Create Semantic UI multiple checkbox
#'
#' This creates a multiple checkbox using Semantic UI styles.
#'
#' @param name Input name. Reactive value is available under input[[name]].
#' @param label Text to be displayed with checkbox.
#' @param choices List of values to show checkboxes for.
#'   If elements of the list are named then that name rather than the value is displayed to the user.
#' @param selected The value that should be chosen initially.
#'   If \code{NULL} the first one from \code{choices} is chosen.
#' @param position Specified checkmarks setup. Can be \code{grouped} or \code{inline}.
#' @param type Type of checkbox. Please check \code{\link{checkbox_types}} for possibilities.
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, childrens etc.)
#'
#' @export
multiple_checkbox <- function(name, label, choices, choices_value = choices,
                              selected = NULL, position = "grouped", type = NULL, ...) {
  choices_html <- tagList(lapply(seq_along(choices), function(x) {
    div(
      class = "field",
      div(
        class = paste("ui checkbox", type, if (choices[x] %in% selected) "checked"),
        tags$input(
          type = "checkbox", name = name, tabindex = "0", value = choices_value[x],
          checked = if (choices[x] %in% selected) NA else NULL
        ),
        tags$label(choices[x])
      )
    )
  }))

  shiny::div(
    id = name, class = paste(position, "fields"),
    tags$label(`for` = name, label),
    choices_html
  )
}

#' Create Semantic UI multiple radio buttons
#'
#' @description
#' This creates a multiple radiobox input using the Semantic UI style
#'
#' @param choices_value What reactive value should be used for corresponding
#' choice.
#'
#' @export
multiple_radio <- function(name, label, choices, choices_value = choices,
                           selected = choices_value[1], position = "grouped", ...) {
  choices_html <- tagList(lapply(seq_along(choices), function(x) {
    div(
      class = "field",
      div(
        class = paste("ui radio checkbox", if (choices[x] %in% selected) "checked"),
        tags$input(
          type = "radio", name = name, tabindex = "0", value = choices_value[x],
          checked = if (choices[x] %in% selected) NA else NULL
        ),
        tags$label(choices[x])
      )
    )
  }))

  shiny::div(
    id = name, class = paste(position, "fields"),
    tags$label(`for` = name, label),
    choices_html
  )
}
