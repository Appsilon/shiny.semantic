#' Create Semantic UI icon tag
#'
#' This creates an icon tag using Semantic UI styles.
#'
#' @param type A name of an icon. Look at http://semantic-ui.com/elements/icon.html for all possibilities.
#' @param ... Other arguments to be added as attributes of the tag (e.g. style, class etc.)
#'
#' @export
uiicon <- function(type = "", ...) {
  tags$i(class = paste(type, "icon"), ...)
}

#' Create dropdown Semantic UI component
#'
#' This creates a default dropdown using Semantic UI styles with Shiny input. Dropdown is already initialized
#' and available under input[[name]].
#'
#' @param name Input name. Reactive value is available under input[[name]].
#' @param choices All available options one can select from.
#' @param choices_value What reactive value should be used for corresponding choice.
#' @param default_text Text to be visible on dropdown when nothing is selected.
#' @param value Pass value if you want to initialize selection for dropdown.
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
dropdown <- function(name, choices, choices_value = choices, default_text = 'Select', value = NULL) {
  unique_dropdown_class <- paste0('dropdown_name_', name)

  tagList(
    div(class = paste("ui selection fluid dropdown", unique_dropdown_class),
      shiny_text_input(name, shiny::tags$input(type = "hidden", name = name), value = value),
      uiicon("dropdown"),
      div(class = "default text", default_text),
      div(class = "menu",
        purrr::map2(choices, choices_value, ~ div(class = "item", `data-value` = .y, .x))
      )
    ),
    tags$script(paste0("$('.ui.dropdown.", unique_dropdown_class, "').dropdown().dropdown('set selected', '", value,"');"))
  )
}
