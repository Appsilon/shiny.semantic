library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semanticPage(
      actionButton("show", "Show modal dialog")
    )
  )
}

server <- shinyServer(function(input, output, session) {
  observeEvent(input$show, {
    create_modal(
    modal(
      id = "simple-modal",
      title = "Important message",
      header = "Example modal",
      content = "This modal will close after 3 sec.",
      footer = NULL,
    )
    )
    Sys.sleep(3)
    hide_modal(id = "simple-modal")
  })
})

shinyApp(ui = ui(), server = server)
