## Only run examples in interactive R sessions
if (interactive()){
  library(shiny)
  library(shiny.semantic)
  
  ui <- shinyUI(semanticPage(
    segment(),
    # placeholder
    segment(class = "placeholder segment"),
    # raised
    segment(class = "raised segment"),
    # stacked
    segment(class = "stacked segment"),
    #  piled
    segment(class = "piled segment")
  ))
  server <- shinyServer(function(input, output) {
  })
  
  shinyApp(ui, server)
}
