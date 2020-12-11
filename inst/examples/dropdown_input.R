## Only run examples in interactive R sessions
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  ui <- semanticPage(
    title = "Dropdown example",
    dropdown_input("simple_dropdown", LETTERS, value = "A"),
    p("Selected letter:"),
    textOutput("dropdown")
  )
  server <- function(input, output) {
    output$dropdown <- renderText(input[["simple_dropdown"]])
  }
  
  shinyApp(ui = ui, server = server)
}
