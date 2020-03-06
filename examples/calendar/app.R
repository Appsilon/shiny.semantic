library(shiny)
library(shiny.semantic)
library(magrittr)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Multiple checkbox example",
      uicalendar("date", type = "date", value = "20.2.2020", placeholder = "Select Date", min = "2.2.2020", max = "25.2.2020"),
      uicalendar("month", type = "month", placeholder = "Pick Month"),
      textOutput("result"),
      uibutton("update", "update calendar")
    )
  )
}

server <- shinyServer(function(input, output) {

  output$result <- renderText({
    input$month
  })

  observeEvent(input$update, {
    update_calendar("date", value = "12.2.2020", min = "10.2.2020", max = "25.2.2020")
  })
})

shinyApp(ui = ui(), server = server)
