library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Id slider example",
      suppressDependencies("bootstrap"),
      suppressDependencies("semantic"),
      uiOutput("slider", width = "200px"),
      br(),
      textOutput("val")
    )
  )
}

server <- shinyServer(function(input, output) {
  output$slider <- renderUI({
    shiny.semantic::slider_input("my_slider", 0, 10, 5, color = "red")
  })
  output$val <- renderPrint({
    input$my_slider
  })
})

shinyApp(ui = ui(), server = server)
