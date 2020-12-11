if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  ui <- semanticPage(
    theme = "superhero",
    actionButton("action_button", "Press Me!"),
    textOutput("button_output"),
    theme_selector(),
    textOutput("theme")
  )
  server <- function(input, output, session) {
    output$button_output <- renderText(as.character(input$action_button))
    output$theme <- renderText(as.character(input$theme))
  }
  shinyApp(ui, server)
}
