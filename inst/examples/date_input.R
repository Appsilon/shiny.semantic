if (interactive()) {
  # Below example shows how to implement simple date range input using `date_input`
  
  library(shiny)
  library(shiny.semantic)
  
  ui <- shinyUI(
    semanticPage(
      title = "Date range example",
      uiOutput("date_range"),
      p("Selected dates:"),
      textOutput("selected_dates")
    )
  )
  
  server <- shinyServer(function(input, output, session) {
    output$date_range <- renderUI({
      tagList(
        tags$div(tags$div(HTML("From")),
                 date_input("date_from", value = Sys.Date() - 30, style = "width: 10%;")),
        tags$div(tags$div(HTML("To")),
                 date_input("date_to", value = Sys.Date(), style = "width: 10%;"))
      )
    })
    
    output$selected_dates <- renderPrint({
      c(input$date_from, input$date_to)
    })
  })
  
  shinyApp(ui = ui, server = server)
}
