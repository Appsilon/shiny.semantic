if (interactive()) {
  library(shiny)
  library(tibble)
  library(shiny.semantic)
  shinyApp(
    ui = semanticPage(
      textInput("txt", "Enter the car name (or subset of name)"),
      textOutput("api_url"),
      uiOutput("open_url")
    ),
    server = function(input, output, session) {
      api_response <- function(data, q) {
        has_matching <- function(field) {
          grepl(toupper(q), toupper(field), fixed = TRUE)
        }
        dplyr::filter(data, has_matching(car))
      }
      
      search_api_url <- register_search(session,
                                        tibble::rownames_to_column(mtcars, "car"), api_response)
      
      output$api_url <- renderText({
        glue::glue(
          "Registered API url: ",
          "{session$clientData$url_protocol}//{session$clientData$url_hostname}",
          ":{session$clientData$url_port}/",
          "{search_api_url}&q={input$txt}"
        )
      })
      
      output$open_url <- renderUI({
        tags$a(
          "Open", class = "ui button",
          href = glue::glue("./{search_api_url}&q={input$txt}"), target = "_blank"
        )
      })
    }
  )
}
