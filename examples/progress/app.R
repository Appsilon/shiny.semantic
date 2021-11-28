library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  segment(
    class = "basic",
    progress("value_ex", value = 20, total = 100, label = "Label showing {value} of {total}"),
    tags$br(),
    button("button", "Change value to 40"),
    button("button4", "Change text to 'Updated Label'"),
    textOutput("value_ex"),
    tags$br(), tags$br(),

    progress(
      "percent_ex", percent = 35, progress_lab = TRUE, label = "{percent}% complete", label_complete = "All done!"
    ),
    tags$br(),
    button("button2", "Increase by 5%"),
    button("button3", "Decrease by 5%"),
    textOutput("percent_ex")
  )
)


server <- shinyServer(function(input, output, session) {
  output$value_ex <- renderText(input$value_ex)
  output$percent_ex <- renderText(input$percent_ex)

  observeEvent(input$button, update_progress(session, "value_ex", type = "value", value = 40))
  observeEvent(input$button4, update_progress(session, "value_ex", type = "label", value = "Updated Label"))
  observeEvent(input$button2, update_progress(session, "percent_ex", value = 5))
  observeEvent(input$button3, update_progress(session, "percent_ex", type = "decrement", value = 5))
})

shinyApp(ui = ui, server = server)
