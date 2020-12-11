## Only run examples in interactive R sessions
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  
  ui <- shinyUI(
    semanticPage(
      rating_input("rate", "How do you like it?", max = 5,
                   icon = "heart", color = "yellow"),
      numeric_input("numeric_in", "", 0, min = 0, max = 5)
    )
  )
  server <- function(session, input, output) {
    observeEvent(input$numeric_in, {
      x <- input$numeric_in
      update_rating_input(session, "rate", value = x)
    }
    )
  }
  shinyApp(ui = ui, server = server)
}
