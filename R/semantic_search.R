#' Define search type if multiple
#'
#' @param name character with name
#' @param multiple multiple flag
define_selection_type <- function(name, multiple) {
  multiple_class <- switch(multiple, "multiple", NULL)
  classes <- c("ui", "fluid", "search", "selection",
              "dropdown", multiple_class, name)
  paste(classes, collapse = " ")
}

#' Add Semantic UI search selection dropdown based on REST API
#'
#' Define the (multiple) search selection dropdown input for retrieving remote
#' selection menu content from an API endpoint. API response is expected to be
#' a JSON with property fields `name` and `value`. Using a search selection
#' dropdown allows to search more easily through large lists.
#'
#' @param name Input name. Reactive value is available under input[[name]].
#' @param search_api_url Register API url with server JSON Response containing
#' fields `name` and `value`.
#' @param multiple TRUE if the dropdown should allow multiple selections,
#' FALSE otherwise (default FALSE).
#' @param default_text Text to be visible on dropdown when nothing is selected.
#'
#'#'@examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'    library(shiny)
#'    library(shiny.semantic)
#'    library(gapminder)
#'    library(dplyr)
#'
#'    ui <- function() {
#'     shinyUI(
#'       semanticPage(
#'         title = "Dropdown example",
#'         uiOutput("search_letters"),
#'         p("Selected letter:"),
#'         textOutput("selected_letters")
#'       )
#'     )
#'   }
#'
#'   server <- shinyServer(function(input, output, session) {
#'
#'    search_api <- function(gapminder, q) {
#'      has_matching <- function(field) {
#'         startsWith(field, q)
#'       }
#'       gapminder %>%
#'         mutate(country = as.character(country)) %>%
#'         select(country) %>%
#'         unique %>%
#'         filter(has_matching(country)) %>%
#'         head(5) %>%
#'           transmute(name = country,
#'                   value = country)
#'     }
#'
#'     search_api_url <- shiny.semantic::register_search(session,
#'                                                       gapminder,
#'                                                       search_api)
#'     output$search_letters <- shiny::renderUI(
#'       search_selection_api("search_result", search_api_url, multiple = TRUE)
#'     )
#'     output$selected_letters <- renderText(input[["search_result"]])
#'   })
#'
#'   shinyApp(ui = ui(), server = server)
#' }
#'
#' @import shiny
#' @export
search_selection_api <- function(name,
                                 search_api_url,
                                 multiple = FALSE,
                                 default_text = "Select") {
  selection_type <- define_selection_type(name, multiple)
  shiny::tagList(
    tags$div(class = selection_type,
             shiny_input(name,
                         tags$input(class = "prompt",
                                    type = "hidden",
                                    name = name),
                         type = "text"
             ),
             uiicon("search"),
             tags$div(class = "default text", default_text),
             tags$div(class = "menu")
    ),

    HTML(paste0("<script>$('.ui.dropdown.", name, "').dropdown({
                  forceSelection: false,
                  apiSettings: {
                    url: '", search_api_url, "&q={query}'
                  }
                })</script>"
    ))
  )
}

#' Add Semantic UI search selection dropdown based on provided choices
#'
#' Define the (multiple) search selection dropdown input component serving
#' search options using provided choices.
#'
#' @param name Input name. Reactive value is available under input[[name]].
#' @param choices Vector or a list of choices to search through.
#' @param value String with default values to set when initialize the component.
#' Values should be delimited with a comma when multiple to set. Default NULL.
#' @param multiple TRUE if the dropdown should allow multiple selections,
#' FALSE otherwise (default FALSE).
#' @param default_text Text to be visible on dropdown when nothing is selected.
#' @param groups Vector of length equal to choices, specifying to which group the choice belongs.
#'    Specifying the parameter enables group dropdown search implementation.
#' @param dropdown_settings Settings passed to dropdown() semantic-ui method.
#' See https://semantic-ui.com/modules/dropdown.html#/settings
#'
#'@examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'   library(shiny)
#'   library(shiny.semantic)
#'
#'   ui <- function() {
#'     shinyUI(
#'       semanticPage(
#'         title = "Dropdown example",
#'         uiOutput("search_letters"),
#'         p("Selected letter:"),
#'         textOutput("selected_letters")
#'       )
#'     )
#'   }
#'
#'   server <- shinyServer(function(input, output, session) {
#'     choices <- LETTERS
#'     output$search_letters <- shiny::renderUI(
#'       search_selection_choices("search_result", choices, multiple = TRUE)
#'     )
#'     output$selected_letters <- renderText(input[["search_result"]])
#'   })
#'
#'   shinyApp(ui = ui(), server = server)
#' }
#' @importFrom magrittr "%>%"
#' @import shiny
#' @export
search_selection_choices <- function(name,
                                     choices,
                                     value = NULL,
                                     multiple = FALSE,
                                     default_text = "Select",
                                     groups = NULL,
                                     dropdown_settings = list(forceSelection = FALSE)) {
  input_class <- define_selection_type(name, multiple)
  if (is.null(value)) {
    value <- ""
  }

  shiny::tagList(
    tags$div(class = input_class,
             shiny_input(name,
                         tags$input(class = "prompt",
                                    type = "hidden",
                                    name = name),
                         value = value,
                         type = "text"
             ),
             uiicon("search"),
             tags$div(class = "default text", default_text),
             tags$div(class = "menu",
               if (is.null(choices)) {
                 NULL
               } else if (is.null(groups)) {
                 purrr::map(choices, ~
                   div(class = "item", `data-value` = ., .)
                 )  %>% shiny::tagList()
               } else {
                 group_levels <- unique(groups)
                 group_choices <- purrr::map(group_levels, ~ choices[groups == .])
                 divide_choices <- function(group, group_specific_choices) {
                   shiny::tagList(
                     div(class = "ui horizontal divider", style = "border-top: none !important;", group),
                     purrr::map(group_specific_choices, ~
                       div(class = "item", `data-value` = ., .)
                     )
                   )
                 }
                 purrr::map2(group_levels, group_choices, divide_choices) %>%
                   shiny::tagList()
               }
            )
    ),
    HTML(
      sprintf(
        "<script>$('.ui.dropdown.%s').dropdown(%s).dropdown('set selected', '%s'.split(','));</script>",
        name, jsonlite::toJSON(dropdown_settings, auto_unbox = TRUE), value) #nolint
    )
  )
}

#' ::: hack solution
#'
#' @param pkg package name
#' @param name function name
#'
#' @return function
`%:::%` <- function(pkg, name) { # nolint
  pkg <- as.character(substitute(pkg))
  name <- as.character(substitute(name))
  get(name, envir = asNamespace(pkg), inherits = FALSE)
}

#' Register search api url
#'
#' Calls Shiny session's registerDataObj to create REST API.
#' Publishes any R object as a URL endpoint that is unique to Shiny session.
#' search_query must be a function that takes two arguments:
#' data (the value that was passed into registerDataObj) and req
#' (an environment that implements the Rook specification for HTTP requests).
#' search_query will be called with these values whenever an HTTP request is
#' made to the URL endpoint. The return value of search_query should be a list
#' of list or a dataframe. Note that different semantic components expect
#' specific JSON fields to be present in order to work correctly.
#' Check components documentation for details.
#'
#' @param session Shiny server session
#' @param data Data (the value that is passed into registerDataObj)
#' @param search_query Function providing a response as a list of
#' lists or dataframe of search results.
#'
#' @export
#' @import shiny
register_search <- function(session, data, search_query) {
  session$registerDataObj("search_api", data, function(data, request) { # nolint
    query <- shiny::parseQueryString(request$QUERY_STRING)
    extracted_query <- query$q
    response <- jsonlite::toJSON(list(
      success = TRUE,
      results = search_query(data, extracted_query)
    ))
    # Inspired by: https://stat.ethz.ch/pipermail/r-devel/2013-August/067210.html
    # It's because httpResponse is not exported from shiny
    # and triggers NOTE in R CMD check
    f <- "shiny" %:::% "httpResponse"
    f(200, "application/json", enc2utf8(response))
  })
}
