# Basic calendar
if (interactive()) {
  
  library(shiny)
  library(shiny.semantic)
  
  ui <- shinyUI(
    semanticPage(
      title = "Calendar example",
      calendar("date"),
      p("Selected date:"),
      textOutput("selected_date")
    )
  )
  
  server <- shinyServer(function(input, output, session) {
    output$selected_date <- renderText(
      as.character(input$date)
    )
  })
  
  shinyApp(ui = ui, server = server)
}

# Calendar with max and min
calendar(
  name = "date_finish",
  placeholder = "Select End Date",
  min = "2019-01-01",
  max = "2020-01-01"
)

# Selecting month
calendar(
  name = "month",
  type = "month"
)
