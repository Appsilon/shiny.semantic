if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  ui <-semanticPage(
    counter_button("counter", "My Counter Button",
                   icon = icon("world"),
                   size = "big", color = "purple")
  )
  server <- function(input, output) {
    observeEvent(input$counter,{
      print(input$counter)
    })
  }
  shinyApp(ui, server)
}
