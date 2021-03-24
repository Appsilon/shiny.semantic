library(shiny)
library(shiny.semantic)
library(magrittr)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Multiple checkbox example",
      tags$head(shiny::tags$script(src = "shiny.semantic/shiny-semantic-checkbox.js")),
      div(
        class = "ui form",
        div(
          class = "inline fields",
          multiple_checkbox(
            "chcbx", "Select type:", c("Type one", "Type two"), c("first", "second"),
            type = "slider"
          )
        ),
        actionButton("chcbx_update", "Update Checkboxes"),
        textOutput("chcbx_result"),

        div(
          class = "inline fields",
          multiple_radio(
            "radio", "Select type:", c("Option one", "Option two"), c("first", "second"), "first",
          )
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
      value = c("third", "fourth"))
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
      value = "third")
  })

  output$radio_result <- renderText({
    input$radio
  })
})

shinyApp(ui = ui(), server = server)
