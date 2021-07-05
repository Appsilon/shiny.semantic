library(shiny)
library(shiny.semantic)

ui <- semanticPage(
        title = "Calendar range example",
        calendar_range(
          input_id = "calendar_range",
          start_value = "2020-02-20",
          end_value = "2020-03-20",
          min = "2020-01-01",
          max = "2020-12-01",
          start_placeholder = "Select range start",
          end_placeholder = "Select range end",
          start_label = "Start Date",
          end_label = "End Date"
        ),
        div(
          class = "two fields",
          div(class = "field", textOutput("start_date_value")),
          div(class = "field", textOutput("end_date_value"))
        ),
        action_button(input_id = "calendar_range_update", label = "Update calendar range")
      )

server <- function(input, output, session) {
  output$start_date_value <- renderText({
    as.character(input$calendar_range[1])
  })

  output$end_date_value <- renderText({
    as.character(input$calendar_range[2])
  })

  observeEvent(input$calendar_range_update, {
    update_calendar_range(
      session = session,
      input_id = "calendar_range",
      start_value = "2021-01-01",
      end_value = "2021-02-02",
      min = "2020-11-20",
      max = "2021-12-20"
    )
  })
}

shinyApp(ui = ui, server = server)
