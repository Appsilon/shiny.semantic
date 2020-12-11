if (interactive()) {
  #' Server code used for all examples
  server <- function(input, output) {
    output$plot1 <- renderPlot(plot(cars))
    output$plot2 <- renderPlot(plot(pressure))
    output$plot3 <- renderPlot(plot(AirPassengers))
  }
  #' Equal sizing
  ui <- semanticPage(
    split_layout(
      plotOutput("plot1"),
      plotOutput("plot2")
    )
  )
  shinyApp(ui, server)
  #' Custom widths
  ui <- semanticPage(
    split_layout(cell_widths = c("25%", "75%"),
                 plotOutput("plot1"),
                 plotOutput("plot2")
    )
  )
  shinyApp(ui, server)
  #' All cells at 300 pixels wide, with cell padding
  #' and a border around everything
  ui <- semanticPage(
    split_layout(
      cell_widths = 300,
      cell_args = "padding: 6px;",
      style = "border: 1px solid silver;",
      plotOutput("plot1"),
      plotOutput("plot2"),
      plotOutput("plot3")
    )
  )
  shinyApp(ui, server)
}
