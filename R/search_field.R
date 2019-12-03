#' Create search field Semantic UI component
#'
#' This creates a default search field using Semantic UI styles with Shiny
#' input. Search field is already initialized and available under input[[name]].
#' Search will automatically route to the named API endpoint provided
#' as parameter. API response is expected to be a JSON with property fields
#' `title` and `description`.
#' See https://semantic-ui.com/modules/search.html#behaviors for more details.
#'
#' @param name Input name. Reactive value is available under input[[name]].
#' @param search_api_url Register custom API url with server JSON Response
#' containing fields `title` and `description`.
#' @param default_text Text to be visible on serach field when nothing
#' is selected.
#' @param value Pass value if you want to initialize selection for search field.
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' \dontrun{
#' if (interactive()) {
#' library(shiny)
#' library(shiny.semantic)
#' library(gapminder)
#' library(dplyr)
#'
#' ui <- function() {
#'   shinyUI(
#'     semanticPage(
#'       title = "Dropdown example",
#'       uiOutput("search_letters"),
#'       p("Selected letter:"),
#'       textOutput("selected_letters")
#'    )
#'   )
#' }
#'
#' server <- shinyServer(function(input, output, session) {
#'
#'  search_api <- function(gapminder, q) {
#'    has_matching <- function(field) {
#'      startsWith(field, q)
#'    }
#'    gapminder %>%
#'      mutate(country = as.character(country)) %>%
#'      select(country) %>%
#'      unique %>%
#'      filter(has_matching(country)) %>%
#'      head(5) %>%
#'      transmute(title = country,
#'                description = country)
#'  }
#'
#'  search_api_url <- register_search(session, gapminder, search_api)
#'  output$search_letters <- shiny::renderUI(
#'    search_field("search_result", search_api_url)
#'  )
#'  output$selected_letters <- renderText(input[["search_result"]])
#' })
#'}
#'
#'shinyApp(ui = ui(), server = server)
#'}
#' @export
#' @importFrom magrittr "%>%"
#' @import shiny
#'
search_field <- function(name,
                         search_api_url,
                         default_text = "Search",
                         value = "") {
  shiny::tagList(
    div(class = paste(name, "ui search"),
        div(class = "ui icon fluid input",
            shiny_input(name,
              # Hack: Setting "oninput" to "null" is a fix for reset of
              # selection, when using arrows as suggested here:
              # https://github.com/Semantic-Org/Semantic-UI/issues/3416
              tags$input(class = "prompt search field",
                         type = "text",
                         placeholder = default_text,
                         oninput = "null"),
              value = value
            ),
            uiicon("search")
        ),
        div(class = "results")
    ),
    HTML(paste0(
      "<script>
      $('.", name, "').search({
        apiSettings: {
          url: '", search_api_url, "&q={query}'
        },
        onSelect: function(result) {
          $('#", name, "').val(result.title).change();
        },
        selectFirstResult: true
      });</script>
      "
    ))
  )
}
