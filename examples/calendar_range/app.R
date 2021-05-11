library(shiny)
library(shiny.semantic)

ui <- semanticPage(
        title = "Calendar range example",
        div(
          class = "ui form",
          div(
            class = "two fields",
            div(
              class = "field",
              calendar(
                input_id = "start_date",
                type = "date",
                value = "2020-02-20",
                min = "2020-01-01",
                max = "2020-03-01",
                end_calendar_id = "end_date"
              )
            ),
            div(
              class = "field",
              calendar(
                input_id = "end_date",
                type = "date",
                value = "2020-02-23",
                min = "2020-01-01",
                max = "2020-03-01",
                start_calendar_id = "start_date"
              )
            )
          ),
          div(
            class = "two fields",
            div(class = "field", textOutput("start_date_value")),
            div(class = "field", textOutput("end_date_value"))
          )
        )
      )

server <- function(input, output, session) {
  output$start_date_value <- renderText({
    as.character(input$start_date)
  })

  output$end_date_value <- renderText({
    as.character(input$end_date)
  })
}

shinyApp(ui = ui, server = server)
