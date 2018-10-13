library(shiny)
library(shiny.semantic)
library(magrittr)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Multiple checkbox example",
      uiOutput("sliders"),
      textOutput("result")
    )
  )
}

server <- shinyServer(function(input, output) {

  output$sliders <- renderUI({
    multiple_checkbox("chcbx", "Select type:", list("Type one" = "first", "Type two" = "second"), type = "slider",
      style = "margin: 1em;")
  })

  output$result <- renderText({
    input$chcbx
  })
})

shinyApp(ui = ui(), server = server)
