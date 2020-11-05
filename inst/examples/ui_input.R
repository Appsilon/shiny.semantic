#' ## Only run examples in interactive R sessions
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  
  ui <- semanticPage(
    uiinput(icon("dog"),
            numeric_input("input", value = 0, label = "")
    )
  )
  
  server <- function(input, output, session) {
  }
  
  shinyApp(ui, server)
}
