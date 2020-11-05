## Only run examples in interactive R sessions
if (interactive()) {
  
  library(shiny)
  library(shiny.semantic)
  ui <- function() {
    shinyUI(
      semanticPage(
        title = "Progress example",
        progress("progress", percent = 24, label = "{percent}% complete"),
        p("Progress completion:"),
        textOutput("progress")
      )
    )
  }
  server <- shinyServer(function(input, output) {
    output$progress <- renderText(input$progress)
  })
  
  shinyApp(ui = ui(), server = server)
}
