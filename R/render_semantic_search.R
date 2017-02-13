#' semantic_search - function defining the (multiple) search selection dropdown input
#'
#' @param name - string with input name
#' @param serach_api_url - register api url
#' @param multiple - logical indicating whether dropdown search is multiple (default FALSE)
#'
#' @export
semantic_search <- function(name, search_api_url, multiple = FALSE) {
  input_class <- if (multiple == T) {
    "ui fluid multiple search selection dropdown"
  } else {
    "ui fluid search selection dropdown"
  }
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
    HTML(paste0("<script>$('.ui.dropdown').dropdown({
                forceSelection: false,
                apiSettings: {
                url: '", search_api_url, "&q={query}'
                }
})</script>"
    ))
  )
}

#' register_search
#'
#' @param session - shiny server session
#' @param search_query - function providing a search query
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

#' render_semantic_search - wrapper to render shiny semantic dropdown (multiple) search - semantic_search
#'
#' @param input_name - string containing input name
#' @param session - shiny server session
#' @param search_query - function providing a search query
#' @param multiple - logical if multiple search (TRUE)
#'
#' @export
render_semantic_search <- function(input_name, session, search_query, multiple) {
  shiny::renderUI(semantic_search(input_name, register_search(session, search_query), multiple))
}
