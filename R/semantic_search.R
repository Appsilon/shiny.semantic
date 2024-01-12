#' Define search type if multiple
#'
#' @param input_id character with name
#' @param multiple multiple flag
#' @keywords internal
define_selection_type <- function(input_id, multiple) {
  multiple_class <- switch(multiple, "multiple", NULL)
  classes <- c("ui", "fluid", "search", "selection",
              "dropdown", multiple_class, input_id)
  paste(classes, collapse = " ")
}

#' Add Semantic UI search selection dropdown based on REST API
#'
#' Define the (multiple) search selection dropdown input for retrieving remote
#' selection menu content from an API endpoint. API response is expected to be
#' a JSON with property fields `name` and `value`. Using a search selection
#' dropdown allows to search more easily through large lists.
#'
#' @param input_id Input name. Reactive value is available under input[[input_id]].
#' @param search_api_url Register API url with server JSON Response containing
#' fields `name` and `value`.
#' @param multiple TRUE if the dropdown should allow multiple selections,
#' FALSE otherwise (default FALSE).
#' @param default_text Text to be visible on dropdown when nothing is selected.
#'
#' @examples
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
search_selection_api <- function(input_id,
                                 search_api_url,
                                 multiple = FALSE,
                                 default_text = "Select") {
  selection_type <- define_selection_type(input_id, multiple)
  shiny::tagList(
    tags$div(class = selection_type,
             shiny_input(input_id,
                         tags$input(class = "prompt",
                                    type = "hidden",
                                    name = input_id),
                         type = "text"
             ),
             icon("search"),
             tags$div(class = "default text", default_text),
             tags$div(class = "menu")
    ),

    HTML(paste0("<script>$('.ui.dropdown.", input_id, "').dropdown({
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
#' @param input_id Input name. Reactive value is available under input[[input_id]].
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
search_selection_choices <- function(input_id,
                                     choices,
                                     value = NULL,
                                     multiple = FALSE,
                                     default_text = "Select",
                                     groups = NULL,
                                     dropdown_settings = list(forceSelection = FALSE)) {
  input_class <- define_selection_type(input_id, multiple)
  if (is.null(value)) {
    value <- ""
  }

  shiny::tagList(
    tags$div(class = input_class,
             shiny_input(input_id,
                         tags$input(class = "prompt",
                                    type = "hidden",
                                    name = input_id),
                         value = value,
                         type = "text"
             ),
             icon("search"),
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
        input_id, jsonlite::toJSON(dropdown_settings, auto_unbox = TRUE), value) #nolint
    )
  )
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
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(tibble)
#'   library(shiny.semantic)
#'   shinyApp(
#'     ui = semanticPage(
#'       textInput("txt", "Enter the car name (or subset of name)"),
#'       textOutput("api_url"),
#'       uiOutput("open_url")
#'     ),
#'     server = function(input, output, session) {
#'       api_response <- function(data, q) {
#'         has_matching <- function(field) {
#'           grepl(toupper(q), toupper(field), fixed = TRUE)
#'         }
#'         dplyr::filter(data, has_matching(car))
#'       }
#'
#'       search_api_url <- register_search(session,
#'                            tibble::rownames_to_column(mtcars, "car"), api_response)
#'
#'       output$api_url <- renderText({
#'        glue::glue(
#'         "Registered API url: ",
#'         "{session$clientData$url_protocol}//{session$clientData$url_hostname}",
#'         ":{session$clientData$url_port}/",
#'         "{search_api_url}&q={input$txt}"
#'         )
#'       })
#'
#'       output$open_url <- renderUI({
#'         tags$a(
#'           "Open", class = "ui button",
#'           href = glue::glue("./{search_api_url}&q={input$txt}"), target = "_blank"
#'         )
#'       })
#'     }
#'   )
#' }
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
