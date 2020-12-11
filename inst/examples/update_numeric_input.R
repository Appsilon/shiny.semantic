## Only run examples in interactive R sessions
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  
  ui <- semanticPage(
    slider_input("slider_in", 5, 0, 10),
    numeric_input("input", "Numeric input:", 0)
  )
  
  server <- function(input, output, session) {
    
    observeEvent(input$slider_in, {
      x <- input$slider_in
      
      update_numeric_input(session, "input", value = x)
    })
  }
  
  shinyApp(ui, server)
}
