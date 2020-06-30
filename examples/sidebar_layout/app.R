library(shiny)
library(shiny.semantic)
library(glue)

ui <- function() {
  shinyUI(semanticPage(
    sidebar_layout(
      sidebar_panel("sidebar", width = 10),
      main_panel("main", width = 7),
      position = "left",
      fluid = TRUE
    )
  ))
}

server <- shinyServer(function(input, output) {})

shinyApp(ui = ui(), server = server)
