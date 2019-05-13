library(shiny)
library(shiny.semantic)

ui <- shinyUI(
  semanticPage(
    title = "Id slider example",
    shiny.semantic::slider_input("my_slider", 1, 10, 10, step = 1, n_ticks = 10, color = "red"),
    br(),
    textOutput("val")
  )
)

server <- shinyServer(function(input, output) {
  output$val <- renderPrint({
    input$my_slider
  })
})

shinyApp(ui = ui, server = server)
