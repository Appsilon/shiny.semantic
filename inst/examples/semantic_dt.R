if (interactive()){
  library(shiny)
  library(shiny.semantic)
  
  ui <- semanticPage(
    semantic_DTOutput("table")
  )
  server <- function(input, output, session) {
    output$table <- DT::renderDataTable(
      semantic_DT(iris)
    )
  }
  shinyApp(ui, server)
}
