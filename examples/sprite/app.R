library(shiny.semantic)
library(shiny)

ui <- shinyUI(
  semanticPage(
#    tagList( 
    action_button("shiny", "Click me"),
    action_button("appsilon", "Click me"),
    textOutput("text")
  )
)

server <- function(input, output, session) {
  observeEvent(input$shiny, {
    output$text <- renderText("Shiny button clicked")
  })
  observeEvent(input$appsilon, {
    output$text <- renderText("Appsilon button clicked")
  })
}

shinyApp(ui, server)
  
