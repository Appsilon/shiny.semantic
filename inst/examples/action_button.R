if (interactive()){
  library(shiny)
  library(shiny.semantic)
  ui <- shinyUI(semanticPage(
    actionButton("action_button", "Press Me!"),
    textOutput("button_output")
  ))
  server <- function(input, output, session) {
    output$button_output <- renderText(as.character(input$action_button))
  }
  shinyApp(ui, server)
}
