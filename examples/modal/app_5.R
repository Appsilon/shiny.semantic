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
      header = list(style = "background: lightcoral"),
      content = list(style = "background: lightblue", `data-custom` = "value", "This is an important message!"),
      p("This is also part of the content!")
    ))
  })
}

shinyApp(ui = ui(), server = server)
