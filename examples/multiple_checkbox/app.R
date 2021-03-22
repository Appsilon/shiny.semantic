library(shiny)
library(shiny.semantic)
library(magrittr)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Multiple checkbox example",
      tags$head(shiny::tags$script(src = "shiny.semantic/shiny-semantic-checkbox.js")),
      multiple_checkbox(
        "chcbx", "Select type:", list("Type one" = "first", "Type two" = "second"), type = "slider", style = "margin: 1em;"
      ),
      actionButton("update", "Update Checkboxes"),
      textOutput("result")
    )
  )
}

server <- shinyServer(function(input, output, session) {
  observeEvent(input$update, {
    shiny::updateCheckboxGroupInput(session, "chcbx", choices = list("Type three" = "third", "Type four" = "fourth"))
  })

  output$result <- renderText({
    input$chcbx
  })
})

shinyApp(ui = ui(), server = server)
