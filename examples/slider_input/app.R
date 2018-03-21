library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Dropdown example",
      suppressDependencies("bootstrap"),
      suppressDependencies("semantic"),
      tags$head(
        tags$script(src = "https://rawgit.com/gdaunton/Semantic-UI/range-slider-build/dist/semantic.js"),
        tags$link(rel="stylesheet", type="text/css", href="https://rawgit.com/gdaunton/Semantic-UI/range-slider-build/dist/semantic.css")
      ),
      uiOutput("slider", width = "200px"),
      br(),
      textOutput("val")
    )
  )
}

server <- shinyServer(function(input, output) {
  output$slider <- renderUI({
    shiny.semantic::sliderInput("my_slider", 0, 10, 5, color = "red")
  })
  output$val <- renderPrint({
    input$my_slider
  })
})

shinyApp(ui = ui(), server = server)
