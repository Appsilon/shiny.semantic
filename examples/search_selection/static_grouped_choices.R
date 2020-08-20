library(shiny)
library(shiny.semantic)
library(gapminder)

countries <- unique(gapminder[, c("country", "continent")])

ui <- function() {
    shinyUI(
        semanticPage(
            title = "Dropdown example",
            uiOutput("search_letters"),
            p("Selected country:"),
            textOutput("selected_country")
          )
      )
  }

  server <- shinyServer(function(input, output, session) {
    choices <- countries$country
    groups <- countries$continent
    output$search_letters <- shiny::renderUI(
      search_selection_choices("search_result", choices, value = "Italy", multiple = TRUE, groups = groups))
    output$selected_country <- renderText(input[["search_result"]])
    })

shinyApp(ui = ui(), server = server)

