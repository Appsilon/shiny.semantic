## Only run examples in interactive R sessions
if (interactive() && require(gapminder)) {
  library(shiny)
  library(shiny.semantic)
  library(gapminder)
  library(dplyr)
  
  ui <- function() {
    shinyUI(
      semanticPage(
        title = "Dropdown example",
        uiOutput("search_letters"),
        p("Selected letter:"),
        textOutput("selected_letters")
      )
    )
  }
  
  server <- shinyServer(function(input, output, session) {
    
    search_api <- function(gapminder, q) {
      has_matching <- function(field) {
        startsWith(field, q)
      }
      gapminder %>%
        mutate(country = as.character(country)) %>%
        select(country) %>%
        unique %>%
        filter(has_matching(country)) %>%
        head(5) %>%
        transmute(name = country,
                  value = country)
    }
    
    search_api_url <- shiny.semantic::register_search(session,
                                                      gapminder,
                                                      search_api)
    output$search_letters <- shiny::renderUI(
      search_selection_api("search_result", search_api_url, multiple = TRUE)
    )
    output$selected_letters <- renderText(input[["search_result"]])
  })
  
  shinyApp(ui = ui(), server = server)
}
