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
    choices <- LETTERS
    search_api_url <- register_search(session, iris)
    output$search_letters <- shiny::renderUI(search_selection_choices("search_result", choices, multiple = TRUE))
    output$selected_letters <- renderText(input[["search_result"]])
    })

shinyApp(ui = ui(), server = server)

