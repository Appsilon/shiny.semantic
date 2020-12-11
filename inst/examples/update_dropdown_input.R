if (interactive()) {
  
  library(shiny)
  library(shiny.semantic)
  
  ui <- function() {
    shinyUI(
      semanticPage(
        title = "Dropdown example",
        dropdown_input("simple_dropdown", LETTERS[1:5], value = "A", type = "selection multiple"),
        p("Selected letter:"),
        textOutput("selected_letter"),
        shiny.semantic::actionButton("simple_button", "Update input to D")
      )
    )
  }
  
  server <- shinyServer(function(input, output, session) {
    output$selected_letter <- renderText(paste(input[["simple_dropdown"]], collapse = ", "))
    
    observeEvent(input$simple_button, {
      update_dropdown(session, "simple_dropdown", value = "D")
    })
  })
  
  shinyApp(ui = ui(), server = server)
  
}
