## Only run examples in interactive R sessions
if (interactive()) {
  library(shiny)
  library(shiny.semantic)
  
  ui <- semanticPage(
    title = "Hello Shiny Semantic!",
    tags$label("Number of observations:"),
    slider_input("obs", value = 500, min = 0, max = 1000),
    segment(
      plotOutput("dist_plot")
    )
  )
  
  server <- function(input, output) {
    output$dist_plot <- renderPlot({
      hist(rnorm(input$obs))
    })
  }
  
  shinyApp(ui, server)
}
