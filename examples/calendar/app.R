library(shiny)
library(shiny.semantic)

ui <- semanticPage(
        title = "Multiple checkbox example",
        calendar("date", type = "date", value = "2020-02-20", placeholder = "Select Date", min = "2020-01-01", max = "2020-03-01"),
        calendar("month", type = "month", placeholder = "Pick Month"),
        textOutput("result"),
        actionButton("update", "update calendar")
      )

server <- function(input, output, session) {

  output$result <- renderText({
    input$month
  })

  observeEvent(input$update, {
    update_calendar(session, "date", value = "2021-02-20", min = "2021-01-01", max = "2021-03-01")
  })
}

shinyApp(ui = ui, server = server)
