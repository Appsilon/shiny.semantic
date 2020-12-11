if (interactive()) {
  
  library(shiny)
  library(shiny.semantic)
  
  # Slider example
  ui <- shinyUI(
    semanticPage(
      title = "Slider example",
      tags$br(),
      slider_input("slider", 10, 0, 20),
      p("Selected value:"),
      textOutput("slider")
    )
  )
  
  server <- shinyServer(function(input, output, session) {
    output$slider <- renderText(input$slider)
  })
  
  shinyApp(ui = ui, server = server)
  
  # Range example
  ui <- shinyUI(
    semanticPage(
      title = "Range example",
      tags$br(),
      range_input("range", 10, 15, 0, 20),
      p("Selected values:"),
      textOutput("range")
    )
  )
  
  server <- shinyServer(function(input, output, session) {
    output$range <- renderText(paste(input$range, collapse = " - "))
  })
  
  shinyApp(ui = ui, server = server)
  
}
