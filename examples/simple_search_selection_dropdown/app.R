library(shiny)
library(shiny.semantic)

ui <- function() {
    shinyUI(
        semanticPage(
            title = "Dropdown example",
            suppressDependencies("bootstrap"),
            uiOutput("search_letters"),
            p("Selected letter:"),
            textOutput("selected_letters")
          )
      )
  }

  server <- shinyServer(function(input, output, session) {

    API_SEARCH_RESULTS_COUNT <- 2

    handler <- function(data, request) {
      query <- parseQueryString(request$QUERY_STRING)
      search_query <- query$q

      has_matching <- function(field) {
        startsWith(field, search_query)
      }

      data %>%
        filter(has_matching(Species)) %>%
        head(API_SEARCH_RESULTS_COUNT) %>%
        transmute(title = Species) %>%
        list(results = .) %>%
        jsonlite::toJSON() -> response
      shiny:::httpResponse(200, 'application/json', enc2utf8(response))
    }

    register_search <- function(session, data) {
      session$registerDataObj("iris_api", data, handler)
    }

    search_api_url <- register_search(session, iris)
    output$search_letters <- shiny::renderUI(semantic_search_choices("search_result", choices, multiple = TRUE))
    output$selected_letters <- renderText(input[["search_result"]])
    })

shinyApp(ui = ui(), server = server)

