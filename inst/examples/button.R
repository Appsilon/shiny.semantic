if (interactive()){
  library(shiny)
  library(shiny.semantic)
  ui <- semanticPage(
    shinyUI(
      button("simple_button", "Press Me!")
    )
  )
  server <- function(input, output, session) {
  }
  shinyApp(ui, server)
}
