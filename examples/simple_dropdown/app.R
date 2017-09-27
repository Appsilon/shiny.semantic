library(shiny)
library(shiny.semantic)

ui <- function() {
  shinyUI(
    semantic_page(
      title = "Dropdown example",
      uiOutput("dropdown"),
      p("Selected letter:"),
      textOutput("selected_letter")
    )
  )
}

server <- shinyServer(function(input, output) {
  output$dropdown <- renderUI({
    dropdown("simple_dropdown", LETTERS, value = "A")
    })
  output$selected_letter <- renderText(input[["simple_dropdown"]])
})

shinyApp(ui = ui(), server = server)
