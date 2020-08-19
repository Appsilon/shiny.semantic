library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Modal example - Basic Modal with Server content",
      div(id = "modal-render-button", class = "ui button", "Open Modal"),
      modal(
        uiOutput("modalRenderContent"),
        id = "render-example-modal",
        header = list(class = "ui icon", icon("archive")),
        class = "basic tiny",
        target = "modal-render-button",
        settings = list(c("transition", "fade"), c("closable", "false")),
        modal_tags = icon("ui close")
      )
    )
  )
}

server <- shinyServer(function(input, output) {
  output$modalRenderContent <- renderUI({
    div("Example content from the server")
  })
})

shinyApp(ui = ui(), server = server)
