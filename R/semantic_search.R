#' define_selection_type
#'
#' @param name - string with object name
#' @param multiple - logical
define_selection_type <- function(name, multiple) {
  if (multiple == T) {
    paste("ui fluid multiple search selection dropdown", name)
  } else {
    paste("ui fluid search selection dropdown", name)
  }
}

#' semantic_search_api
#'
#' function defining the (multiple) search selection dropdown input using REST API
#'
#' @param name string with input name
#' @param search_api_url register api url
#' @param multiple logical indicating whether dropdown search is multiple (default FALSE)
#'
#' @export
semantic_search_api <- function(name, search_api_url, multiple = FALSE) {
  input_class <- define_selection_type(name, multiple)
  tagList(
    tags$div(class = input_class,
             shiny_input(name,
                         tags$input(class = "prompt", type = "hidden", name = name),
                         type = "text"
             ),
             uiicon("search"),
             tags$div(class = 'default text', "Select"),
             tags$div(class = 'menu')
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

#' semantic_search_choices
#'
#' function defining the (multiple) search selection dropdown input using provided choices
#'
#' @param name string with input name
#' @param choices vector or a list of choices to search through
#' @param multiple logical indicating whether dropdown search is multiple (default FALSE)
#'
#'@examples
#'\dontrun{
#'## server.R example of multiple dropdown search
#'function(input, output, session) {
#'choices <- LETTERS
#'output$letters_results <- shiny::renderUI(semantic_search_choices("serach_result", choices, multiple = TRUE))
#'}
#'
#'## ui.R
#'uiOutput("letters_results")
#'
#'}
#' @importFrom magrittr "%>%"
#' @export
semantic_search_choices <- function(name, choices, multiple = FALSE) {
  input_class <- define_selection_type(name, multiple)
  tagList(
    tags$div(class = input_class,
             shiny_input(name,
                         tags$input(class = "prompt", type = "hidden", name = name),
                         type = "text"
             ),
             uiicon("search"),
             tags$div(class = 'default text', "Select"),
             tags$div(class = 'menu',
                      choices %>% purrr::map(~div(class = "item", `data-value` = ., .) %>% shiny::tagList())
            )
    ),
    HTML(paste0("<script>$('.ui.dropdown.", name, "').dropdown({
                forceSelection: false
})</script>"
    ))
  )
}

#' register_search
#'
#' calls shiny session's registerDataObj to create REST API
#'
#' @param session shiny server session
#' @param search_query function providing a search query
#'
#' @export
register_search <- function(session, search_query) {
  session$registerDataObj("search_api", NULL, function(data, request) {
    query <- parseQueryString(request$QUERY_STRING)
    search_query <- query$q
    response <- jsonlite::toJSON(list(
      success = TRUE,
      results = search_query(search_query)
    ))
    shiny:::httpResponse(200, 'application/json', enc2utf8(response))
  })
}
