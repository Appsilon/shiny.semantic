if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  list_content <- list(
    list(header = "Head", description = "Lorem ipsum", icon = "cat"),
    list(header = "Head 2", icon = "tree"),
    list(description = "Lorem ipsum 2", icon = "dog")
  )
  if (interactive()){
    ui <- semanticPage(
      list_container(list_content, is_divided = TRUE)
    )
    server <- function(input, output) {}
    shinyApp(ui, server)
  }
}
