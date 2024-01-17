#' Create dropdown Semantic UI component
#'
#' This creates a default *dropdown_input* using Semantic UI styles with Shiny input.
#' Dropdown is already initialized and available under input[[input_id]].
#'
#' @param input_id Input name. Reactive value is available under input[[input_id]].
#' @param choices All available options one can select from.
#' @param choices_value What reactive value should be used for corresponding
#' choice.
#' @param default_text Text to be visible on dropdown when nothing is selected.
#' @param value Pass value if you want to initialize selection for dropdown.
#' @param type Change depending what type of dropdown is wanted.
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#' library(shiny.semantic)
#' ui <- semanticPage(
#'   title = "Dropdown example",
#'   dropdown_input("simple_dropdown", LETTERS, value = "A"),
#'   p("Selected letter:"),
#'   textOutput("dropdown")
#' )
#' server <- function(input, output) {
#'   output$dropdown <- renderText(input[["simple_dropdown"]])
#' }
#'
#' shinyApp(ui = ui, server = server)
#' }
#'
#' @export
dropdown_input <- function(input_id, choices, choices_value = choices,
                     default_text = "Select", value = NULL, type = "selection fluid") {
    if (!is.null(value)) {
      value <- paste(as.character(value), collapse = ",")
    }
    shiny::div(
      id = input_id, class = paste("ui", type, "dropdown semantic-select-input"),
      tags$input(type = "hidden", name = input_id, value = value),
      icon("dropdown"),
      shiny::div(class = "default text", default_text),
      menu(
        if (is.null(names(choices))) {
          purrr::map2(
            choices, choices_value,
            ~ shiny::div(class = "item", `data-value` = .y, .x)
          )
        } else {
          purrr::map(
            seq_len(length(choices)), ~ {
              shiny::tagList(
                menu_header(names(choices)[.x], is_item = FALSE),
                menu_divider(),
                purrr::map2(
                  choices[[.x]], choices_value[[.x]],
                  ~ shiny::div(class = "item", `data-value` = .y, .x)
                )
              )
            }
          )
        }
      )
    )
}

#' Create a select list input control
#'
#' Create a select list that can be used to choose a single or multiple items from a list of values.
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param choices List of values to select from. If elements of the list are named,
#'   then that name — rather than the value — is displayed to the user.
#' @param selected The initially selected value (or multiple values if multiple = TRUE).
#'   If not specified then defaults to the first value for single-select lists and no
#'   values for multiple select lists.
#' @param multiple Is selection of multiple items allowed?
#' @param width The width of the input.
#' @param ... Arguments passed to \link{dropdown_input}.
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#'   library(shiny.semantic)
#'
#'   # basic example
#'   shinyApp(
#'     ui = semanticPage(
#'       selectInput("variable", "Variable:",
#'                   c("Cylinders" = "cyl",
#'                     "Transmission" = "am",
#'                     "Gears" = "gear")),
#'       tableOutput("data")
#'     ),
#'     server = function(input, output) {
#'       output$data <- renderTable({
#'         mtcars[, c("mpg", input$variable), drop = FALSE]
#'       }, rownames = TRUE)
#'     }
#'   )
#' }
#'
#' @export
selectInput <- function(inputId, label, choices, selected = NULL, multiple = FALSE, width = NULL, ...) {

  args <- list(...)
  args_names <- names(args)

  if ("selectize" %in% args_names) {
    message("'selectize' is shiny::selectInput specific parameter")
    args$selectize <- NULL
  }
  if ("size" %in% args_names) {
    message("'size' is shiny::selectInput specific parameter")
    args$size <- NULL
  }
  if (!("type" %in% args_names))
    args$type <- "fluid selection"
  if (multiple)
    args$type <- paste(args$type, "multiple")
  if (is.null(selected) && !multiple)
    selected <- choices[1]
  if (!("default_text" %in% args_names))
    args$default_text <- ""

  args$input_id <- inputId
  named_choices <- !is.null(attr(choices, "names"))
  args$choices <- if (named_choices) names(choices) else choices
  args$choices_value <- unname(choices)
  args$value <- selected

  shiny::div(
    class = "ui form",
    style = if (!is.null(width)) glue::glue("width: {shiny::validateCssUnit(width)};"),
    shiny::div(class = "field",
      if (!is.null(label)) tags$label(label, `for` = inputId),
      do.call(dropdown_input, args)
    )
  )
}

#' Update dropdown Semantic UI component
#'
#' Change the value of a \code{\link{dropdown_input}} input on the client.
#'
#' @param session The \code{session} object passed to function given to \code{shinyServer}.
#' @param input_id The id of the input object
#' @param choices All available options one can select from. If no need to update then leave as \code{NULL}
#' @param choices_value What reactive value should be used for corresponding choice.
#' @param value The initially selected value.
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(shiny.semantic)
#'
#' ui <- function() {
#'   shinyUI(
#'     semanticPage(
#'       title = "Dropdown example",
#'       dropdown_input("simple_dropdown", LETTERS[1:5], value = "A", type = "selection multiple"),
#'       p("Selected letter:"),
#'       textOutput("selected_letter"),
#'       shiny.semantic::actionButton("simple_button", "Update input to D")
#'     )
#'   )
#' }
#'
#' server <- shinyServer(function(input, output, session) {
#'   output$selected_letter <- renderText(paste(input[["simple_dropdown"]], collapse = ", "))
#'
#'   observeEvent(input$simple_button, {
#'     update_dropdown(session, "simple_dropdown", value = "D")
#'   })
#' })
#'
#' shinyApp(ui = ui(), server = server)
#'
#' }
#'
#' @export
update_dropdown_input <- function(session, input_id, choices = NULL, choices_value = choices, value = NULL) {
  if (!is.null(value)) value <- paste(as.character(value), collapse = ",") else value <- NULL
  if (!is.null(choices)) {
    options <- jsonlite::toJSON(list(values = data.frame(name = choices, text = choices, value = choices_value)))
  } else {
    options <- NULL
  }

  message <- list(choices = options, value = value)
  message <- message[!vapply(message, is.null, FUN.VALUE = logical(1))]

  session$sendInputMessage(input_id, message)
}

#' Change the value of a select input on the client
#'
#' Update selecInput widget
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param choices List of values to select from. If elements of the list are named,
#'   then that name — rather than the value — is displayed to the user.
#' @param selected The initially selected value (or multiple values if multiple = TRUE).
#'   If not specified then defaults to the first value for single-select lists and no
#'   values for multiple select lists.
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#'   ui <- semanticPage(
#'     p("The checkbox group controls the select input"),
#'     multiple_checkbox("checkboxes", "Input checkbox",
#'                       c("Item A", "Item B", "Item C")),
#'     selectInput("inSelect", "Select input",
#'                 c("Item A", "Item B"))
#'   )
#'
#'   server <- function(input, output, session) {
#'     observe({
#'       x <- input$checkboxes
#'
#'       # Can use character(0) to remove all choices
#'       if (is.null(x))
#'         x <- character(0)
#'
#'       # Can also set the label and select items
#'       updateSelectInput(session, "inSelect",
#'                         label = paste(input$checkboxes, collapse = ", "),
#'                         choices = x,
#'                         selected = tail(x, 1)
#'       )
#'     })
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @export
updateSelectInput <- function(session, inputId, label = NULL, choices = NULL, selected = NULL) {
  if (!is.null(selected)) selected <- paste(as.character(selected), collapse = ",") else selected <- NULL
  if (!is.null(choices)) {
    choices_text <- names(choices)
    if (identical(choices_text, NULL))
      choices_text <- choices
    options <- jsonlite::toJSON(list(values = data.frame(name = choices_text, text = choices_text, value = choices)))
  } else {
    options <- NULL
  }
  message <- list(label = label, choices = options, value = selected)
  message <- message[!vapply(message, is.null, FUN.VALUE = logical(1))]

  session$sendInputMessage(inputId, message)
}

#' Themes changer dropdown
#'
#' @param input_id Id of dropdown. \code{input[[input_id]]} returns the currently selected theme.
#' @param label Dropdown label.
#'
#' @examples
#'
#' if (interactive()) {
#' library(shiny)
#'  library(shiny.semantic)
#'   ui <- semanticPage(
#'     theme = "superhero",
#'     actionButton("action_button", "Press Me!"),
#'     textOutput("button_output"),
#'     theme_selector(),
#'     textOutput("theme")
#'   )
#'   server <- function(input, output, session) {
#'     output$button_output <- renderText(as.character(input$action_button))
#'     output$theme <- renderText(as.character(input$theme))
#'   }
#'   shinyApp(ui, server)
#' }
#'
#' @export
theme_selector <- function(input_id = "theme", label = "Choose theme") {
  dropdown_content <- dropdown_input(
    "theme", choices = c("default", semantic.assets::SUPPORTED_THEMES),
    choices_value = c("", semantic.assets::SUPPORTED_THEMES),
    type = "selection fluid themes-dropdown"
  )
  shiny::div(
    class = "ui form theme",
    shiny::div(class = "field",
               if (!is.null(label)) tags$label(label, `for` = input_id),
               dropdown_content
    )
  )
}
