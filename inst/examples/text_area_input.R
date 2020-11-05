## Only run examples in interactive R sessions
if (interactive()) {
  ui <- semanticPage(
    textAreaInput("a", "Area:", width = "200px"),
    verbatimTextOutput("value")
  )
  server <- function(input, output, session) {
    output$value <- renderText({ input$a })
  }
  shinyApp(ui, server)
}
