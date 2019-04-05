library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semanticPage(
      actionButton("show", "Show modal dialog")
    )
  )
}

server = function(input, output) {
  observeEvent(input$show, {
    create_modal(modal(
      id = "simple-modal",
      title = "Important message",
      "This is an important message!"
    ))
  })
}

shinyApp(ui = ui(), server = server)
