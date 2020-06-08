library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semanticPage(
      title = "Rating example",
      rating("rating", "Rate this app"),
      p("Your rate:"),
      textOutput("your_rate"),
      uibutton("update", "Update rate")
    )
  )
}

server <- shinyServer(function(input, output, session) {
  output$your_rate <- renderText(input[["rating"]])

  observeEvent(input$update, {
    updateRating(session, "rating", "New label", 2)
  }, ignoreInit = TRUE)
})

shinyApp(ui = ui(), server = server)
