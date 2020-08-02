library(shiny)
library(shiny.semantic)
library(gapminder)
library(dplyr)

ui <- function() {
    shinyUI(
        semanticPage(
            title = "Dropdown example",
            uiOutput("search_countries"),
            p("Selected countries:"),
            textOutput("selected_countries")
          )
      )
  }

  server <- shinyServer(function(input, output, session) {

    search_api <- function(gapminder, q){
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

    search_api_url <- shiny.semantic::register_search(session, gapminder, search_api)
    output$search_countries <- shiny::renderUI(search_selection_api("search_result", search_api_url, multiple = TRUE))
    output$selected_countries <- renderText(input[["search_result"]])
    })

shinyApp(ui = ui(), server = server)
