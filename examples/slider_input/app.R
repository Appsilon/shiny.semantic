library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Id slider example",
      suppressDependencies("bootstrap"),
      suppressDependencies("semantic"),
      shiny.semantic::slider_input("my_slider", 0, 10, 5, step = 1, color = "red"),
      br(),
      textOutput("val")
    )
  )
}

server <- shinyServer(function(input, output) {
  output$val <- renderPrint({
    input$my_slider
  })
})

shinyApp(ui = ui(), server = server)
