library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Modal example",
      uiOutput("modal"),
      div(id = "modal-button", class = "ui button", uiicon("user"),  "Icon button")
    )
  )
}

server <- shinyServer(function(input, output) {
  output$modal <- renderUI({
    modal(
      id = "example-modal-1",
      header = "This is a modal example",
      content = "This is some example content", 
      class = "tiny",
      target = "#modal-button",
      settings = list(c("transition", "fade"), c("closable", "false")))
    })
})

shinyApp(ui = ui(), server = server)
