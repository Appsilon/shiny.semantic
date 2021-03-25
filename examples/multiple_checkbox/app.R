library(shiny)
library(shiny.semantic)
library(magrittr)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Multiple checkbox example",
      div(
        class = "ui form",
        multiple_checkbox(
          "chcbx", "Select type:", c("Type one", "Type two"), c("first", "second"),
          type = "slider", position = "inline"
        ),
        actionButton("chcbx_update", "Update Checkboxes"),
        textOutput("chcbx_result"),

        tags$br(),

        multiple_radio(
          "radio", "Select type:", c("Option one", "Option two"), c("first", "second"),
          "first", position = "inline"
        ),
        actionButton("radio_update", "Update Checkboxes"),
        textOutput("radio_result"),
      )
    )
  )
}

server <- shinyServer(function(input, output, session) {
  observeEvent(input$chcbx_update, {
    update_multiple_checkbox(
      session,
      "chcbx",
      choices = c("Type Three", "Type Four"),
      c("third", "fourth"),
      selected = c("third", "fourth"))
  })

  output$chcbx_result <- renderText({
    input$chcbx
  })

  observeEvent(input$radio_update, {
    update_multiple_radio(
      session,
      "radio",
      choices = c("Option Three", "Option Four"),
      c("third", "fourth"),
      selected = "third")
  })

  output$radio_result <- renderText({
    input$radio
  })
})

shinyApp(ui = ui(), server = server)
