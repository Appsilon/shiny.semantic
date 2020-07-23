library(shiny)
library(shiny.semantic)

ui <- semanticPage(
  segment(
    class = "basic",
    range_input("range_ex", 5, 10, 0, 20, 1, class = "labeled ticked"),
    tags$br(),
    textOutput("range_ex"),
    tags$br(), tags$br(),
    slider_input("slider_ex", 5, 0, 20, 1),
    tags$br(),
    textOutput("slider_ex"),
    tags$br(), tags$br(),

    p("Update range to 10-17"),
    button("button", "Update")
  )
)


server <- shinyServer(function(input, output, session) {
  output$range_ex <- renderText(paste(input$range_ex, collapse = ", "))
  output$slider_ex <- renderText(input$slider_ex[1])
  observeEvent(input$button, update_range(session, "range_ex", 10, 17))
})

shinyApp(ui = ui, server = server)
