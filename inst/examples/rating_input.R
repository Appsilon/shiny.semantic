## Only run examples in interactive R sessions
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  
  ui <- shinyUI(
    semanticPage(
      rating_input("rate", "How do you like it?", max = 5,
                   icon = "heart", color = "yellow"),
    )
  )
  server <- function(input, output) {
    observeEvent(input$rate,{print(input$rate)})
  }
  shinyApp(ui = ui, server = server)
}
