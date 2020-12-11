if (interactive() && require(gapminder)) {
  library(shiny)
  library(shiny.semantic)
  library(gapminder)
  library(dplyr)
  
  ui <- function() {
    shinyUI(
      semanticPage(
        title = "Dropdown example",
        p("Search country:"),
        uiOutput("search_country"),
        p("Selected country:"),
        textOutput("selected_country")
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
        transmute(title = country,
                  description = country)
    }
    
    search_api_url <- register_search(session, gapminder, search_api)
    output$search_letters <- shiny::renderUI(
      search_field("search_result", search_api_url)
    )
    output$selected_country <- renderText(input[["search_result"]])
  })
  
  shinyApp(ui = ui(), server = server)
}
