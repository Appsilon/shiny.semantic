library(shiny)
library(shiny.semantic)

ui <- shinyUI(
  semanticPage(
    numericInput("text_ex", "Label", min = 1, max = 2, value = 1.5, step = 0.1, width = "300px"),
    textOutput("text_ex"),
    actionButton("change", "Change Label")
  )
)

server <- shinyServer(function(input, output, session) {
  output$text_ex <- renderText({
    input$text_ex
  })
  observeEvent(input$change, {
    updateNumericInput(session, "text_ex", label = "New label", value = 10)
  })
})

shiny::shinyApp(ui, server)
