library(shiny)
library(shiny.semantic)

ui <- semanticPage(
        title = "Multiple checkbox example",
        calendar("date", type = "date", value = "02.20.2020", placeholder = "Select Date", min = "02.02.2020", max = "02.25.2020"),
        calendar("month", type = "month", placeholder = "Pick Month"),
        textOutput("result"),
        actionButton("update", "update calendar")
      )

server <- function(input, output, session) {

  output$result <- renderText({
    input$month
  })

  observeEvent(input$update, {
    update_calendar(session, "date", value = "02.12.2020", min = "02.10.2020", max = "02.26.2020")
  })
}

shinyApp(ui = ui, server = server)
