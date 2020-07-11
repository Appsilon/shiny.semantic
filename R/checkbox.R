#' Create Semantic UI checkbox
#' @aliases checkbox_input
#' @aliases toggle
#'
#' This creates a checkbox using Semantic UI styles.
#'
#' @param id Input name. Reactive value is available under input[[name]].
#' @param label Text to be displayed with checkbox.
#' @param type Type of checkbox: NULL, 'toggle'
#' @param is_marked Defines if checkbox should be marked. Default TRUE.
#' @param style Style of the widget.
#'
#' @examples
#' checkbox_input("example", "Check me", is_marked = FALSE)
#'
#' if (interactive()){
#' ui <- semanticPage(
#'  shinyUI(
#'    toggle("tog1", "My Label", TRUE)
#'  )
#' )
#' server <- function(input, output, session) {
#'   observeEvent(input$tog1, {
#'     print(input$tog1)
#'   })
#' }
#' shinyApp(ui, server)
#' }
#' @details
#' The inputs are updateable by using \code{\link[shiny]{updateCheckboxInput}}.
#'
#' The following \code{type}s are allowed:
#' \itemize{
#' \item{NULL}{The standard checkbox (default)}
#' \item{toggle}{Each checkbox has a toggle form}
#' \item{slider}{Each checkbox has a simple slider form}
#' }
#'
#' @rdname checkbox
#' @export
checkbox_input <- function(id, label = "", type = NULL, is_marked = TRUE, style = NULL) {
  div(
    class = paste("ui", type, if (is_marked) "checked", "checkbox"), style = style,
    tags$input(id = id, type = "checkbox", checked = if (is_marked) NA else NULL),
    tags$label(label)
  )
}

#' @rdname checkbox
#' @export
toggle <- function(id, label = "", is_marked = TRUE, style = NULL) {
  checkbox_input(id, label, type = "toggle", is_marked = is_marked, style = style)
}

#' Create Semantic UI multiple checkbox
#'
#' This creates a multiple checkbox using Semantic UI styles.
#'
#' @param name Input name. Reactive value is available under \code{input[[name]]}.
#' @param label Text to be displayed with checkbox.
#' @param choices Vector of labels to show checkboxes for.
#' @param choices_value Vector of values that should be used for corresponding choice.
#'   If not specified, \code{choices} is used by default.
#' @param selected The value(s) that should be chosen initially.
#'   If \code{NULL} the first one from \code{choices} is chosen.
#' @param position Specified checkmarks setup. Can be \code{grouped} or \code{inline}.
#' @param type Type of checkbox or radio.
#' @param ... Other arguments to be added as attributes of the
#' tag (e.g. style, childrens etc.)
#'
#' @details
#' The following \code{type}s are allowed:
#' \itemize{
#' \item{NULL}{The standard checkbox (default)}
#' \item{toggle}{Each checkbox has a toggle form}
#' \item{slider}{Each checkbox has a simple slider form}
#' }
#'
#' @rdname multiple_checkbox
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'   # Checkbox
#'   library(shiny)
#'   library(shiny.semantic)
#'
#'   ui <- function() {
#'       shinyUI(
#'         semanticPage(
#'           title = "Checkbox example",
#'           h1("Checkboxes"),
#'           multiple_checkbox("checkboxes", "Select Letters", LETTERS[1:6], value = "A"),
#'           p("Selected letters:"),
#'           textOutput("selected_letters"),
#'           tags$br(),
#'           h1("Radioboxes"),
#'           multiple_radio("radioboxes", "Select Letter", LETTERS[1:6], value = "A"),
#'           p("Selected letter:"),
#'           textOutput("selected_letter")
#'        )
#'      )
#'   }
#'
#'   server <- shinyServer(function(input, output) {
#'      output$selected_letters <- renderText(paste(input$checkboxes, collapse = ", "))
#'      output$selected_letter <- renderText(input$radioboxes)
#'   })
#'
#'   shinyApp(ui = ui(), server = server)
#' }
#'
#' @export
multiple_checkbox <- function(name, label, choices, choices_value = choices,
                              selected = NULL, position = "grouped", type = NULL, ...) {
  choices_html <- tagList(lapply(seq_along(choices), function(x) {
    div(
      class = "field",
      div(
        class = paste("ui checkbox", type, if (choices_value[x] %in% selected) "checked"),
        tags$input(
          type = "checkbox", name = name, tabindex = "0", value = choices_value[x],
          checked = if (choices_value[x] %in% selected) NA else NULL
        ),
        tags$label(choices[x])
      )
    )
  }))

  shiny::div(
    id = name, class = paste(position, "fields shiny-input-checkboxgroup"),
    tags$label(`for` = name, label),
    choices_html,
    ...
  )
}

#' @rdname multiple_checkbox
#'
#' @export
multiple_radio <- function(name, label, choices, choices_value = choices,
                           selected = choices_value[1], position = "grouped",
                           type = "radio", ...) {
  choices_html <- tagList(lapply(seq_along(choices), function(x) {
    div(
      class = "field",
      div(
        class = paste("ui checkbox", type,  if (choices_value[x] %in% selected) "checked"),
        tags$input(
          type = "radio", name = name, tabindex = "0", value = choices_value[x],
          checked = if (choices_value[x] %in% selected) NA else NULL
        ),
        tags$label(choices[x])
      )
    )
  }))

  shiny::div(
    id = name, class = paste(position, "fields shiny-input-radiogroup"),
    tags$label(`for` = name, label),
    choices_html,
    ...
  )
}
