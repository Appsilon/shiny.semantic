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
      div(id = "modal-render-button", class = "ui button", "Im a button binded to a modal with output content"),
      modal(
        uiOutput("modalRenderContent"),
        id = "render-example-modal",
        header = "This is a modal example with output content",
        class = "tiny",
        target = "modal-render-button",
        settings = list(c("transition", "fade"), c("closable", "false"))),
      div(id = "modal-button", class = "ui button", "Im a button binded by the modal target parameter"),
      actionButton("show", "I am an action button calling show_modal")
    )
  )
}

server <- shinyServer(function(input, output) {
  observeEvent(input$show, {
    show_modal('action-example-modal')
    shinyjs::delay(5000, hide_modal('action-example-modal'))
  })

  observeEvent(input$test, {
    browser()
  })

  output$modalBind <- renderUI({
    modal(
      "This is some example content",
      id = "bind-example-modal",
      header = "This is a modal example",
      class = "tiny",
      target = "modal-button",
      settings = list(c("transition", "fade"), c("closable", "false")))
  })

  output$modalAction <- renderUI({
    modal(
      "I am another modal that is hidden by hide_modal after a few seconds",
      id = "action-example-modal",
      header = "This is a modal example",
      footer = "",
      class = "tiny",
      settings = list(c("transition", "fade"), c("closable", "false")))

  })
  output$modalRenderContent <- renderUI({
    div("This is some example content that is inside an output on the server")
  })

})

shinyApp(ui = ui(), server = server)
