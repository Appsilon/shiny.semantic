#' Create dropdown Semantic UI component
#'
#' This creates a default dropdown using Semantic UI styles with Shiny input.
#' Dropdown is already initialized and available under input[[name]].
#'
#' @param name Input name. Reactive value is available under input[[name]].
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
#'
#'   library(shiny)
#'   library(shiny.semantic)
#'   ui <- function() {
#'       shinyUI(
#'         semanticPage(
#'           title = "Dropdown example",
#'           suppressDependencies("bootstrap"),
#'           uiOutput("dropdown"),
#'           p("Selected letter:"),
#'           textOutput("selected_letter")
#'        )
#'      )
#'   }
#'   server <- shinyServer(function(input, output) {
#'      output$dropdown <- renderUI({
#'          dropdown("simple_dropdown", LETTERS, value = "A")
#'      })
#'      output$selected_letter <- renderText(input[["simple_dropdown"]])
#'   })
#'
#'   shinyApp(ui = ui(), server = server)
#' }
#'
#' @export
dropdown <- function(name, choices, choices_value = choices,
                     default_text = "Select", value = NULL, type = "selection fluid") {
    if (!is.null(value)) value <- paste(as.character(value), collapse = ",")
    shiny::div(
      id = name, class = paste("ui", type, "dropdown semantic-select-input"),
      tags$input(type = "hidden", name = name, value = value),
      uiicon("dropdown"),
      shiny::div(class = "default text", default_text),
      uimenu(
        purrr::when(
          choices,
          is.null(names(.)) ~
            purrr::map2(
              choices, choices_value,
              ~ shiny::div(class = paste0(if (.y %in% value) "active ", "item"), `data-value` = .y, .x)
            ),
          !is.null(names(.)) ~
            purrr::map(
              seq_len(length(choices)), ~ {
                shiny::tagList(
                  menu_header(names(choices)[.x], is_item = FALSE),
                  menu_divider(),
                  purrr::map2(
                    choices[[.x]], choices_value[[.x]],
                    ~ shiny::div(class = paste0(if (.y %in% value) "active ", "item"), `data-value` = .y, .x)
                  )
                )
              }
            )
        )
      )
    )
}

#' Update dropdown Semantic UI component
#'
#' Change the value of a \code{\link{dropdown}} input on the client.
#'
#' @param session The \code{session} object passed to function given to \code{shinyServer}.
#' @param name The id of the input object
#' @param choices All available options one can select from. If no need to update then leave as \code{NULL}
#' @param choices_value What reactive value should be used for corresponding choice.
#' @param value The initially selected value.
#'
#' @export
update_dropdown <- function(session, name, choices = NULL, choices_value = choices, value = NULL) {
  if (!is.null(value)) value <- paste(as.character(value), collapse = ",") else value <- NULL
  if (!is.null(choices)) {
    options <- jsonlite::toJSON(data.frame(name = choices, text = choices, value = choices_value))
  } else {
    options <- NULL
  }

  message <- list(label = label, choices = options, value = value)
  message <- message[!vapply(message, is.null, FUN.VALUE = logical(1))]

  session$sendInputMessage(name, message)
}
