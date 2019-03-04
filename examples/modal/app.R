library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Modal example - Static UI modal",
      div(id = "modal-open-button", class = "ui button", "Open Modal"),
      modal(
        div("Example content"),
        id = "example-modal",
        target = "modal-open-button"
      )
    )
  )
}

server <- shinyServer(function(input, output) {

})

shinyApp(ui = ui(), server = server)
