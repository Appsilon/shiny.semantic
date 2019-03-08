library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Modal example - Bind to target element",
      uiOutput("modalBind"),
      div(id = "modal-button", class = "ui button", "Open Modal")
    )
  )
}

server <- shinyServer(function(input, output) {

  output$modalBind <- renderUI({
    modal(
      "This is some example content",
      id = "bind-example-modal",
      header = "Example header",
      class = "tiny",
      target = "modal-button")
  })
})

shinyApp(ui = ui(), server = server)
