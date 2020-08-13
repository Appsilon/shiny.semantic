#' Create Semantic UI Input
#'
#' This creates an input shell for the actual input
#'
#' @param ... Other arguments to be added as attributes of the tag (e.g. style, class or childrens etc.)
#' @param class Additional classes to add to html tag.
#'
#' @examples
#' #' ## Only run examples in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#' library(shiny.semantic)
#'
#' ui <- semanticPage(
#'   uiinput(icon("dog"),
#'           numeric_input("input", value = 0, label = "")
#'   )
#' )
#'
#' server <- function(input, output, session) {
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @seealso text_input
#'
#' @export
uiinput <- function(..., class = "") {
  div(class = paste("ui", class, "input"), ...)
}

#' Create Semantic UI Text Input
#'
#' This creates a default text input using Semantic UI. The input is available
#' under \code{input[[input_id]]}.
#'
#' @param input_id Input name. Reactive value is available under \code{input[[input_id]]}.
#' @param value Pass value if you want to have default text.
#' @param type Change depending what type of input is wanted. See details for options.
#' @param placeholder Text visible in the input when nothing is inputted.
#' @param attribs A named list of attributes to assign to the input.
#' @param label character with label put on the left from the input
#' @param width The width of the input, eg. "40px"
#'
#' @details
#' The following \code{type} s are allowed:
#' \itemize{
#' \item{text} {The standard input}
#' \item{textarea} {An extended space for text}
#' \item{password} {A censored version of the text input}
#' \item{email} {A special version of the text input specific for email addresses}
#' \item{url} {A special version of the text input specific for URLs}
#' \item{tel} {A special version of the text input specific for telephone numbers}
#' }
#'
#' The inputs are updateable by using \code{\link[shiny]{updateTextInput}} or
#' \code{\link[shiny]{updateTextAreaInput}} if \code{type = "textarea"}.
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'   library(shiny)
#'   library(shiny.semantic)
#'   ui <- semanticPage(
#'     uiinput(
#'       text_input("ex", label = "Your text", type = "text", placeholder = "Enter Text")
#'     )
#'   )
#'   server <- function(input, output, session) {
#'  }
#'  shinyApp(ui, server)
#'  }
#' @rdname text_input
#' @export
text_input <- function(input_id, label = NULL, value = "", type = "text",
                       placeholder = NULL, attribs = list()) {
  if (!type %in% c("text", "textarea", "password", "email", "url", "tel")) {
    stop(type, " is not a valid Semantic UI input")
  }

  if (type == "textarea") {
    input <- tags$textarea(id = input_id, value = value, placeholder = placeholder)
  } else {
    input <- tags$input(id = input_id, value = value, type = type, placeholder = placeholder)
  }

  for (i in names(attribs)) input$attribs[[i]] <- attribs[[i]]
  if (is.null(label))
    input
  else
    uiinput(
      tags$label(label),
      input
    )

}

#' Create a semantic Text Area input
#'
#' Create a text area input control for entry of unstructured text values.
#'
#' @param inputId Input name. Reactive value is available under \code{input[[input_id]]}.
#' @param label character with label put above the input
#' @param value Pass value if you want to have default text.
#' @param width The width of the input, eg. "40px"
#' @param placeholder Text visible in the input when nothing is inputted.
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#' ui <- semanticPage(
#'   textAreaInput("a", "Area:", width = "200px"),
#'   verbatimTextOutput("value")
#' )
#' server <- function(input, output, session) {
#'   output$value <- renderText({ input$a })
#' }
#' shinyApp(ui, server)
#' }
#' @export
textAreaInput <- function(inputId, label, value = "", width = NULL, placeholder = NULL) {
  shiny::div(
    class = "ui form",
    style = if (!is.null(width)) glue::glue("width: {shiny::validateCssUnit(width)};"),
    shiny::div(class = "field",
               if (!is.null(label)) tags$label(label, `for` = inputId),
               text_input(inputId, value,
                          placeholder = placeholder, type = "textarea")
    )
  )
}

#' @param inputId Input name. The same as \code{input_id}.
#' @rdname text_input
#' @export
textInput <- function(inputId, label, value = "", width = NULL,
                      placeholder = NULL, type = "text") {
  shiny::div(
    class = "ui form",
    style = if (!is.null(width)) glue::glue("width: {shiny::validateCssUnit(width)};"),
    shiny::div(class = "field",
               if (!is.null(label)) tags$label(label, `for` = inputId),
               text_input(inputId, value, placeholder = placeholder, type = type)
    )
  )
}

#' Create Semantic UI Numeric Input
#'
#' This creates a default numeric input using Semantic UI. The input is available
#' under \code{input[[input_id]]}.
#'
#' @param input_id Input name. Reactive value is available under \code{input[[input_id]]}.
#' @param value Initial value of the numeric input.
#' @param min Minimum allowed value.
#' @param max Maximum allowed value.
#' @param step Interval to use when stepping between min and max.
#' @param type Input type specifying class attached to input container.
#'   See [Fomantic UI](https://fomantic-ui.com/collections/form.html) for details.
#' @param icon Icon or label attached to numeric input.
#' @param placeholder Inner input label displayed when no value is specified.
#' @param ... Unused.
#' @param label character with label
#'
#' @details
#' The inputs are updateable by using \code{\link{updateNumericInput}}.
#' @rdname numeric_input
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'   library(shiny)
#'   library(shiny.semantic)
#'   ui <- semanticPage(
#'     numeric_input("ex", "Select number", 10),
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
#'
#' @export
numeric_input <- function(input_id, label, value, min = NA, max = NA, step = NA,
                           type = NULL, icon = NULL, placeholder = NULL, ...) {
  if (!is.numeric(value) & !grepl("^\\d*(\\.\\d*|)$", value)) stop("Non-numeric input detected")

  input_tag <- tags$input(id = input_id, value = value, type = "number")
  if (!is.na(min)) input_tag$attribs$min <- min
  if (!is.na(max)) input_tag$attribs$max <- max
  if (!is.na(step)) input_tag$attribs$step <- step
  if (!is.null(icon)) {
    type <- paste(type, "icon")
  }
  shiny::div(class = "field",
    if (!is.null(label)) tags$label(label, `for` = input_id),
    shiny::div(
      class = paste("ui", type, "input"),
      input_tag,
      icon
    )
  )
}

#' Create a numeric input control
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value of the numeric input.
#' @param min Minimum allowed value.
#' @param max Maximum allowed value.
#' @param step Interval to use when stepping between min and max.
#' @param width The width of the input.
#' @param ... Other parameters passed to \code{\link{numeric_input}} like \code{type} or \code{icon}.
#' @rdname numeric_input
#' @export
numericInput <- function(inputId, label, value,
                         min = NA, max = NA, step = NA, width = NULL, ...) {
  shiny::div(
    class = "ui form",
    style = if (!is.null(width)) glue::glue("width: {shiny::validateCssUnit(width)};"),
    numeric_input(inputId, label, value, min, max, step, ...)
  )
}

#' Change numeric input value and settings
#'
#' @param session The session object passed to function given to shinyServer.
#' @param input_id The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#' @param min Minimum value.
#' @param max Maximum value.
#' @param step Step size.
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#' library(shiny.semantic)
#'
#' ui <- semanticPage(
#'   slider_input("slider_in", 5, 0, 10),
#'   numeric_input("input", "Numeric input:", 0)
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$slider_in, {
#'     x <- input$slider_in
#'
#'     update_numeric_input(session, "input", value = x)
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#' @export
#' @rdname update_numeric_input
update_numeric_input <- function(session, input_id, label = NULL, value = NULL,
                                 min = NULL, max = NULL, step = NULL) {
  shiny::updateNumericInput(session, input_id, label = label, value = value,
                            min = min, max = max, step = step)
}

#' @param inputId the same as \code{input_id}
#' @export
#' @rdname update_numeric_input
updateNumericInput <- shiny::updateNumericInput
