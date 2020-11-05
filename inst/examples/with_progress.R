## Only run examples in interactive R sessions
if (interactive()) {
  
  ui <- semanticPage(
    plotOutput("plot")
  )
  
  server <- function(input, output) {
    output$plot <- renderPlot({
      with_progress(message = 'Calculation in progress',
                    detail = 'This may take a while...', value = 0, {
                      for (i in 1:15) {
                        inc_progress(1/15)
                        Sys.sleep(0.25)
                      }
                    })
      plot(cars)
    })
  }
  
  shinyApp(ui, server)
}
