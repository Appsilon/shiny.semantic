#' Create Semantic UI icon tag
#'
#' This creates an icon tag using Semantic UI styles.
#'
#' @param type A name of an icon. Look at http://semantic-ui.com/elements/icon.html for all possibilities.
#' @param ... Other arguments to be added as attributes of the tag (e.g. style, class etc.)
#'
#' @export
uiicon <- function(type = "", ...) {
  shiny::tags$i(class = paste(type, "icon"), ...)
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

  shiny::tagList(
    shiny::div(class = paste("ui selection fluid dropdown", unique_dropdown_class),
               shiny_text_input(name, shiny::tags$input(type = "hidden", name = name), value = value),
               uiicon("dropdown"),
               shiny::div(class = "default text", default_text),
               shiny::div(class = "menu",
                          purrr::map2(choices, choices_value, ~ div(class = "item", `data-value` = .y, .x))
               )
    ),
    shiny::tags$script(paste0("$('.ui.dropdown.", unique_dropdown_class, "').dropdown().dropdown('set selected', '", value,"');"))
  )
}

#' Create Semantic UI tabs
#'
#' This creates tabs with content using Semantic UI styles.
#'
#' @param tabs A list of tabs. Each tab is a list of two elements - first element defines menu item, second element defines tab content.
#' @param id Id of the menu element (default: randomly generated id)
#' @param menu_class Class for the menu element (default: "top attached tabular")
#' @param tab_content_class Class for the tab content (default: "bottom attached segment")
#'
#' @export
tabset <- function(tabs, id = generate_random_id("menu"), menu_class = "top attached tabular", tab_content_class = "bottom attached segment") {
  identifiers <- replicate(length(tabs), list(id = generate_random_id("tab")), simplify = FALSE)
  tabsWithId <- purrr::map2(identifiers, tabs, ~ c(.x, .y))

  shiny::tagList(
    shiny::div(id = id,
               class = paste("ui menu", menu_class),
               purrr::map(tabsWithId, ~
                            shiny::a(class = paste("item", if (.$id == tabsWithId[[1]]$id) "active" else ""),
                                     `data-tab`=.$id,
                                     .$menu
                            )
               )
    ),
    purrr::map(tabsWithId, ~
                 shiny::div(class = paste("ui tab", tab_content_class, if (.$id == tabsWithId[[1]]$id) "active" else ""),
                            `data-tab`=.$id,
                            .$content
                 )
    ),
    shiny::tags$script(paste0("$('#", id, ".menu .item').tab();"))
  )
}

generate_random_id <- function(prefix, id_length = 20) {
  random_id <- paste(sample(letters, id_length, replace = TRUE), collapse = "")
  paste0(prefix, "-", random_id)
}
