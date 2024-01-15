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
#' \item{text} The standard input
#' \item{textarea} An extended space for text
#' \item{password} A censored version of the text input
#' \item{email} A special version of the text input specific for email addresses
#' \item{url} A special version of the text input specific for URLs
#' \item{tel} A special version of the text input specific for telephone numbers
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
    input <- tags$textarea(id = input_id, value, placeholder = placeholder)
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
#'   textAreaInput("a", "Area:", value = "200", width = "200px"),
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
               text_input(inputId, value = value,
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
               text_input(inputId, value = value, placeholder = placeholder, type = type)
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
#' Either `value` or `placeholder` should be defined.
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
numeric_input <- function(input_id, label, value = NULL, min = NA, max = NA, step = NA,
                           type = NULL, icon = NULL, placeholder = NULL, ...) {
  if (!(is.null(placeholder) || is.character(placeholder))) {
    stop ("'placeholder' should be NULL or character")
  }
  if (is.null(value) & is.null(placeholder)) stop ("either 'value' or 'placeholder' should be defined")
  if (!is.null(value)) {
    if (!is.numeric(value) & !grepl("^\\d*(\\.\\d*|)$", value)) stop("Non-numeric input detected")
  }

  input_tag <- tags$input(id = input_id, value = value, type = "number", placeholder = placeholder)
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
#' @param placeholder Inner input label displayed when no value is specified
#' @param ... Other parameters passed to \code{\link{numeric_input}} like \code{type} or \code{icon}.
#' @rdname numeric_input
#' @export
numericInput <- function(inputId, label, value = NULL, min = NA, max = NA,
                         step = NA, width = NULL, placeholder = NULL, ...) {
  shiny::div(
    class = "ui form",
    style = if (!is.null(width)) glue::glue("width: {shiny::validateCssUnit(width)};"),
    numeric_input(inputId, label, value, min, max, step, placeholder = placeholder, ...)
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

#' Create Semantic UI File Input
#'
#' This creates a default file input using Semantic UI. The input is available
#' under \code{input[[input_id]]}.
#'
#' @param input_id,inputId Input name. Reactive value is available under \code{input[[input_id]]}.
#' @param label Display label for the control, or NULL for no label.
#' @param multiple Whether the user should be allowed to select and upload multiple files at once.
#' @param accept A character vector of "unique file type specifiers" which gives the browser a hint as to the type
#'  of file the server expects. Many browsers use this prevent the user from selecting an invalid file.
#' @param type Input type specifying class attached to input container.
#'   See [Fomantic UI](https://fomantic-ui.com/collections/form.html) for details.
#' @param button_label,buttonLabel Display label for the button.
#' @param placeholder Inner input label displayed when no file has been uploaded.
#' @param ... Unused.
#'
#' @rdname file_input
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'   library(shiny)
#'   library(shiny.semantic)
#'   ui <- semanticPage(
#'     form(
#'       div(
#'         class = "ui grid",
#'         div(
#'           class = "four wide column",
#'           file_input("ex", "Select file"),
#'           header("File type selected:", textOutput("ex_file"))
#'         )
#'       )
#'     )
#'   )
#'   server <- function(input, output, session) {
#'     output$ex_file <- renderText({
#'       if (is.null(input)) return("No file uploaded")
#'       tools::file_ext(input$ex$datapath)
#'     })
#'   }
#'   shinyApp(ui, server)
#' }
#'
#' @export
file_input <- function(input_id, label, multiple = FALSE, accept = NULL, button_label = "Browse...",
                          type = NULL, placeholder = "no file selected", ...) {

  input_tag <- tags$input(id = input_id, name = input_id, type = "file", style = "display: none;")
  if (multiple) input_tag$attribs$multiple  <- "multiple"
  if (length(accept) > 0) input_tag$attribs$accept <- paste(accept, collapse = ",")

  shiny::div(
    class = "field",
    if (!is.null(label)) tags$label(`for` = input_id, label),
    tags$div(
      class = paste("ui", type, "left action input ui-ss-input"),
      tags$label(
        class = "ui labeled icon button btn-file",
        tags$i(class = "file icon"), button_label,
        input_tag
      ),
      tags$input(
        class = paste("ui", type, "text input"), type = "text", placeholder = placeholder, readonly = "readonly"
      )
    ),
    div(
      id = paste0(input_id, "_progress"), style = "margin-top: 0;",
      class = "ui indicating tiny progress ui-ss-progress-file",
      div(class = "bar"),
      div(class = "label")
    ),
    tags$script(paste0("$('#", paste0(input_id, "_progress"), "').progress();"))
  )
}

#' Create a file input control
#'
#' @param width The width of the input, e.g. \code{'400px'}, or \code{'100\%'}.
#' @param ... Other parameters passed from \code{fileInput} to \code{file_input} like \code{type}.
#' @rdname file_input
#' @export
fileInput <- function(inputId, label, multiple = FALSE, accept = NULL, width = NULL,
                      buttonLabel = "Browse...", placeholder = "No file selected", ...) {
  shiny::div(
    class = "ui form",
    style = if (!is.null(width)) glue::glue("width: {shiny::validateCssUnit(width)};"),
    file_input(inputId, label, multiple, accept, button_label = buttonLabel, placeholder = placeholder, ...)
  )
}
