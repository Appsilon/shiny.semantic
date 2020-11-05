## Only run examples in interactive R sessions
if (interactive()){
  library(shiny)
  library(shiny.semantic)
  
  ui <- shinyUI(semanticPage(
    header(title = "Header with description", description = "Description"),
    header(title = "Header with icon", description = "Description", icon = "dog")
  ))
  server <- shinyServer(function(input, output) {
  })
  
  shinyApp(ui, server)
}
