library(shiny)
library(shiny.semantic)
library(shinyjs)

ui <- function() {
  shinyUI(
    semanticPage(
      useShinyjs(),
      title = "Modal example",
      uiOutput("modalBind"),
      uiOutput("modalAction"),
      div(id = "modal-button", class = "ui button", "Im a button binded by the modal target parameter"),
      actionButton("show", "I am an action button calling show_modal")
    )
  )
}

server <- shinyServer(function(input, output) {
  observeEvent(input$show, {
    show_modal('#action-example-modal')
    shinyjs::delay(5000, remove_modal('#action-example-modal'))
  })

  output$modalBind <- renderUI({
    modal(
      id = "bind-example-modal",
      header = "This is a modal example",
      content = "This is some example content",
      class = "tiny",
      target = "#modal-button",
      settings = list(c("transition", "fade"), c("closable", "false")))
  })

  output$modalAction <- renderUI({
    modal(
      id = "action-example-modal",
      header = "This is a modal example",
      content = 'I am another modal that is hidden by hide_modal after a few seconds',
      footer = "",
      class = "tiny",
      settings = list(c("transition", "fade"), c("closable", "false")))

  })
})

shinyApp(ui = ui(), server = server)
