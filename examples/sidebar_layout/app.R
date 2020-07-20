library(shiny)
library(shiny.semantic)
library(glue)

ui <- function() {
  shinyUI(semanticPage(
    title = "Sidebar Layout Test",
    theme = "spacelab",
    sidebarLayout(
      sidebarPanel("Side Item 1", "Side Item 2", "Side Item 3", width = 20),
      mainPanel("Main 1", "Main 2", "Main 3", "Main 4"),
      mirrored = FALSE,
      min_height = "400px"
    )
  ))
}
#...............................................................................
server <- shinyServer(function(input, output) {})
shinyApp(ui = ui(), server = server)
