library(shiny.semantic)
menu_content <- list(
  list(name = "AA", link = "http://example.com", icon = "dog"),
  list(name = "BB", link = "#", icon="cat"),
  list(name = "CC")
)
if (interactive()){
  ui <- semanticPage(
    horizontal_menu(menu_content)
  )
  server <- function(input, output, session) {}
  shinyApp(ui, server)
}
