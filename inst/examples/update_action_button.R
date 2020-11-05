if (interactive()){
  library(shiny)
  library(shiny.semantic)
  
  ui <- semanticPage(
    actionButton("update", "Update button"),
    br(),
    actionButton("go_button", "Go")
  )
  
  server <- function(input, output, session) {
    observe({
      req(input$update)
      
      # Updates go_button's label and icon
      updateActionButton(session, "go_button",
                         label = "New label",
                         icon = icon("calendar"))
      
    })
  }
  shinyApp(ui, server)
}
